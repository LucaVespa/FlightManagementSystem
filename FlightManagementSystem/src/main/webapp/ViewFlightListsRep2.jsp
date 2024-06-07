<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Successful</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
	<%
	try{
	String airportCode = request.getParameter("airportCode");
	
	//Get the database connection
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT * FROM FlightDetails WHERE (departureThreeLetterId = ? OR arrivalThreeLetterId = ?) AND depDate > ? ORDER BY duration";
			PreparedStatement ps1 = con.prepareStatement(str);
			
			
			ps1.setString(1, airportCode);
			ps1.setString(2, airportCode);
			LocalDateTime currentDateTime = LocalDateTime.now();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
		    String currentDate = currentDateTime.format(formatter);
		    ps1.setString(3, currentDate);
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
</body>
</html>