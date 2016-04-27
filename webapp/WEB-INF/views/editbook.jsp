<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Book" %>
     <%@ page import="com.lms.entity.Genre" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%Book book = null;
    if(request.getAttribute("book")!=null){
    	book = (Book)request.getAttribute("book");
    	}
    AdministratorService service = new AdministratorService();
    List<Author> author = service.getAllAuthors();//// add a method to get the author for the book.
    
	List<Genre> genre =  service.getAllGenre(); /// add a method to get the genre of the book.
    	%>
 
<div class="modal-body">
<h3>Edit Book Details Below:</h3>
${result}

	<form action="editbook" method="post">
		Book title: <input type="text" name="bookName" value="<%=book.getTitle() %>"> <br />
		
		<br/>
		Author that you want associate the book with:<br/>
		
		<select multiple name="authorId">
		
			<%for(Author b: author){ %>
			<option value="<%=b.getAuthorId()%>"><%=b.getAuthorName() %></option>
			<%} %>
		</select><br/>
		<br/>
		Genre that you want associate the book with:<br/>
		<select multiple name="genreId">
			<%for(Genre g: genre){ %>
			<option value="<%=g.getGenre_id()%>"><%=g.getGenre_name()%></option>
			<%} %>
		</select><br/>
		<br/>
		<button type="submit">Edit Book</button>
		<input type="hidden" name="bookId" value=<%=book.getBookId() %>>
	</form>
	</div>



	