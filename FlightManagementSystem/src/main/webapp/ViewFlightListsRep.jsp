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
	<form action="ViewFlightListsRep2.jsp" method="POST">
			Airport Code: <input type="text" name="airportCode"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
<%
	}
%>

</body>
</html>