<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Create an account:
	<br>
		<form method="post" action="createUser.jsp">
		<table> 
		<tr>    
		<td><input type="text" placeholder="Username" name="username" required></td>
		</tr>
		<tr>
		<td><input type="password" placeholder="Password" name="password" id="password" required></td>
		</tr>
		<tr>
		<td><input type="password" placeholder="Confirm Password" name="confirmpass" id="confirmpass" required></td>
		</tr>
		</table>
		<input type="submit" name="create" value="Create an account">
		</form>
</script>
	<br>
</body>
</html>