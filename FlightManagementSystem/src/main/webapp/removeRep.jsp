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
	String username = request.getParameter("username");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	String str = "SELECT * FROM Representative WHERE username = ?";
	PreparedStatement ps1 = con.prepareStatement(str);
	ps1.setString(1, username);
	
	ResultSet resultSet = ps1.executeQuery();
	
	if (username.isEmpty()){
		out.print("Username cannot be blank");
	} else if (resultSet.next()) {
		
		String insert = "DELETE FROM Representative WHERE username = ?";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1, username);

	     ps.executeUpdate();
	        
	     out.print(username + " removed.");
	} else {
		out.print("Representative " + username + " does not exist.");
		
	}
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>