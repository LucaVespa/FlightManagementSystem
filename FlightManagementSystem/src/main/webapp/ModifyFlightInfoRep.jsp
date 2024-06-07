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
		
		Add Flight
		<form action="addFlightRep.jsp" method="POST">
			Flight ID: <input type="text" name="flightId"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			Departure Airport: <input type="text" name="depPort"/> <br/>
			Departure Date (YYYY-MM-DD HH-MI-SS): <input type="text" name="depDate"/> <br/>
			Arrival Airport: <input type="text" name="arrPort"/> <br/>
			Arrival Date (YYYY-MM-DD HH-MI-SS): <input type="text" name="arrDate"/> <br/>
			Duration: <input type="text" name="duration"/> <br/>
			Plane ID: <input type="text" name="planeid"/> <br/>
			Number of Stops: <input type="text" name="stops"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Delete Flight
		<form action="removeFlightRep.jsp" method="POST">
			Flight ID: <input type="text" name="flightId"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Edit Flight (Flight ID and Airline cannot be modified)
		<form action="editFlightRep.jsp" method="POST">
			Flight ID: <input type="text" name="flightId"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			Departure Airport: <input type="text" name="depPort"/> <br/>
			Departure Date (YYYY-MM-DD HH-MI-SS): <input type="text" name="depDate"/> <br/>
			Arrival Airport: <input type="text" name="arrPort"/> <br/>
			Arrival Date (YYYY-MM-DD HH-MI-SS): <input type="text" name="arrDate"/> <br/>
			Duration: <input type="text" name="duration"/> <br/>
			Plane ID: <input type="text" name="planeid"/> <br/>
			Number of Stops: <input type="text" name="stops"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Add Ticket
		<form action="addTicketRep.jsp" method="POST">
			Ticket ID: <input type="text" name="ticketid"/> <br/>
			Seat Number: <input type="text" name="seatnum"/> <br/>
			Fare Price: <input type="text" name="price"/> <br/>
			Class: <input type="text" name="class"/> <br/>
			Booking Fee: <input type="text" name="bookingfee"/> <br/>
			Cancellation Fee: <input type="text" name="cancelfee"/> <br/>
			<input type="submit" value="Submit"/><br/>			
		</form>
		<br/>
		Delete Ticket
		<form action="removeTicketRep.jsp" method="POST">
			Ticket ID: <input type="text" name="ticketid"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Edit Ticket (Ticked ID cannot be modified)
		<form action="editTicketRep.jsp" method="POST">
			Ticket ID: <input type="text" name="ticketid"/> <br/>
			Seat Number: <input type="text" name="seatnum"/> <br/>
			Fare Price: <input type="text" name="price"/> <br/>
			Class: <input type="text" name="class"/> <br/>
			Booking Fee: <input type="text" name="bookingfee"/> <br/>
			Cancellation Fee: <input type="text" name="cancelfee"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Assign Ticket to Flight
		<form action="Assign.jsp" method="POST">
			Ticket ID: <input type="text" name="ticketid"/> <br/>
			Flight Number: <input type="text" name="flightnum"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Unassign Ticket to Flight
		<form action="Unassign.jsp" method="POST">
			Ticket ID: <input type="text" name="ticketid"/> <br/>
			Flight Number: <input type="text" name="flightnum"/> <br/>
			Airline: <input type="text" name="airline"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		
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
			String str = "SELECT * FROM FlightDetails";
			PreparedStatement ps1 = con.prepareStatement(str);
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
				out.print(" | " + result.getString("numOfStops"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			
			String str2 = "SELECT * From FlightTicketTransaction";
			PreparedStatement ps2 = con.prepareStatement(str2);
			ResultSet result2 = ps2.executeQuery();
				
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
				out.print("<td>");
					out.print("Ticket ID");
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
					out.print(" | Cancellation Fee");
				out.print("</td>");
				
			out.print("</tr>");

			//parse out the results
			while (result2.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result2.getString("ticketid"));
				out.print("</td>");
				
				
				out.print("<td>");
				out.print(" | $" + result2.getString("farePrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result2.getString("seatNumber"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result2.getString("class"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | $" + result2.getString("bookingFee"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | $" + result2.getString("cancelFee"));
				out.print("</td>");;
				
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			String str3 = "SELECT * From RelatesTo";
			PreparedStatement ps3 = con.prepareStatement(str3);
			ResultSet result3 = ps3.executeQuery();
				
			out.print("</br>");
			out.print("Ticket-Flight Associations");
			out.print("</br>");
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
					out.print(" | Ticket ID");
				out.print("</td>");
			
				
			out.print("</tr>");

			//parse out the results
			while (result3.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result3.getString("flightNum"));
				out.print("</td>");
				
				
				out.print("<td>");
				out.print(" | " + result3.getString("twoLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result3.getString("ticketId"));
				out.print("</td>");

				
				out.print("</tr>");

			}
			out.print("</table>");
			
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
		
		}
		%>
	

	</body>
</html>