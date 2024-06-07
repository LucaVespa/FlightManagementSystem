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
	String seatnum = request.getParameter("seatnum");
	String price = request.getParameter("price");
	String classtype = request.getParameter("class");
	String bookingfee = request.getParameter("bookingfee");
	String cancelfee = request.getParameter("cancelfee");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	if (ticketid.isEmpty() || seatnum.isEmpty() || price.isEmpty() || classtype.isEmpty() || bookingfee.isEmpty() || cancelfee.isEmpty()){
		out.print("Please do not leave fields blank.");
	
	}else{
	
		
		String insert = "UPDATE FlightTicketTransaction SET " +
		"seatNumber = ?, farePrice = ?, class = ?, bookingFee = ?, cancelFee = ? WHERE ticketid = ?";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1,seatnum);
	     ps.setString(2,price);
	     ps.setString(3, classtype);
	     ps.setString(4, bookingfee);
	     ps.setString(5, cancelfee);
	     ps.setString(6,ticketid);
	     

	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print("Ticket updated.");
	}
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>