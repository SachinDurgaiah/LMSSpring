<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="com.lms.entity.LibraryBranch" %>
    <%@ page import="com.lms.entity.Book" %>
    <%@ page import="com.lms.service.BorrowerServices" %>
    <%@ include file="include.html"%>
    <% 
    int cardN=0;
    if(request.getAttribute("cardNo")!=null){
    	cardN = (Integer)request.getAttribute("cardNo");
    	}
    int branchId=0;
    {
    	if(request.getAttribute("branchId")!=null){
        	branchId = (Integer)request.getAttribute("branchId");
        	}
    }
    BorrowerServices service = new BorrowerServices();
    
    
    	//List<Author> authors = service.getAllAuthors();
    	Integer bookCount = service.getBookCount(branchId);

    	List<Book> book =new ArrayList<Book>(); 
    			
    		if (request.getAttribute("book") != null) {
    			book = (List<Book>)request.getAttribute("book");
    		}else{
    			book = service.getAllBooksWithBranch(branchId,1);	
    		}
    		
    %>
    
    
<script type="text/javascript">
function checkoutbook(branchId,bookId,cardNo){
	$.ajax({
		  url: "checkoutbook",
		  data:{
			  branchId:branchId,
			  cardNo:cardNo,
			  bookId: bookId
		  }
		}).done(function(data) {
		  $('#authorsTable').html(data);
		});
}
</script>
<h2>Select the book that you would like to borrow.</h2>
${result}

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
<div class="modal-body">
<div class="row">
	<div class="col-md-6">
<table border="2" id="authorsTable" class="table">
	<tr>
		<th>title</th>
		
		<th>Select</th>
		
	</tr>
	
		<%for (Book a: book){ %>
		<tr>
		<td><% out.println(a.getTitle()); %></td>
		<%-- <td><button type="button" onclick="javascript:location.href='checkoutbook?bookId=<%=a.getBookId() %>&cardNo=<%=cardN %>&branchId=<%=branchId%>'">Borrow</button> --%>
		<td><button type="button" class="btn btn-sm btn-primary"
						href="checkoutbook?bookId=<%=a.getBookId()%>&branchId=<%=branchId %>&cardNo=<%=cardN%>">Borrow</button>	</td>
						
		</tr>
		<%} %>
		
	

</table>
</br>
	</div>
</div>
</div>