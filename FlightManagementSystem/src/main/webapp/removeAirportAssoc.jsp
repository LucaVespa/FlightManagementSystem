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
	String airportID = request.getParameter("airportID");
	String airlineID = request.getParameter("airlineID");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	String insert = "DELETE FROM AssociatedWith WHERE threeLetterId = ? AND twoLetterId = ?";
    PreparedStatement ps = con.prepareStatement(insert);
    ps.setString(1, airportID);
    ps.setString(2, airlineID);
	ps.executeUpdate();

	response.sendRedirect("ModifyAirInfoRep.jsp");

	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>