<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
	String username = String.valueOf(session.getAttribute("user"));
	String flightNum = request.getParameter("flightNum");
	String airline = request.getParameter("airline");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
		
		
		String insert = "INSERT INTO WaitsFor(username, flightNum, twoLetterId) VALUES (?,?,?)";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1, username);
	     ps.setString(2, flightNum);
	     ps.setString(3, airline);
	     


	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Added " + username + "to waitlist for flight " + airline + flightNum);
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>