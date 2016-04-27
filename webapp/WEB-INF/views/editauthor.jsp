<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%AdministratorService adminService = new AdministratorService();
 String authorId = request.getParameter("authorId");
 Author author = adminService.getAuthorByID(Integer.parseInt(authorId));
 List<Book> book = adminService.getAllBooks(1);
%>
<div class="modal-body">
<h3>Edit Author Details Below:</h3>
${result}
	<form action="ChangeAuthor" method="post">
		Author Name: <input type="text" name="authorName" value="<%=author.getAuthorName() %>"> <br />
		<select multiple name="bookId">
		
			<%for(Book b: book){ %>
			<option value="<%=b.getBookId() %>"><%=b.getTitle() %></option>
			<%} %>
		</select><br/>
		<input type="hidden" name="authorId" value=<%=author.getAuthorId() %>>
		<button type="submit">Edit Author</button>
	</form>
</div>