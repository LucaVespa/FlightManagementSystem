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
	String flightId = request.getParameter("flightId");
	String airline = request.getParameter("airline");
	String depPort = request.getParameter("depPort");
	String depDate = request.getParameter("depDate");
	String arrPort = request.getParameter("arrPort");
	String arrDate = request.getParameter("arrDate");
	String duration = request.getParameter("duration");
	String planeid = request.getParameter("planeid");
	String stops = request.getParameter("stops");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	if (flightId.isEmpty() || airline.isEmpty() || depPort.isEmpty() || depDate.isEmpty() || arrPort.isEmpty() || arrDate.isEmpty() || duration.isEmpty() || planeid.isEmpty() || stops.isEmpty()){
		out.print("Please do not leave fields blank.");
	
	}else {
	
		
		String insert = "UPDATE FlightDetails SET " +
		"departureThreeLetterId = ?, depDate = ?, arrivalThreeLetterId = ?, arrDate = ?, duration = ?, planeID = ?, numOfStops = ? WHERE flightNum = ? AND twoLetterId = ?";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1,depPort);
	     ps.setString(2,depDate);
	     ps.setString(3,arrPort);
	     ps.setString(4, arrDate);
	     ps.setString(5, duration);
	     ps.setString(6, planeid);
	     ps.setString(7, stops);
	     ps.setString(8, flightId);
	     ps.setString(9, airline);
	     

	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Flight modified.");
		
		
	}
	
	
	
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>