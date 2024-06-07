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
		
		Search Tickets
		<form action="purchaseTicket.jsp" method="POST">
			Flight Number: <input type="text" name="flightNum"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		No Available Tickets? Join the Waitlist:
		<form action="confirmWaitlistAddition.jsp" method="POST">
			Flight Number: <input type="text" name="flightNum"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Search Between Two Airports
		<form action="SearchTwoAirport.jsp" method="POST">
			Departure Airport Code: <input type="text" name="depPort"/> <br/>
			Arrival AirportCode: <input type="text" name="arrPort"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Search for One-Way Flights (YYYY-MM-DD)
		<form action="SearchOneWay.jsp" method="POST">
			Date: <input type="text" name="depTime"/> <br/>
			Flexibility (+/- 3 days: )<input type="text" name="flexibility"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Search for Round-Trip Flights (YYYY-MM-DD) 
		<form action="SearchRoundTrip.jsp" method="POST">
			Departure Date: <input type="text" name="depTime"/> <br/>
			Return Date: <input type="text" name="arrTime"/> <br/>
			Flexibility (+/- 3 days: )<input type="text" name="flexibility"/> <br/>
			<input type="submit" value="Submit"/>
		</form>
		<br/>
		Filter By:
		<br/>
		<form action="FilterPrice.jsp" method="POST">
			Price (Integer): <input type="text" name="price"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<form action="FilterStopCount.jsp" method="POST">
			Number of Stops (Integer): <input type="text" name="stopCount"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<form action="FilterAirline.jsp" method="POST">
			Airline (2 Letter Code): <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<form action="FilterDepTime.jsp" method="POST">
			Take-off Time (YYYY-MM--DD HH:MI:SS): <input type="text" name="depTime"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<form action="FilterArrTime.jsp" method="POST">
			Landing Time (YYYY-MM--DD HH:MI:SS): <input type="text" name="arrTime"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Sort by:
		<br/>
		<a href='SortByPrice.jsp'>Price</a>
		<a href='SortByTakeOff.jsp'> | Take-Off Time</a>
		<a href='SortByLanding.jsp'> | Landing Time</a>
		<a href='SortByDuration.jsp'> | Flight Duration</a><br/><br/>
		<%
		
		try {
	
			String airportCode = request.getParameter("airportCode");
			
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT * FROM FlightDetails WHERE depDate > ?";
			PreparedStatement ps1 = con.prepareStatement(str);
			LocalDateTime currentDateTime = LocalDateTime.now();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
		    String currentDate = currentDateTime.format(formatter);
		    ps1.setString(1, currentDate);
			
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
					out.print(" | Cheapest Ticket");
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
				
				String str2 = "SELECT MIN(farePrice) FROM FlightTicketTransaction f, RelatesTo r WHERE f.ticketid = r.ticketid AND r.flightNum = ? AND f.username IS NULL";
				PreparedStatement ps2 = con.prepareStatement(str2);
				ps2.setString(1, result.getString("flightNum"));
				ResultSet result2 = ps2.executeQuery();
				
				out.print("<td>");
				if (result2.next()) {
					if (result2.getString(1) == null) {
						out.print(" | No Available Tickets");
					} else {
						out.print(" | $" + result2.getString(1));
					}  
				}
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