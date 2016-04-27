<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.lms.entity.Author"%>
<%@ page import="com.lms.entity.Book"%>
<%@ page import="com.lms.entity.LibraryBranch"%>
<%@ page import="com.lms.service.AdministratorService"%>
<%@ include file="include.html"%>
    <% 
    	AdministratorService service = new AdministratorService();
    Integer BranchCount = service.getBranchCount();

    List<LibraryBranch> branch = new ArrayList<LibraryBranch>();
    	if (request.getAttribute("branch") != null) {
    		branch = (List<LibraryBranch>)request.getAttribute("branch");
    	}else{
    		branch = service.getAllBranches(1);	
    	}
    	
    	
    %>
    
    <script src="/assets/jquery/jquery-1.10.2.min.js"></script>
    <script src="/assets/bootstrap/2.3.2/js/bootstrap-typeahead.js"></script>
<script type="text/javascript">

$(function(){
	$('#searchType li a').on('click', function(){
		console.log("Selected option :"+$(this).text());
		sType=$(this).text();
	});
});

   function searchBranch(){
	   $('#searchType li a').on('click', function(){
			console.log("Selected option :"+$(this).text());
			sType=$(this).text();
		});
	   console.log($('#searchString'));
	   ///if($('#searchString').val().legth<3) return;
    $.ajax({
    	
		  url: "searchBranch",
		  data:{
			  searchString:$('#searchStrings').val(),
			  text: sType	
			  }
		}).done(function(data) {
		  $('#branchTable').html(data);
		});
   
}



function editbranch(branchId){
	
	$.ajax({
		  url: "editBranch",
		  data:{
			  branchId: branchId
		  }
		}).done(function(data) {
		  $('#branchTable').html(data);
		});
}

$('.dropdown-inverse li > a').click(function(e){
    $('.status').text(this.innerHTML);
});


</script>
<script type="text/javascript">
function deletebranch(branchId){
	
	$.ajax({
		  url: "deletebranch",
		  data:{
			  branchId: branchId
		  }
		}).done(function(data) {
		  $('#branchTable').html(data);
		});
}

</script>
<h2>Available Branches in LMS</h2>
${result}


	<form action="searchBranch">
       <div class="row">
       <div class="cl-lg-6">
       <div class="input-group">
       
      <input type="text" class="form-control" placeholder="Branch Name"
			aria-describedby="basic-addon1" name="searchString" id="searchStrings" onkeyup="searchBranch()">
			<div class = "input-group-btn">
			<button type = "button" class = "btn btn-primary dropdown-toggle" data-toggle = "dropdown" aria-haspopup="true" aria-expanded="false">
			<span class = "caret"></span> <span class="sr-only">Toggle Dropdown</span>
   			</button>
   	
   			 <ul id="searchType" class = "dropdown-menu dropdown-menu-right">
   				<li><a tabindex="-1" href="#">Search by Branch name</a></li>
   				<li><a tabindex="-1" href="#">Search by Branch Address</a></li>
   				<li role="separator" class="divider"></li>
 				<li><a tabindex="-1" href="#">Search by All</a></li>  			
   </ul>
   <button type="button" class="btn btn-success" onclick="searchBranch()">Search</button>
        </div>
        </div>
        </div>
        </div>
        </form>


<div class="alert alert-danger" role="alert">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span>
 Enter a valid name!
</div>



<nav>
	<ul class="pagination">
		<li><a href="#" aria-label="Previous"> <span
				aria-hidden="true">&laquo;</span>
		</a></li>
		<%if(BranchCount!=null &&  BranchCount >0){
			int pageNo = BranchCount % 10;
			int pages = 0;
			if(pageNo == 0){
				pages = BranchCount/10;
			}else{
				pages = BranchCount/10 + 1;
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
<div class="row">
	<div class="col-md-6">
		<table border="2" id="branchTable" class="table">
	<tr>
		<th>Branch Name</th>
		<th>Branch Address</th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	
		<%for (LibraryBranch a: branch){ %>
		<tr>
		<td><% out.println(a.getBranchName()); %></td>
		<td><% out.println(a.getBranchAddress()); %>
		</td>
				
		
			<td align="center"><button type="button"
						class="btn btn btn-primary" data-toggle="modal"
						data-target="#myModal1"
						href="editbranch?branchId=<%=a.getBranchId()%>">EDIT</button></td>

				<td><button type="button" class="btn btn-sm btn-danger"
						onclick="deletebranch(<%=a.getBranchId()%>)">DELETE</button></td>
	
		</tr>
		<%
		}
		%>
		</table>
</br>
<div id="myModal1" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>