<%@ include file="include.html" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LMS</title>
<h2>Welcome to GCIT Library management system - Borrower.</h2>
<h3>Please enter your card number.</h3>
</head>
<body>
<form action="verifyBorrowerforbookreturn" method="get">
		Please enter your card number: <input type="text" name="cardNo"> <br />
<button type="submit">Verify card number</button>
</form>
</body>
</html>