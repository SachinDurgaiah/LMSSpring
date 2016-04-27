<%@ include file="include.html" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library management system - Librarian.</h2>
<h3>Please select your activity.</h3>
</head>
<body>

<td><button type="button" class="btn btn-lg btn-primary"
data-toggle="modal" data-target="#myModal1"
			href="librarybranch.jsp">Update details of a branch</button></td>

<br/>


<br></br>
<td><button type="button" class="btn btn-lg btn-primary"
			data-toggle="modal" data-target="#myModal1"
						href="addBcopies.jsp">Add Books to the branch</button></td>		
		


<div id="myModal1" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>

