<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.lms.entity.Author"%>
<%@ page import="com.lms.entity.Book"%>
<%@ page import="com.lms.entity.Publisher"%>
<%@ page import="com.lms.service.AdministratorService"%>
<%@ include file="include.html"%>
    <% 
    	AdministratorService service = new AdministratorService();
	Integer publisherCount = service.getPublisherCount();

    	List<Publisher> publisher = new ArrayList<Publisher>();
    		if (request.getAttribute("publisher") != null) {
    			publisher = (List<Publisher>)request.getAttribute("publisher");
    		}else{
    			publisher = service.getAllPubliser(1);	
    		}
    %>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
<script type="text/javascript">

var sType="Search by All";


$(function(){
	$('#searchType li a').on('click', function(){
		console.log("Selected option :"+$(this).text());
		sType=$(this).text();
	});
});

   function searchPublisher(){
	   $('#searchType li a').on('click', function(){
			console.log("Selected option :"+$(this).text());
			sType=$(this).text();
		});
	   console.log($('#searchString'));
	   ///if($('#searchString').val().legth<3) return;
    $.ajax({
    	
		  url: "searchPublisher",
		  data:{
			  searchString:$('#searchStrings').val(),
			  text: sType	
			  }
		}).done(function(data) {
		  $('#publisherTable').html(data);
		});
   
}


function editpublisher(publisherId){
	$.ajax({
		  url: "editpublisher",
		  data:{
			  publisherId: publisherId
		  }
		}).done(function(data) {
		  $('#publisherTable').html(data);
		});
}

function deletePublisher(publisherId){
	$.ajax({
		 url: "deletePublisher",
		
		  data:{
			  publisherId: publisherId
		  }
		}).done(function(data) {
		  $('#publisherTable').html(data);
		});
}
</script>

<h2>Publishers in the system.</h2>
${result}

<form action="searchPublisher">
       <div class="row">
       <div class="cl-lg-6">
       <div class="input-group">
       
      <input type="text" class="form-control" placeholder="Publisher Name"
			aria-describedby="basic-addon1" name="searchString" id="searchStrings" onkeyup="searchPublisher()">
			<div class = "input-group-btn">
			<button type = "button" class = "btn btn-primary dropdown-toggle" data-toggle = "dropdown" aria-haspopup="true" aria-expanded="false">
			<span class = "caret"></span> <span class="sr-only">Toggle Dropdown</span>
   			</button>
   	
   			 <ul id="searchType" class = "dropdown-menu dropdown-menu-right">
   				<li><a tabindex="-1" href="#">Search by Publisher Name</a></li>
   				<li><a tabindex="-1" href="#">Search by Publisher Address</a></li>
   				<li role="separator" class="divider"></li>
 				<li><a tabindex="-1" href="#">Search by All</a></li>  			
   </ul>
   <button type="button" class="btn btn-success" onclick="searchPublisher()">Search</button>
        </div>
        </div>
        </div>
        </div>
        </form>




<div id="searchResults">
<nav>
	<ul class="pagination">
		<li><a href="#" aria-label="Previous"> <span
				aria-hidden="true">&laquo;</span>
		</a></li>
		<%if(publisherCount!=null &&  publisherCount >0){
			int pageNo = publisherCount % 10;
			int pages = 0;
			if(pageNo == 0){
				pages = publisherCount/10;
			}else{
				pages = publisherCount/10 + 1;
			}
			for(int i=1; i<=pages;i++){%>
				<li><a href="pagePublisher?pageNo=<%=i%>"><%=i %></a></li>
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
<table border="2" id="publisherTable" class="table">
	<tr>
		<th>Publisher Name</th>
		<th>Publisher Address</th>
		<th>Edit</th>
		<th>Delete</th>
		
	</tr>
	
		<%for (Publisher a: publisher){ %>
		<tr>
		<td><% out.println(a.getPublisherName()); %></td>
		<td><% out.println(a.getPublisherAddress()); %></td>
	
		<td align="center"><button type="button"
						class="btn btn btn-primary" data-toggle="modal"
						data-target="#myModal1"
						href="editpublisher?publisherId=<%=a.getPublisherId() %>">EDIT</button></td>


				<td><button type="button" class="btn btn-sm btn-danger"
						onclick="deletePublisher?publisherId=<%=a.getPublisherId()%>)">DELETE</button></td>
		
		
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