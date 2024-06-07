<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="login.jsp">Please Login</a>
<%} else {
%>
	Add Customer
	<form action="addCustomer.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			Password: <input type="text" name="password"/> <br/>
			First Name: <input type="text" name="fname"/> <br/>
			Last Name: <input type="text" name="lname"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	<br/>
	Edit Customer
	<form action="editCustomer.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			New Username: <input type="text" name="newUsername"/> <br/>
			Password: <input type="text" name="password"/> <br/>
			First Name: <input type="text" name="fname"/> <br/>
			Last Name: <input type="text" name="lname"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	<br/>
	Remove Customer
	<form action="removeCustomer.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	
<%
	}
%>

</body>
</html>