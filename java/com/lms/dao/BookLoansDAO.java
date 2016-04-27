package com.lms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.lms.dao.BaseDAO;
import com.lms.entity.Author;
import com.lms.entity.Book;
import com.lms.entity.BookLoans;
import com.lms.entity.Borrower;
import com.lms.entity.LibraryBranch;
import com.lms.entity.Publisher;

public class BookLoansDAO extends BaseDAO implements ResultSetExtractor<List<BookLoans>>{

	

	

	//checking for a book if they are already checked-out by the borrower. 
	public boolean CheckForbooks(Book book, Borrower borrower) throws ClassNotFoundException, SQLException {
		//Integer result = getCount("select count(*) from tbl_book_loans where bookId = ? and cardNo= ? and dateIn is NULL", new Object[] {book.getBookId(),borrower.getCardNo()});
		
		SqlRowSet count=template.queryForRowSet("select count(*) from tbl_book_loans where bookId = ? and cardNo= ? and dateIn is NULL", new Object[] {book.getBookId(),borrower.getCardNo()});
        int res = count.getInt("count(*)");
	 
		//return res;
		
		
		if(res ==0){
			return true;
		}
		else{
			return false;
		}
	}

	//inserting a new book to the Book loans table.
	public void CheckOutbook(int book_id, int card_no,int branch_id) throws ClassNotFoundException, SQLException {
		System.out.println("Final step of bookloaning");
		try{
			System.out.println("bookId "+book_id);
			System.out.println("branchID "+branch_id);
			System.out.println("CardNo "+card_no);
			template.update("insert into tbl_book_loans (bookId, branchId, cardNo, dateOut, dueDate ) "
				+ "values( ?, ?, ?,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 15 DAY))",new Object[] {book_id,branch_id,card_no});
		System.out.println("entry added to the book loans table");
		template.update("update tbl_book_copies set noOfCopies = noOfCopies-1 where bookId=? and branchId =?", new Object[] {book_id,branch_id});
		}
		catch(Exception e){
		System.out.println(e);
		}
	}

	//updating the number of copies after updating the number of copies.
	public void UpdateBooksafterCheckOutbook(Book book, LibraryBranch branch) throws ClassNotFoundException, SQLException {
	
		template.update("update tbl_book_copies set noOfCopies = noOfCopies-1 where bookId=? and brachId =?", new Object[] {book.getBookId(),branch.getBranchId()});
	}

	public void CheckInbook(Book book, LibraryBranch branch, Borrower borrower) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		template.update("update tbl_book_loans set dateIn = CURDATE() where bookId=? and brachId =? and cardNo = ?", new Object[] {book.getBookId(),borrower.getCardNo()});
	}

	
	public List<BookLoans> extractData(ResultSet rs) throws SQLException {
	 
		List<Book> books = new ArrayList<Book>();
		//Here i am returning the books that a borrower has checked out.
		BookDAO bdao = new BookDAO();
		while(rs.next()){
			Book a = new Book();
			a.setBookId(rs.getInt("bookId"));
			a.setTitle(rs.getString("title"));
			Publisher p = new Publisher();
			p.setPublisherId(rs.getInt("pubId"));
			a.setPubId(rs.getInt("pubId"));
		
			books.add(a);
		}
		//return books;
		return null;

	}



	public void renew(String cardNo1, String bookId1) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		int cardNo=Integer.parseInt(cardNo1);
		int bookId=Integer.parseInt(bookId1);
		System.out.println("renewing");
		try{
			template.update("update tbl_book_loans set dueDate=DATE_ADD(CURDATE(),INTERVAL 25 DAY) where bookId=? and cardNo=?",new Object[] {bookId,cardNo});
		}
		catch(Exception e){
			System.out.println(e);
		}
	}



	public void returnbook(String cardNo1, String bookId1) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		System.out.println("In return book in boooks in BookloansDAO");
		final int c_no=Integer.parseInt(cardNo1);
		final int b_id=Integer.parseInt(bookId1);
		//int branch_id = getC("select branchId from tbl_book_loans where bookId=? and cardNo = ? and dateIn is NULL", new Object[] {b_id,c_no});
		
		final String cardNo = cardNo1;
		final String bookId = bookId1;
		final String INSERT_SQL = "select branchId from tbl_book_loans where bookId=? and cardNo = ? and dateIn is NULL ";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		template.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
				PreparedStatement ps = connection.prepareStatement(INSERT_SQL, new String[] { "id" });
				ps.setInt(1, b_id);
				ps.setInt(2, c_no);
				return ps;
			}
		}, keyHolder);
		int branch_id = keyHolder.getKey().intValue();
		
		//return bookId;
		
		
		System.out.println("branch id: "+branch_id);
		template.update("delete from tbl_book_loans where bookId=? and branchId=? and cardNo = ?",new Object[] {b_id,branch_id,c_no});
		System.out.println("book returned.");
		template.update("update tbl_book_copies set noOfCopies = noOfCopies+1 where bookId=? and branchId =?", new Object[] {b_id,branch_id});
		
	}
	
	
	

}
