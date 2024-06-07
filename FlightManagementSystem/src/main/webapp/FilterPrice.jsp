<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
		
		<%
		
		try {
			
			String price = request.getParameter("price");
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT * FROM FlightDetails fd " +
               "JOIN RelatesTo r ON fd.flightNum = r.flightNum " +
               "JOIN FlightTicketTransaction f ON r.ticketid = f.ticketid " +
               "WHERE f.farePrice = ? AND f.username IS NULL AND fd.depDate > ?";
			PreparedStatement ps1 = con.prepareStatement(str);
			ps1.setInt(1, Integer.parseInt(price));
			
			LocalDateTime currentDateTime = LocalDateTime.now();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
		    String currentDate = currentDateTime.format(formatter);
		    ps1.setString(2, currentDate);
			
			
			
			ResultSet result = ps1.executeQuery();
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
				out.print("<td>");
					out.print("Flight Number");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Airline");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Departure Location");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Departure Time");
				out.print("</td>");
			
				out.print("<td>");
					out.print(" | Arrival Destination");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Arrival Time");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Airplane ID");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Duration (Minutes)");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Ticket Price");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Number of Stops");
				out.print("</td>");
				
				
			out.print("</tr>");

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
				out.print(" | " + result.getString("departureThreeLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("depDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("arrivalThreeLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("arrDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("planeID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("duration"));
				out.print("</td>");

				out.print("<td>");
				out.print(" | $" + price);
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("numOfStops"));
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