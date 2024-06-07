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
	String ticketNum = request.getParameter("ticketNum");
	String username = request.getParameter("username");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	
	String insert = "UPDATE FlightTicketTransaction SET username = NULL, purchaseDate = NULL WHERE ticketid = ? AND username = ?";
   PreparedStatement ps = con.prepareStatement(insert);
       // Set parameters
    ps.setString(1, ticketNum);
    ps.setString(2, username);
       // Run the query against the DB
    ps.executeUpdate();
	
    response.sendRedirect("CustomerEditRep.jsp");
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>



