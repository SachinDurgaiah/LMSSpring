<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.AdministratorService" %>
    <%@ include file="include.html"%>
    <% 
    int cardN=0;
    if(request.getAttribute("cardNo")!=null){
    	cardN = (Integer)request.getAttribute("cardNo");
    	}
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

var sType="Search by All";


$(function(){
	$('#searchType li a').on('click', function(){
		console.log("Selected option :"+$(this).text());
		sType=$(this).text();
	});
});

   function  branchSelected(branchId){
	   $('#searchType li a').on('click', function(){
			console.log("Selected option :"+$(this).text());
			sType=$(this).text();
		});
	   console.log($('#searchStrings'));
	   ///if($('#searchString').val().legth<3) return;
    $.ajax({
    	
		  url: "branchSelected",
		  data:{
			  branchId:branchId,
			  cardNo:cardN,
			  searchString:$('#searchStrings').val(),
			  text: sType	
			  }
		}).done(function(data) {
		  $('#authorsTable').html(data);
		});
   
}


</script>
<h2>List of all the libraries in the system.</h2>
${result}


<form action="branchSelected">
       <div class="row">
       <div class="cl-lg-6">
       <div class="input-group">
       
      <input type="text" class="form-control" placeholder="Branch Name"
			aria-describedby="basic-addon1" name="searchString" id="searchStrings" onkeyup="branchSelected(branchId,cardN)">
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
   <button type="button" class="btn btn-success" onclick="branchSelected(branchId,cardN)">Search</button>
        </div>
        </div>
        </div>
        </div>
        </form>


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

<div class="row">
	<div class="col-md-6">
<table border="2" id="branchTable" class="table">
	<tr>
		<th>Branch Name</th>
		<th>Branch Address</th>
		<th>Select</th>
		
	</tr>
	
		<%for (LibraryBranch a: branch){ %>
		<tr>
		<td><% out.println(a.getBranchName()); %></td>
		<td><% out.println(a.getBranchAddress()); %>></td>
				<%-- <td><button type="button" onclick="javascript:location.href='branchSelected?branchId=<%=a.getBranchId() %>&cardNo=<%=cardN %>'">EDIT</button> --%>
			<td><button type="button" class="btn btn-sm btn-primary"
			data-toggle="modal" data-target="#myModal1"
						href="branchSelected?branchId=<%=a.getBranchId() %>&cardNo=<%=cardN %>">Select</button></td>		

	
		</tr>
		<%} %>
		
	

</table>

</br>
</div>
</div>

<div id="myModal1" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>
