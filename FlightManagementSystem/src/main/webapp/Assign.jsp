<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String flightId = request.getParameter("flightnum");
	String airline = request.getParameter("airline");
	String ticketid = request.getParameter("ticketid");

	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	if (flightId.isEmpty() || airline.isEmpty()){
		out.print("Please do not leave fields blank.");
	
	}else {
	
		
		String insert = "INSERT INTO RelatesTo(flightNum, twoLetterID, ticketid) VALUES (?,?,?) ";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters;
	     ps.setString(1, flightId);
	     ps.setString(2, airline);
	     ps.setString(3, ticketid);
	     

	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Ticked Assigned.");
		
		
	}
	
	
	
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>