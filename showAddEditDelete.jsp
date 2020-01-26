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
	Aircrafts
	<br>
		<form method="post" action="Add.jsp">
		<table> 
		<tr>Please enter aircraft ID    
		<td><input type="text" placeholder="Aircraft ID" name="aAircraftID" required></td>
		</tr>
		<tr>Please enter airline ID
		<td><input type="text" placeholder="Airline ID" name="aAirlineID" required></td>
		</tr>
		</table>
		Please enter Add, Edit or Delete
		<input type="text" placeholder="add,edit,delete">
		</form>
	<br>
	Airlines
		<form method="post" action="add.jsp">
		<table> 
		<tr>Please enter airline ID    
		<td><input type="text" placeholder="Airline ID" name="lAirlineID" required></td>
		</tr>
		<tr>Please enter airline name
		<td><input type="text" placeholder="Airline name" name="lAirlinename" required></td>
		</tr>
		</table>
		Please enter Add, Edit or Delete
		<input type="text" placeholder="add,edit,delete">
		</form>
	<br>
	Flights
		<form method="post" action="add.jsp">
		<table> 
		<tr>Please enter airline ID    
		<td><input type="text" placeholder="Airline ID" name="fAirlineID" required></td>
		</tr>
		<tr>Please enter airport ID    
		<td><input type="text" placeholder="Airport ID" name="AirportID" required></td>
		</tr>
		<tr>Please enter aircraft ID    
		<td><input type="text" placeholder="Aircraft ID" name="fAircraftID" required></td>
		</tr>
		<tr>Please enter flight ID
		<td><input type="text" placeholder="flight ID" name="flightID" required></td>
		</tr>
		<tr>Please enter flight type    
		<td><input type="text" placeholder="flight type" name="flightType" required></td>
		</tr>
		<tr>Please enter depart time    
		<td><input type="text" placeholder="depart time" name="departTime" required></td>
		</tr>
		<tr>Please enter arrive time    
		<td><input type="text" placeholder="arrive time" name="arriveTime" required></td>
		</tr>
		<tr>Please enter first class fare    
		<td><input type="text" placeholder="first class fare" name="firstFare" required></td>
		</tr>
		<tr>Please enter economy class fare    
		<td><input type="text" placeholder="economy class fare" name="economyFare" required></td>
		</tr>
		</table>
		Please enter Add, Edit or Delete
		<input type="text" placeholder="add,edit,delete">
		</form>
</script>
	<br>
</body>
</html>