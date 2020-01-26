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
	Search for a destination:
	<br>
		<form method="post" action="showDestinationResults.jsp">
		<table> 
		<tr>    
		<td><input type="text" placeholder="Destination" name="destination" required></td>
		</tr>
		<tr>
			<td><input type="text" placeholder="Departure" name="departure" required></td>
		</tr>
		<tr>
			<td><input type="date" placeholder="Departure Date" name="departDate" required></td>
		</tr>
		<br>
		</table>
		<table>
			Sort By:
			<tr>
				<td><input type="radio" name="sorting" value="price">Price</td>
				<td><input type="radio" name="sorting" value="departureTime">Departure Time</td>
				<td><input type="radio" name="sorting" value="arrivalTime">Arrival Time</td>
			</tr>
		</table>
		<input type="submit" name="create" value="Search">
		</form>
</script>
	<br>
</body>
</html>

