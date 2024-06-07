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
	int ticketNum = Integer.parseInt(request.getParameter("ticketPurchased"));
	String username = String.valueOf(session.getAttribute("user"));
	
	LocalDateTime currentDateTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss");
    String currentDate = currentDateTime.format(formatter);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
		
		
		String insert = "UPDATE FlightTicketTransaction SET username = ?, purchaseDate = ? WHERE ticketid = ?";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1, username);
	     ps.setString(2, currentDate);
	     ps.setInt(3, ticketNum);
	     


	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Ticket " + ticketNum + " purchased.");
	     
	     
	     String str1 = "DELETE FROM WaitsFor " +
                 "WHERE username = ? " +
                 "AND (flightNum, twoLetterId) IN ( " +
                 "  SELECT r.flightNum, r.twoLetterId " +
                 "  FROM RelatesTo r " +
                 "  WHERE r.ticketid = ? " +
                 ");";
		    PreparedStatement ps1 = con.prepareStatement(str1);

		        // Set parameters
		     ps1.setString(1, username);
		     ps1.setInt(2, ticketNum);
		     


		        // Run the query against the DB
		     ps1.executeUpdate();
		        
	     
	 
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>