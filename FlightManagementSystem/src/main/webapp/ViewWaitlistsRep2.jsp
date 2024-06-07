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
			String flightNum = request.getParameter("flightNum");
			String airline = request.getParameter("airline");
			//Get the database connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
			"samplePassword");
			Statement st = con.createStatement();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from Questions
			String insert = "SELECT username FROM WaitsFor WHERE flightNum = ? AND twoLetterId = ?";
    		PreparedStatement ps = con.prepareStatement(insert);

        // Set parameters
     		ps.setString(1, flightNum);
     		ps.setString(2, airline);
     		ResultSet result = ps.executeQuery();
			//Make an HTML table to show the results in:
				out.print("Customers the Waitlist for Flight " + airline + flightNum + ":");
			out.print("<table>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getString("username"));
				out.print("</td>");

				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
			
		%>
		<%}
		%>
	

	</body>
</html>