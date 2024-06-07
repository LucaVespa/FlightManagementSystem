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
	String questionNum = request.getParameter("questionNum");
	String newAnswer = request.getParameter("newAnswer");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	

	
	String insert = "UPDATE Questions SET answer = ? WHERE questionID = ?";
    PreparedStatement ps = con.prepareStatement(insert);

        // Set parameters
     ps.setString(1, newAnswer);
     ps.setString(2, questionNum);

        // Run the query against the DB
     ps.executeUpdate();
	
	response.sendRedirect("qAndARep.jsp");
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>