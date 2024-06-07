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
	String keyword = request.getParameter("keyword");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Make a SELECT query from Questions
	String str = "SELECT * FROM Questions";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	
	//Make an HTML table to show the results in:
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("Question");
	out.print("</td>");
	//make a column
	out.print("<td>");
	//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
	out.print(" | Answer");
	out.print("</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		if ((result.getString("question") != null && !result.getString("question").toLowerCase().contains(keyword.toLowerCase())) 
				&& (result.getString("answer") != null && !result.getString("answer").toLowerCase().contains(keyword.toLowerCase()))){
			continue;
		}
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out current bar or beer name:
		out.print(result.getString("question"));
		out.print("</td>");
		out.print("<td>");
		//Print out current bar/beer additional info: Manf or Address
		
		out.print(" | " + result.getString("answer"));
		
		out.print("</td>");
		out.print("</tr>");

	}
	out.print("</table>");

	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>