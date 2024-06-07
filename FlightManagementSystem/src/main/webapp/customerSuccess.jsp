<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
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
	Welcome Customer <%=session.getAttribute("user")%>
	<br/>
	<a href='FlightSearch.jsp'>Search Flights</a><br/>
	<a href='qAndA.jsp'>Browse Questions and Answers</a><br/>
	<a href='PreviousFlights.jsp'>View Past Flight Reservations</a><br/>
	<a href='FutureFlights.jsp'>View Upcoming Flights and Waitlist</a><br/>
	<a href='logout.jsp'>Log out</a>
	<br/>
	
<%
		
		try {
			out.print(" ");
			out.print("</br>");
			out.print("Available Flights on Your Waitlist:");
			String username = String.valueOf(session.getAttribute("user"));
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT fd.flightNum, fd.twoLetterId, fd.departureThreeLetterId, fd.depDate, fd.arrivalThreeLetterId, fd.arrDate, fd.duration, fd.planeID, fd.numOfStops, " +
               "COUNT(DISTINCT ftt.ticketid) AS availableTickets " +
               "FROM FlightDetails fd " +
               "JOIN RelatesTo r ON fd.flightNum = r.flightNum AND fd.twoLetterId = r.twoLetterId " +
               "JOIN FlightTicketTransaction ftt ON r.ticketid = ftt.ticketid AND ftt.username IS NULL " +
               "JOIN WaitsFor wf ON fd.flightNum = wf.flightNum AND fd.twoLetterId = wf.twoLetterId AND wf.username = ? " +
               "GROUP BY fd.flightNum, fd.twoLetterId, fd.departureThreeLetterId, fd.depDate, fd.arrivalThreeLetterId, fd.arrDate, fd.duration, fd.planeID, fd.numOfStops;";
PreparedStatement ps1 = con.prepareStatement(str);

			ps1.setString(1, username);
			
			ResultSet result = ps1.executeQuery();
			//Make an HTML table to show the results in:
			out.print("<table>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("flightNum"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("twoLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("availableTickets") + " tickets available");
				out.print("</td>");
				
				
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
			
		%>
		<%}
		%>
	

	</body>
</html>