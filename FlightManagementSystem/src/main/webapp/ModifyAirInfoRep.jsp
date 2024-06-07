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
		Add Airport
		<form action="addAirport.jsp" method="POST">
			3-Letter Airport ID: <input type="text" name="airportID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Remove Airport
		<form action="removeAirport.jsp" method="POST">
			3-Letter Airport ID: <input type="text" name="airportID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Add Aircraft
		<form action="addAircraft.jsp" method="POST">
			Aircraft ID: <input type="text" name="aircraftID"/> <br/>
			Number of Seats: <input type="text" name="numOfSeats"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Remove Aircraft
		<form action="removeAircraft.jsp" method="POST">
			AircraftID: <input type="text" name="aircraftID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Add Airline-Aircraft Association
		<form action="addAircraftAssoc.jsp" method="POST">
			Aircraft ID: <input type="text" name="aircraftID"/> <br/>
			Airline ID: <input type="text" name="airlineID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Remove Airline-Aircraft Association
		<form action="removeAircraftAssoc.jsp" method="POST">
			Aircraft ID: <input type="text" name="aircraftID"/> <br/>
			Airline ID: <input type="text" name="airlineID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<br/>
		Add Airline-Airport Association
		<form action="addAirportAssoc.jsp" method="POST">
			Airline ID: <input type="text" name="airlineID"/> <br/>
			Airport ID: <input type="text" name="airportID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		Remove Airline-Airport Association
		<form action="removeAirportAssoc.jsp" method="POST">
			Airline ID: <input type="text" name="airlineID"/> <br/>
			Airport ID: <input type="text" name="airportID"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
		<br/>
		
		<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			
			
			String str3 = "SELECT * FROM Aircraft";
			PreparedStatement ps3 = con.prepareStatement(str3);
			ResultSet result3 = ps3.executeQuery();
				
			out.print("All Aircrafts");
			//Make an HTML table to show the results in:
			out.print("<table>");

			//parse out the results
			while (result3.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print(result3.getString("planeID"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			out.print("</br>");
			out.print("-----------------");
			out.print("</br>");
			
			
			String str4 = "SELECT * FROM Airport";
			PreparedStatement ps4 = con.prepareStatement(str4);
			ResultSet result4 = ps4.executeQuery();
				
			out.print("All Airports");
			//Make an HTML table to show the results in:
			out.print("<table>");
			//parse out the results
			while (result4.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result4.getString("threeLetterID"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			out.print("</br>");
			out.print("-----------------");
			out.print("</br>");
			
			
			String str = "SELECT * FROM Owns";
			PreparedStatement ps1 = con.prepareStatement(str);
			ResultSet result = ps1.executeQuery();
				
			out.print("Airline-Plane Associations");
			//Make an HTML table to show the results in:
			out.print("<table>");
		
			//make a row
			out.print("<tr>");
				out.print("<td>");
					out.print("Airline");
				out.print("</td>");
				
				out.print("<td>");
					out.print("Airplane ID");
				out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("twoLetterId"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("planeID"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			out.print("</br>");
			out.print("-----------------");
			out.print("</br>");
			
			String str2 = "SELECT * FROM AssociatedWith";
			PreparedStatement ps2 = con.prepareStatement(str2);
			ResultSet result2 = ps2.executeQuery();
			out.print("Airline-Airport Associations");
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>");
				out.print("Airline");
			out.print("</td>");
			
			out.print("<td>");
				out.print("Airport");
			out.print("</td>");
		out.print("</tr>");
		out.print("<table>");
		//parse out the results
		while (result2.next()) {
			//make a row
			out.print("<tr>");

			out.print("<td>");
			out.print(result2.getString("twoLetterId"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(" | " + result2.getString("threeLetterId"));
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