<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.LibrarianService" %>
    <% 
    	LibrarianService service1 = new LibrarianService();
    	List<LibraryBranch> branches = service1.getAllBranches();
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library Management System - Librarian</h2>
${result}
<body>
<table border="2" id="branchTable">
	<tr>
		<th>Branch Name</th>
		<th>Address</th>
		
	</tr>
	
		<%for (LibraryBranch a: branches){ %>
		<tr>
		<td><% out.println(a.getBranchName()); %></td>
		<td><% out.println(a.getBranchAddress()); %></td>
		
		<td><button type="button" onclick="javascript:location.href='editBranch?branchId=<%=a.getBranchId() %>'">EDIT</button>
		<td><button type="button" onclick="javascript:location.href='deletebranch?branchId=<%=a.getBranchId() %>'">DELETE</button>
		
		</tr>
		<%} %>
		
	

</table>>
</body>
</html>