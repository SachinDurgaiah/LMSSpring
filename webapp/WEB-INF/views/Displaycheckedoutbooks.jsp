
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.AdministratorService" %>
     <%@ include file="include.html"%>
    <% int cardN=0;
    out.println("entered the function");
    if(request.getAttribute("cardNo")!=null){
    	cardN = (Integer)request.getAttribute("cardNo");
    	//out.println("Got the card number");
    	}
    	AdministratorService service = new AdministratorService();
    	List<Book> book =new ArrayList<Book>(); 
    	Integer bookCount = service.getBookCount1(cardN);
    	if (request.getAttribute("book") != null) {
			book = (List<Book>)request.getAttribute("book");
		}else{
			book = service.getAllBooksOfBorrower(cardN,1);	
		}
		
    	//List<Book> book = service.getAllBooksOfBorrower(cardN);
    %>
<script type="text/javascript">
function returnBook(bookId,cardNo){
	$.ajax({
		  url: "returnBook",
		  data:{
			
			  cardNo:cardNo,
			  bookId: bookId
		  }
		}).done(function(data) {
		  $('#bookTable').html(data);
		});
}
</script>
<h2>Select a book that you want to return.</h2>
${result}

<nav>
	<ul class="pagination">
		<li><a href="#" aria-label="Previous"> <span
				aria-hidden="true">&laquo;</span>
		</a></li>
		<%if(bookCount!=null &&  bookCount >0){
			int pageNo = bookCount % 10;
			int pages = 0;
			if(pageNo == 0){
				pages = bookCount/10;
			}else{
				pages = bookCount/10 + 1;
			}
			for(int i=1; i<=pages;i++){%>
				<li><a href="pageBooks?pageNo=<%=i%>"><%=i %></a></li>
			<%}
			
		} %>
		<li>
      		<a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
	</ul>
</nav>


<div class="row">
	<div class="col-md-6" class="table">
<table border="2" id="bookTable" class="table">
	<tr>
		
		<th>Book Title</th>
	
		<th>Return</th>
		
	</tr>
	
		<%for (Book b: book){ %>
		<tr>
		<td><% out.println(b.getTitle()); %></td>
		
		<%-- <td><button type="button" onclick="javascript:location.href='returnBook?bookId=<%=b.getBookId() %>&cardNo=<%=cardN %>'">Return the book</button> --%>
		<td><button type="button" class="btn btn-sm btn-primary"
						onclick="returnBook(<%=b.getBookId()%>)">Return the book</button></td>
		</tr>
		 <%} %>
	
</table>
</br>
	</div>
</div>