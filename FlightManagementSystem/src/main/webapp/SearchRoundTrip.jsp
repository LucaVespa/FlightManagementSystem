<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>



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
			
			String depTime = request.getParameter("depTime");
			String arrTime = request.getParameter("arrTime");
			int flexibility = Integer.parseInt(request.getParameter("flexibility"));
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			PreparedStatement ps1 = con.prepareStatement(
				   "SELECT A.flightNum AS outgoingFlightNum, A.twoLetterId AS outgoingAirline, A.departureThreeLetterId AS outgoingDepartureAirport, " +
	                  "A.depDate AS outgoingDepartureDate, A.arrivalThreeLetterId AS outgoingArrivalAirport, A.arrDate AS outgoingArrivalDate, " +
	                  "A.duration AS outgoingDuration, A.planeID AS outgoingPlaneID, A.numOfStops AS outgoingNumOfStops, " +
	                  "B.flightNum AS returnFlightNum, B.twoLetterId AS returnAirline, B.departureThreeLetterId AS returnDepartureAirport, " +
	                  "B.depDate AS returnDepartureDate, B.arrivalThreeLetterId AS returnArrivalAirport, B.arrDate AS returnArrivalDate, " +
	                  "B.duration AS returnDuration, B.planeID AS returnPlaneID, B.numOfStops AS returnNumOfStops " +
	                  "FROM FlightDetails A " +
	                  "JOIN FlightDetails B ON A.arrivalThreeLetterId = B.departureThreeLetterId " +
	                  "WHERE A.departureThreeLetterId = 'EWR' " +
	                  "AND DATE(A.depDate) BETWEEN ? AND ? " +
	                  "AND B.arrivalThreeLetterId = 'EWR' " +
	                  "AND DATE(B.depDate) BETWEEN ? AND ? " +
	                  "AND A.arrivalThreeLetterId = B.departureThreeLetterId"

				);
			
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate start1 = LocalDate.parse(depTime.trim(), dateFormatter).minusDays(flexibility);
			ps1.setString(1, start1.toString());
			LocalDate end1 = LocalDate.parse(depTime.trim(), dateFormatter).plusDays(flexibility);
			ps1.setString(2, end1.toString());
			
			LocalDate start2 = LocalDate.parse(arrTime.trim(), dateFormatter).minusDays(flexibility);
			ps1.setString(3, start2.toString());
			LocalDate end2 = LocalDate.parse(arrTime.trim(), dateFormatter).plusDays(flexibility);
			ps1.setString(4, end2.toString());
			
			ResultSet result = ps1.executeQuery();

			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			
			out.print("<td>");
			out.print("");
			out.print("</td>");
			
				out.print("<td>");
					out.print(" | Flight Number");
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
				out.print("Outgoing");
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingFlightNum"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingAirline"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingDepartureAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingDepartureDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingArrivalAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingArrivalDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingPlaneID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingDuration"));
				out.print("</td>");
				
				
				out.print("<td>");
				out.print(" | " + result.getString("outgoingNumOfStops"));
				out.print("</td>");
				
				out.print("</tr>");
				
				///////////////
				
				out.print("<tr>");
				
				out.print("<td>");
				out.print("Returning");
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnFlightNum"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnAirline"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnDepartureAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnDepartureDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnArrivalAirport"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnArrivalDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnPlaneID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("returnDuration"));
				out.print("</td>");
				
				
				out.print("<td>");
				out.print(" | " + result.getString("returnNumOfStops"));
				out.print("</td>");
				
				out.print("</tr>");
				
				out.print("<tr>");
				out.print(" ");
				out.print("</tr>");

				out.print("<tr>");
				out.print(" ");
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