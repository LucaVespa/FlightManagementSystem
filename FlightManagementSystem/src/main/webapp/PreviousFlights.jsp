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
			
			String username = String.valueOf(session.getAttribute("user"));
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT * FROM FlightTicketTransaction f JOIN RelatesTo r ON f.ticketid = r.ticketid " 
					+ "JOIN FlightDetails d ON r.flightNum = d.flightNum WHERE f.username = ? AND DATE(d.depDate) < DATE(?)";
			PreparedStatement ps1 = con.prepareStatement(str);

			ps1.setString(1, username);
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
					out.print("Ticket ID");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Flight Number");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Airline");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Ticket Price");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Seat Number");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Class");
				out.print("</td>");
			
				out.print("<td>");
					out.print(" | Booking Fee");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Cancel Fee");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | From");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | To");
				out.print("</td>");
			
				out.print("<td>");
					out.print(" | Purchase Date");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Departure Date");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Arrival Date");
				out.print("</td>");
			
			
				
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("ticketid"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("flightNum"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("twoLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | $" + result.getString("farePrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("seatNumber"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("class"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | $" + result.getString("bookingFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | $" + result.getString("cancelFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("departureThreeLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("arrivalThreeLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("purchaseDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("depDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("arrDate"));
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