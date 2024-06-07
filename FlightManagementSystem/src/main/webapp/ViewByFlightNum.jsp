<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

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
			
			String flightnum = request.getParameter("flightnum");
			String airline = request.getParameter("airline");
			
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String str = "SELECT * FROM FlightTicketTransaction f JOIN RelatesTo r ON f.ticketid = r.ticketid " 
					+ "JOIN FlightDetails d ON r.flightNum = d.flightNum WHERE d.flightNum = ? AND d.twoLetterId = ?";
			//Run the query against the database.
			PreparedStatement ps = con.prepareStatement(str);

	        // Set parameters
	     	ps.setString(1,flightnum);
	     	ps.setString(2,airline);
	     	ResultSet result = ps.executeQuery();
			
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
					out.print(" | Ticket Owner");
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
				out.print(" | " + result.getString("username"));
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