<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Publisher" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%Publisher publisher = null;
    if(request.getAttribute("publisher")!=null){
    	publisher = (Publisher)request.getAttribute("publisher");
    	}%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library Management System - Admin</h2>
<h3>Edit publisher Details Below:</h3>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

${result}
</head>
<body>
	<form action="editpublisher" method="post">
		Publisher Name: <input type="text" name="publisherName" value="<%=publisher.getPublisherName() %>"> <br />
		Publisher Address: <input type="text" name="publisherAddress" value="<%=publisher.getPublisherAddress() %>"> <br />
		<input type="hidden" name="publisherId" value=<%=publisher.getPublisherId() %>>
		<button type="submit">Edit Author</button>
	</form>
</body>
</html>