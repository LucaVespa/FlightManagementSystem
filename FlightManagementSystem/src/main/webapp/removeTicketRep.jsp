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
	String ticketid = request.getParameter("ticketid");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	if (ticketid.isEmpty()){
		out.print("Please do not leave fields blank.");
	
	}else{
	
		String insert = "DELETE FROM FlightTicketTransaction WHERE ticketid = ?";
		PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1,ticketid);
	     

	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Ticket deleted.");
	}
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>