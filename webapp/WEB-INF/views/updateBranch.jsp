<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.Author" %>
    <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <% LibraryBranch branch = null;
    
    if(request.getAttribute("branch")!=null){
    	branch = (LibraryBranch)request.getAttribute("branch");
    	}%>
    
<div class="modal-body">
<h3>Edit Branch Details Below:</h3>


${result}

	<form action="editBranchDetails" method="post">
		Branch Name: <input type="text" name="branchName" value="<%=branch.getBranchName() %>"> <br />
		Branch Address: <input type="text" name="branchAddress" value="<%=branch.getBranchAddress()%>"> <br />
		<input type="hidden" name="branchId" value=<%=branch.getBranchId() %>>
		<button type="submit">Update </button>
	</form>
</div>