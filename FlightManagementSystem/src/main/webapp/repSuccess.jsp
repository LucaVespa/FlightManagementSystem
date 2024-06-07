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
	Welcome Representative <%=session.getAttribute("user")%>
	<br/>
	<a href='CustomerEditRep.jsp'>Make and Edit Customer Reservations</a><br/>
	<a href='ModifyFlightInfoRep.jsp'>Modify Flight Information</a><br/>
	<a href='ModifyAirInfoRep.jsp'>Modify Airport and Aircraft Information</a><br/>
	<a href='ViewFlightListsRep.jsp'>View Flight Lists</a><br/>
	<a href='qAndARep.jsp'>Manage Questions and Answers</a><br/>
	<a href='ViewWaitlistsRep.jsp'>View Waitlists</a><br/>
	<a href='logout.jsp'>Log out</a>
<%
	}
%>

</body>
</html>