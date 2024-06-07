<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="login.jsp">Please Login</a>
<%} else {
%>
	Add Representative
	<form action="addRep.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			Password: <input type="text" name="password"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	<br/>
	Edit Representative
	<form action="editRep.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			New Username: <input type="text" name="newUsername"/> <br/>
			Password: <input type="text" name="password"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	<br/>
	Remove Representative
	<form action="removeRep.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			<input type="submit" value="Submit"/>
	</form>
	
<%
	}
%>

</body>
</html>