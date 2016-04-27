<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.Borrower" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%Borrower borrower = null;
    if(request.getAttribute("borrower")!=null){
    	borrower = (Borrower)request.getAttribute("borrower");
    	}%>
    
<div class="modal-body">
<h3>Edit Borrower Details Below:</h3>


${result}

	<form action="editBorrower12" method="post">
		Borrower Name: <input type="text" name="borrowerName" value="<%=borrower.getName() %>"> <br />
		 <br />
		Borrower Address: <input type="text" name="borrowerAddress" value="<%=borrower.getAddress() %>"> <br />
		 <br />
		Phone: <input type="text" name="borrowerPhone" value="<%=borrower.getPhone() %>"> <br />
		 <br />
		<input type="hidden" name="cardNo" value=<%=borrower.getCardNo() %>>
		<button type="submit">Edit Borrower</button>
	</form>
</div>