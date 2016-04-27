<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Book" %>
      <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <% 
    	AdministratorService service = new AdministratorService();
    	List<Book> book = service.getAllBooks(1);
    	List<LibraryBranch> branch = service.getAllBranches();
    %>

<div class="modal-body">
${result}

<form action="addBcopies" method="post">
	<br></br>
		List of Books:<br/>
		<select name="bookId">
			<%for(Book b: book){ %>
			<option value="<%=b.getBookId()%>"><%=b.getTitle() %></option>
			<%} %>
		</select><br/>
		<br></br>
		Select your branch:<br/>
		<select name="branchId">
			<%for(LibraryBranch lb: branch){ %>
			<option value="<%=lb.getBranchId()%>"><%=lb.getBranchName()%></option>
			<%} %>
		</select><br/>
		<br></br>
		Enter the number of copies <input type="text" name="noOfCopies"> <br />
		
		<button type="submit">Add Book</button>
	</form>

</div>