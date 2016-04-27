<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%@ include file="include.html"%>
    <% 
   
    	AdministratorService service = new AdministratorService();
    	Integer branchCount = service.getBranchCount();

    	List<LibraryBranch> branch = new ArrayList<LibraryBranch>();
    	
    	if (request.getAttribute("book") != null) {
    		branch = (List<LibraryBranch>)request.getAttribute("branch");
		}else{
			branch = service.getAllBranches(1);	
		}
    %>
<script type="text/javascript">
function modifyBranch(branchId){
	$.ajax({
		  url: "modifyBranch",
		  data:{
			  branchId:branchId,
			
		  }
		}).done(function(data) {
		  $('#branchTable1').html(data);
		});
}
</script>
<h2>List of all the libraries in the system.</h2>
${result}

<nav>
	<ul class="pagination">
		<li><a href="#" aria-label="Previous"> <span
				aria-hidden="true">&laquo;</span>
		</a></li>
		<%if(branchCount!=null &&  branchCount >0){
			int pageNo = branchCount % 10;
			int pages = 0;
			if(pageNo == 0){
				pages = branchCount/10;
			}else{
				pages = branchCount/10 + 1;
			}
			for(int i=1; i<=pages;i++){%>
				<li><a href="pageBranch?pageNo=<%=i%>"><%=i %></a></li>
			<%}
			
		} %>
		<li>
      		<a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
	</ul>
</nav>
<div class="modal-body">
<div class="row">
	<div class="col-md-6">
<table border="2" id="branchTable1" class="table">
	<tr>
		<th>Branch Name</th>
		<th>Branch Address</th>
		<th>Select</th>
		
	</tr>
	
		<%for (LibraryBranch a: branch){ %>
		<tr>
		<td><% out.println(a.getBranchName()); %></td>
		<td><% out.println(a.getBranchAddress()); %>></td>
				
			<td><button type="button" class="btn btn-sm btn-primary"
			data-toggle="modal" data-target="#myModal1"
						href="modifyBranch?branchId=<%=a.getBranchId()%>">EDIT</button></td>		
		
	
		</tr>
		<%} %>
		
	

</table>

</br>
</div>
</div>
</div>
<div id="myModal1" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>