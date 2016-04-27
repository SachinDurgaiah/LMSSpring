<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Borrower" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <% 
    	AdministratorService service = new AdministratorService();
    	List<Borrower> borrower = service. getAllBorrower();
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library Management System - Admin</h2>
<h3>Enter Author Details Below:</h3>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

${result}
</head>
<body>
	<form action="addBorrower" method="post">
		Borrower Name: <input type="text" name="borrowerName"> <br />
		Borrower Address: <input type="text" name="borrowerAddress"> <br />
		Borrower Phone:<input type="text" name="borrowerPhone"><br />
		
		<button type="submit">Add Author</button>
	</form>
</body>
</html>