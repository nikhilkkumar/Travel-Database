<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>One-Way Flights</title>
</head>
<body>
	<%
		String url = "jdbc:mysql://cs336db.c14sne2blqin.us-east-1.rds.amazonaws.com:3306/TravelReservations";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection(url, "admin", "ILoveThisClass");

		//Create a SQL statement
		//Statement stmt = con.createStatement();
		Statement s = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String destination = request.getParameter("destination");
		destination = destination.toUpperCase();
		String departure = request.getParameter("departure");
		departure = departure.toUpperCase();

		String mydate = request.getParameter("departDate");
		Date now = new SimpleDateFormat("yyyy-MM-dd").parse(mydate);
		java.sql.Date departDate = new java.sql.Date(now.getTime());

		// String pFilter = request.getParameter("priceFilter");
		// if (!pFilter.equals("")) {
		// 	int priceFilter = Integer.valueOf(pFilter);
		// } YEAHHHHHHHHHHH THIS PART FOR PRICE FILTER


		//Date departDate = format.parse(mydate);
		//java.util.Date departureDate = format.parse(mydate);
		//java.sql.Date departDate = new java.sql.Date(departureDate.getTime());
		
		
		//Date departDate = request.getParameter("departDate");
		//Make an insert statement for the Sells table:
		//String select = "SELECT * FROM destination WHERE UPPER(destination.city_name)= '" + destination + "'";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		//SELECT d.city_name, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(destination.city_name) = destination AND UPPER(departure.city_name) = departure AND departDate = t.trip_date;

		String ultimatequery = "";
		if (request.getParameter("sorting") == null ) { 
			ultimatequery = ("SELECT d.city_name, f.flight_ID, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) = '" + destination + "' AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date = '" + departDate + "'");
		}
		else{
			if (request.getParameter("sorting").equals("price")) {
				ultimatequery = ("SELECT d.city_name, f.flight_ID, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) ='" + destination + "'AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date ='" + departDate + "' ORDER BY f.fare_econommy");
			}
			else if(request.getParameter("sorting").equals("departureTime")) {
				ultimatequery = ("SELECT d.city_name, f.flight_ID, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) ='" + destination + "' AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date ='" + departDate + "' ORDER BY f.depart_time");
			}
			else if(request.getParameter("sorting").equals("arrivalTime")) {
				ultimatequery = ("SELECT d.city_name, f.flight_ID, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) ='" + destination + "' AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date ='" + departDate + "' ORDER BY f.arrive_time");
			}
			else {
				ultimatequery = ("SELECT d.city_name, f.flight_ID, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) = '" + destination + "' AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date = '" + departDate + "'");
			}
		}

		ResultSet resultset = s.executeQuery(ultimatequery);
		// ResultSet resultset = s.executeQuery("SELECT d.city_name, f.airport_ID, f.flight_Type, f.fare_first, f.fare_econommy, t.trip_date from destination d INNER JOIN flights f ON d.flight_ID = f.flight_ID  INNER JOIN departure de ON de.flight_ID = f.flight_ID INNER JOIN trips t ON f.flight_ID = t.flight_ID WHERE UPPER(d.city_name) = '" + destination + "' AND UPPER(de.city_name) = '" + departure + "' AND t.trip_date = '" + departDate + "'ORDER BY f.fare_econommy");

		%>

		<table border=1>
			<tr>
				<th>Destination City</th><th>Flight ID</th><th>Airport</th><th>Flight Type</th><th>First Class Fare</th><th>Economy Fare</th><th>Departure Date</th>
			</tr>
		<%
			resultset.beforeFirst();
			while(resultset.next()) {             
		%>

           <TR>
               <TD> <%= resultset.getString(1) %> </TD>
               <TD> <%= resultset.getString(2) %> </TD>
               <TD> <%= resultset.getString(3) %> </TD>
               <TD> <%= resultset.getString(4) %> </TD>
               <TD> <%= resultset.getString(5) %> </TD>
               <TD> <%= resultset.getString(6) %> </TD>
               <td> <%= resultset.getString(7) %> </td>
           </TR>
       </TABLE>
       <BR>
       <% 
           } 
           resultset.close();
           con.close();
       %>
       <form method="post" action="createTicket1.jsp">
       	Reserve a Ticket
       	<table>
       		<tr>
       			<th>Enter Flight Number</th>
       			<th>Enter Your Username</th>
       			<th>Reserve First-Class</th>
       			<th>Reserve Economy</th>
       			<br>
       		</tr>
       		<tr>
       			<td><input type="text" placeholder="Flight ID" name="flightNumber"></td>
       			<td><input type="text" placeholder="Username" name="userName"></td>
       			<td><input type="radio" name="flightType" value="F"></td>
       			<td><input type="radio" name="flightType" value="E"></td>
       		</tr>
       	</table>
       	<input type="submit" name="create" value="Reserve">
       </form>
       <form method="post" action="cancelTicket.jsp">
       	Cancel a Ticket
       	<table>
       		<tr>
       			<th>Enter Ticket ID</th>
       		</tr>
       		<tr>
       			<td><input type="text" placeholder="ticket_ID" name="ticket_ID"></td>
       		</tr>
       	</table>
       	<input type="submit" name="Cancel" value="Cancel Reservation">
       </form>
</body>
</html>