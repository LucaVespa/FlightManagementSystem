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
		
		View Sales Report for a Specific Month
		<form action="RevenueSummaryByMonth.jsp" method="POST">
			Year (YYYY): <input type="text" name="year"/> <br/>
			Month (MM): <input type="text" name="month"/> <br/>
			<input type="submit" value="Submit"/><br/>
		</form>
		<br/>
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
			String str = "SELECT " +
    		"ua.username, " +
    		"SUM(ftt.farePrice) AS totalFarePrice, " +
    		"SUM(ftt.bookingFee) AS totalBookingFees, " +
    		"SUM(ftt.farePrice + ftt.bookingFee) AS totalAmountSpent " +
			"FROM " +
    		"UserAccount ua " +
			"JOIN " +
    		"FlightTicketTransaction ftt ON ua.username = ftt.username " +
			"WHERE " +
    		"ua.username IS NOT NULL " +
    		"GROUP BY " +
    	    "ua.username " +
    		"ORDER BY " +
    	    "totalAmountSpent DESC";

			PreparedStatement ps1 = con.prepareStatement(str);

			
			ResultSet result = ps1.executeQuery();
				
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
				out.print("<td>");
					out.print("Username");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Total Expenses");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Ticket Fare Expenses");
				out.print("</td>");
				
				out.print("<td>");
					out.print(" | Booking Fee Expenses");
				out.print("</td>");

			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("username"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("totalAmountSpent"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("totalFarePrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(" | " + result.getString("totalBookingFees"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			out.print("--------------------");
			String str2 = "SELECT " +
				    "ac.twoLetterid AS airlineCompany, " +
				    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.farePrice ELSE 0 END) AS totalFarePrice, " +
				    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.bookingFee ELSE 0 END) AS totalBookingFees, " +
				    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.farePrice + ftt.bookingFee ELSE 0 END) AS totalAmountSpent " +
				"FROM " +
				    "AirlineCompany ac " +
				"LEFT JOIN " +
				    "FlightDetails fd ON ac.twoLetterid = fd.twoLetterId " +
				"LEFT JOIN " +
				    "RelatesTo r ON fd.flightNum = r.flightNum AND fd.twoLetterId = r.twoLetterId " +
				"LEFT JOIN " +
				    "FlightTicketTransaction ftt ON r.ticketid = ftt.ticketid " +
				"GROUP BY " +
				    "ac.twoLetterid " +
				"ORDER BY " +
				    "totalAmountSpent DESC;";


					PreparedStatement ps2 = con.prepareStatement(str2);

					
					ResultSet result2 = ps2.executeQuery();
						
					//Make an HTML table to show the results in:
					out.print("<table>");

					//make a row
					out.print("<tr>");
						out.print("<td>");
							out.print("Airline Company");
						out.print("</td>");
						
						out.print("<td>");
							out.print(" | Total Revenue");
						out.print("</td>");
						
						out.print("<td>");
							out.print(" | Ticket Fare Revenue");
						out.print("</td>");
						
						out.print("<td>");
							out.print(" | Booking Fee Revenue");
						out.print("</td>");

					out.print("</tr>");

					//parse out the results
					while (result2.next()) {
						//make a row
						out.print("<tr>");

						out.print("<td>");
						out.print(result2.getString("airlineCompany"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(" | " + result2.getString("totalAmountSpent"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(" | " + result2.getString("totalFarePrice"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(" | " + result2.getString("totalBookingFees"));
						out.print("</td>");
						
						out.print("</tr>");

					}
					out.print("</table>");
			
					
					out.print("--------------------");
					String str3 = "SELECT " +
						    "fd.flightNum, " +
						    "fd.twoLetterId AS airlineCompany, " +
						    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.farePrice ELSE 0 END) AS totalFarePrice, " +
						    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.bookingFee ELSE 0 END) AS totalBookingFees, " +
						    "SUM(CASE WHEN ftt.username IS NOT NULL THEN ftt.farePrice + ftt.bookingFee ELSE 0 END) AS totalAmountSpent " +
						"FROM " +
						    "FlightDetails fd " +
						"LEFT JOIN " +
						    "RelatesTo r ON fd.flightNum = r.flightNum AND fd.twoLetterId = r.twoLetterId " +
						"LEFT JOIN " +
						    "FlightTicketTransaction ftt ON r.ticketid = ftt.ticketid " +
						"GROUP BY " +
						    "fd.flightNum, fd.twoLetterId " +
						"ORDER BY " +
						    "totalAmountSpent DESC;";



							PreparedStatement ps3 = con.prepareStatement(str3);

							
							ResultSet result3 = ps3.executeQuery();
								
							//Make an HTML table to show the results in:
							out.print("<table>");

							//make a row
							out.print("<tr>");
								out.print("<td>");
									out.print("Flight Number");
								out.print("</td>");
								
								out.print("<td>");
									out.print(" | Airline Company");
								out.print("</td>");
								
								out.print("<td>");
									out.print(" | Total Revenue");
								out.print("</td>");
								
								out.print("<td>");
									out.print(" | Ticket Fare Revenue");
								out.print("</td>");
								
								out.print("<td>");
									out.print(" | Booking Fee Revenue");
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
								out.print(" | " + result3.getString("airlineCompany"));
								out.print("</td>");
								
								out.print("<td>");
								out.print(" | " + result3.getString("totalAmountSpent"));
								out.print("</td>");
								
								out.print("<td>");
								out.print(" | " + result3.getString("totalFarePrice"));
								out.print("</td>");
								
								out.print("<td>");
								out.print(" | " + result3.getString("totalBookingFees"));
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