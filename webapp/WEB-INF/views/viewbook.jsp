<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.lms.entity.Author"%>
<%@ page import="com.lms.entity.Genre"%>
<%@ page import="com.lms.entity.Book"%>
<%@ page import="com.lms.service.AdministratorService"%>
<%@ include file="include.html"%>
<%
AdministratorService service = new AdministratorService();
//List<Author> authors = service.getAllAuthors();
Integer bookCount = service.getBookCount();

List<Book> book = new ArrayList<Book>();
	if (request.getAttribute("book") != null) {
		book = (List<Book>)request.getAttribute("book");
	}else{
		book = service.getAllBooks(1);	
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

   function searchBook(){
	   $('#searchType li a').on('click', function(){
			console.log("Selected option :"+$(this).text());
			sType=$(this).text();
		});
	   console.log($('#searchString'));
	   ///if($('#searchString').val().legth<3) return;
    $.ajax({
    	
		  url: "searchBook",
		  data:{
			  searchString:$('#searchStrings').val(),
			  text: sType	
			  }
		}).done(function(data) {
		  $('#authorsTable').html(data);
		});
   
}





function deletebook(bookId){
	$.ajax({
		  url: "deletebook",
		  data:{
			  bookId: bookId
		  }
		}).done(function(data) {
		  $('#bookTable').html(data);
		});
}
function editbook(bookId){
	$.ajax({
		  url: "editbook",
		  data:{
			  bookId: bookId
		  }
		}).done(function(data) {
		  $('#bookTable').html(data);
		});
}

</script>
<h2>Available Books in LMS</h2>
${result}

  <form action="searchBook">
       <div class="row">
       <div class="cl-lg-6">
       <div class="input-group">
       
      <input type="text" class="form-control" placeholder="Author Name"
			aria-describedby="basic-addon1" name="searchString" id="searchStrings" onkeyup="searchBook()">
			<div class = "input-group-btn">
			<button type = "button" class = "btn btn-primary dropdown-toggle" data-toggle = "dropdown" aria-haspopup="true" aria-expanded="false">
			<span class = "caret"></span> <span class="sr-only">Toggle Dropdown</span>
   			</button>
   	
   			 <ul id="searchType" class = "dropdown-menu dropdown-menu-right">
   				<li><a tabindex="-1" href="#">Search by Title</a></li>
   				<li><a tabindex="-1" href="#">Search by Author</a></li>
   				<li role="separator" class="divider"></li>
 				<li><a tabindex="-1" href="#">Search by All</a></li>  			
   </ul>
   <button type="button" class="btn btn-success" onclick="searchBook()">Search</button>
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
		<%if(bookCount!=null &&  bookCount >0){
			int pageNo = bookCount % 10;
			int pages = 0;
			if(pageNo == 0){
				pages = bookCount/10;
			}else{
				pages = bookCount/10 + 1;
			}
			for(int i=1; i<=pages;i++){%>
				<li><a href="pageBooks?pageNo=<%=i%>"><%=i %></a></li>
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
		<table border="2" id="bookTable" class="table">
	<tr>
		
		<th>Book Title</th>
		<th>Author Name</th>
		<th>Genre</th>
	
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	
		<%for (Book b: book){ %>
		<tr>
		<td><% out.println(b.getTitle()); %></td>
		<td><%if(b.getAuthor()!=null && b.getAuthor().size() >0){
			for(Author a: b.getAuthor()){
				out.println(a.getAuthorName());
				out.println(", ");
			}
		}	
		%></td>
		
		<td><%if(b.getGenre()!=null && b.getGenre().size() >0){
			for(Genre g: b.getGenre()){
				out.println(g.getGenre_name());
				out.println(", ");
			}
		}	
		%></td>
	
		<td align="center"><button type="button"
						class="btn btn btn-primary" data-toggle="modal"
						data-target="#myModal1"
						href="editbook?bookId(<%=b.getBookId()%>)">EDIT</button></td>


				<td><button type="button" class="btn btn-sm btn-danger"
						onclick="deletebook(<%=b.getBookId()%>)">DELETE</button></td>
	
		</tr>
		 <%} %>
	

	

</table>

</br>

<div id="myModal1" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>







