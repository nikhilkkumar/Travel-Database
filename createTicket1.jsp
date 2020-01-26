<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		String url = "jdbc:mysql://cs336db.c14sne2blqin.us-east-1.rds.amazonaws.com:3306/TravelReservations";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection(url, "admin", "ILoveThisClass");

		//Create a SQL statement
		Statement querystmt = con.createStatement();

		//Get parameters from the HTML form at the (Nihar's page).jsp so update this one after seeing his page
		int flight = Integer.parseInt(request.getParameter("flightNumber"));
		String classFlight = request.getParameter("flightType");
		String query="";
		int canC =0;
		if(classFlight.equals("F")){
			query="select fare_first from flights where flight_ID='"+flight+"';";
			canC=1;
		}
		else{
			query="select fare_econommy from flights where flight_ID='"+flight+"';";
		}
		
		ResultSet tempfare = querystmt.executeQuery(query);
		int fare = ((Number) tempfare.getObject(1)).intValue();
		//Integer.parseInt(tempfare);
		querystmt.close();
		String custUsername=request.getParameter("userName");
		//String customer = request.getParameter("custUsername");
		fare+=35;
		java.util.Date today = new java.util.Date();
		java.text.SimpleDateFormat df= new java.text.SimpleDateFormat("yyyy-MM-dd");
		String date=df.format(today);
		
		//sql to creat tickets tuple

		//Make an insert statement for the tickets table:
		
		String datesql="select current_date() as date";
		Statement datestmt = con.createStatement();
			//Run the query against the database.
		ResultSet resultset = datestmt.executeQuery(datesql);
		String thedate = resultset.getString(1);
		Date later = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
		java.sql.Date returnDate = new java.sql.Date(later.getTime());

		Statement tStmt = con.createStatement();
		String query2 = "select ticket_ID from tickets order by ticket_ID desc limit 1;";
		ResultSet rst = tStmt.executeQuery(query2);
		int ticketID = ((Number) rst.getObject(1)).intValue();
		ticketID++;
		tStmt.close();
		%>

		<table border=1 >
		<tr>
			<th>Ticket ID</th>
			<th>Round Trip</th>
			<th>Booking Fee</th>
			<th>Issue Date</th>
			<th>Total Fare</th>
			<th>Username</th>
			<th>Can Change?</th>
			<th>Flight ID</th>
		</tr>
		<tr>
			<td><%= ticketID %></td>
			<td><%= "No" %></td>
			<td><%= "$35" %></td>
			<td><%= returnDate %></td>
			<td><%= fare %></td>
			<td><%= custUsername %></td>
			<td><%= canC %></td>
			<td><%= flight %></td>
	</table>
		<%

		//String insert = "INSERT INTO tickets (round_trip, booking_fee,issue_date, total_fare, custUsername)"
	//			+ "VALUES (0,35,'"result.getString("date")+fare+"','"+custUsername+"');";
		String insert = "INSERT INTO tickets (ticket_ID,round_trip, booking_fee,issue_date, total_fare, custUsername,canChange,flightID)"
				+ "VALUES (?,?,?,?,?,?,?,?);";

		PreparedStatement ps = con.prepareStatement(insert);
		ps.setInt(1,ticketID);
		ps.setInt(2, 0);
		ps.setInt(3, 35);
		ps.setDate(4, returnDate);
		ps.setInt(5, fare);
		ps.setString(6, custUsername);
		ps.setInt(7,canC);
		ps.setInt(8,flight);
		ps.execute();
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		ps.close();
		con.close();
		out.print("insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("reservation creation failed");
	}
%>
</body>
</html>