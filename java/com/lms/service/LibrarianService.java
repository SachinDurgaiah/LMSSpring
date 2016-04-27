package com.lms.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.lms.dao.AuthorDAO;
import com.lms.dao.BookCopiesDAO;
import com.lms.dao.BookDAO;
import com.lms.dao.BookLoansDAO;
import com.lms.dao.BorrowerDAO;
import com.lms.dao.GenreDAO;
import com.lms.dao.LibraryBranchDAO;
import com.lms.dao.PublisherDAO;
import com.lms.entity.Author;
import com.lms.entity.Book;
import com.lms.entity.LibraryBranch;

public class LibrarianService {

	

	@Autowired
	AuthorDAO adao;
	
	@Autowired
	BookDAO bDAO;
	
	@Autowired
	BookLoansDAO blDAO;
	
	@Autowired
	BorrowerDAO brDAO;
	
	@Autowired
	GenreDAO gDAO;
	
	@Autowired
	LibraryBranchDAO lbDAO;
	
	@Autowired
	PublisherDAO pDAO;
	
	@Autowired
	BookCopiesDAO bcDAO;
	
	
	public void UpdateDetails_branches(LibraryBranch branch) throws ClassNotFoundException, SQLException{
		
		lbDAO.updateLirbaryBranch(branch);
		
	}

	public List<LibraryBranch> getAllBranches() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
			return lbDAO.readAllBranches();
		
	}
	
	/*public List<Book> getAllBooks() throws ClassNotFoundException, SQLException{
		ConnectionUtil c = new ConnectionUtil();
		Connection conn = c.getConnection();
		try{
			BookDAO bdao = new BookDAO(conn);
			return bdao.readAllBooks();
		}catch (Exception e){
			e.printStackTrace();
			//conn.rollback();
		}finally{
			conn.close();
		}
		return null;
	}*/

	/////////////////// Display all the books with authors...
	/////////////////// Update the no of copies..............
	
	public Integer GetNumberOfCopies(Book book,LibraryBranch branch) throws ClassNotFoundException, SQLException{
	
			return bcDAO.CheckBookInbranch(book,branch);
	}
	
	
	
	public void UpdateBookCopies(Book book,LibraryBranch branch,Integer copies) throws ClassNotFoundException, SQLException{
	
			Integer bookExistance = bcDAO.CheckBookInbranch(book,branch); 
			
			if(bookExistance==0){
				//insert the book in the tbl_book_copies
				bcDAO.Insertbook_copies(book,branch,copies);
			}
			else{//update the book copies of the existing entry
				bcDAO.Updatebook_copies(book,branch,copies);
			}
		
	}

	public LibraryBranch getBranchByID(Integer branchId) throws ClassNotFoundException, SQLException {
	
			return lbDAO.readAuthorsByID(branchId);
		
	}
	
	
	
}
