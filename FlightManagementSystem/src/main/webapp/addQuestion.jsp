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
	String newQuestion = request.getParameter("newQuestion");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FlightManagementSystem","root",
	"samplePassword");
	Statement st = con.createStatement();
	
	String str = "SELECT MAX(questionID) FROM Questions";
	ResultSet quesResult = st.executeQuery(str);
	
	  int idNum = 0;

      if (quesResult.next()) {
          // Move the cursor to the first row of the result set
          idNum = quesResult.getInt(1);
      }

      idNum++;
	
	//int idNum = Integer.parseInt(quesResult.getString("MAX(questionID)"));
	//idNum++;
	
	String insert = "INSERT INTO Questions(questionID, question, answer) "
			+ "VALUES (?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setInt(1, idNum);
	ps.setString(2, newQuestion);
	ps.setString(3, null);
	//Run the query against the DB
	ps.executeUpdate();
	
	response.sendRedirect("qAndA.jsp");
	
	
	con.close();
	} catch (Exception e) {
		out.print(e);
	}
	
	%>
</body>
</html>