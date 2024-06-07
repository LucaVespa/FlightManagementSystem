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
	String password = request.getParameter("password");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	String str = "SELECT * FROM UserAccount WHERE username = ?";
	PreparedStatement ps1 = con.prepareStatement(str);
	ps1.setString(1, username);
	
	ResultSet resultSet = ps1.executeQuery();
	
	if (resultSet.next()) {
		out.print("User " + username + " already exists");
		
	} else if (username.isEmpty()){
		out.print("Username cannot be blank");
	}else if (password.isEmpty()){
		out.print("Password cannot be blank");
	}else {
		String insert = "INSERT INTO UserAccount (username, password, fname, lname) VALUES (?, ?, ?, ?)";
	    PreparedStatement ps = con.prepareStatement(insert);

	        // Set parameters
	     ps.setString(1, username);
	     ps.setString(2, password);
	     ps.setString(3, fname.isEmpty() ? null : fname);
	     ps.setString(4, lname.isEmpty() ? null : lname);
	     


	        // Run the query against the DB
	     ps.executeUpdate();
	        
	     out.print(username + " added.");
	}
	
	
	
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>