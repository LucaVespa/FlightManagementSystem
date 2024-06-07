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
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	ResultSet adminResult;
	ResultSet repResult;
	ResultSet customerResult;
	
	adminResult = st.executeQuery("select * from Admin where username='" + userid + "' and password='" + pwd
	+ "'");
	/*repResult = st.executeQuery("select * from Representative where username='" + userid + "' and password='" + pwd
			+ "'");
	customerResult = st.executeQuery("select * from UserAccount where username='" + userid + "' and password='" + pwd
			+ "'");*/
	
	if (adminResult.next()) {
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("welcome " + userid);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("adminSuccess.jsp");
	}else if (st.executeQuery("select * from Representative where username='" + userid + "' and password='" + pwd
			+ "'").next()){
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("welcome " + userid);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("repSuccess.jsp");
	}else if (st.executeQuery("select * from UserAccount where username='" + userid + "' and password='" + pwd
			+ "'").next()){
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("welcome " + userid);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("customerSuccess.jsp");
	}else {
		out.println("Invalid username or password <a href='Login.jsp'>try again</a>");
	}
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	%>
</body>
</html>