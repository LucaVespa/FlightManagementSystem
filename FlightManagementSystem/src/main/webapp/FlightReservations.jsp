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
	View Flight Reservations By Flight Number
		<form action="ViewByFlightNum.jsp" method="POST">
			Flight Number: <input type="text" name="flightnum"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
	View Flight Reservations By User
		<form action="ViewByUsername.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
	
<%
	}
%>

</body>
</html>