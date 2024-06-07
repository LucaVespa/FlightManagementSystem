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
	Welcome <%=session.getAttribute("user")%>
	<br/>
	<a href='CustomerEditAdmin.jsp'>Add, Remove, or Edit Customers</a><br/>
	<a href='RepresentativeEdit.jsp'>Add, Remove, or Edit Representatives</a><br/>
	<a href='FlightReservations.jsp'>View Flight Reservations</a><br/>
	<a href='RevenueSummary.jsp'>View Revenue Summaries</a><br/>
	<a href='MostActiveFlights.jsp'>View Most Active Flights</a><br/>
	<a href='logout.jsp'>Log out</a>
<%
	}
%>

</body>
</html>