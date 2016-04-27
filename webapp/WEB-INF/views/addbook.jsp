<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.entity.Publisher" %>
    <%@ page import="com.lms.entity.Genre" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <% 
    	AdministratorService service = new AdministratorService();
    	List<Author> author = service.getAllAuthors();
    	List<Publisher> publisher = service.getAllPubliser(1);
    	List<Genre> genre =  service.getAllGenre();
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library Management System - Admin</h2>
<h3>Enter Book Details Below:</h3>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

${result}
</head>
<body>
	<form action="addBook" method="post">
		Book Title: <input type="text" name="booktitle"> <br />
		Author that you want associate the book with:<br/>
		<select multiple name="authorId">
			<%for(Author b: author){ %>
			<option value="<%=b.getAuthorId()%>"><%=b.getAuthorName() %></option>
			<%} %>
		</select><br/>
		Genre that you want associate the book with:<br/>
		<select multiple name="genreId">
			<%for(Genre g: genre){ %>
			<option value="<%=g.getGenre_id()%>"><%=g.getGenre_name()%></option>
			<%} %>
		</select><br/>
		Publisher that you want associate the book with:<br/>
		<select name="publisherId">
			<%for(Publisher p: publisher){ %>
			<option value="<%=p.getPublisherId()%>"><%=p.getPublisherName()%></option>
			<%} %>
		</select><br/>
		<br/>
		<button type="submit">Add Author</button>
	</form>
</body>
</html>