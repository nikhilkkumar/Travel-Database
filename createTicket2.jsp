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
		Statement querystmt2 = con.createStatement();

		//Get parameters from the HTML form at the (Nihar's page).jsp so update this one after seeing his page
		int flight = Integer.parseInt(request.getParameter("flightNumber"));
		int flight2 = Integer.parseInt(request.getParameter("flightNumber2"));
		String classFlight = request.getParameter("flightType");
		String query="";
		String query2 = "";
		int canC=0;
		if(classFlight.equals("F")){
			query="select fare_first from flights where flight_ID='"+flight+"';";
			query2="select fare_first from flights where flight_ID='"+flight2+"';";
			canC=1;
		}
		else{
			query="select fare_econommy from flights where flight_ID='"+flight+"';";
			query2="select fare_econommy from flights where flight_ID='"+flight2+"';";
		}
		
		ResultSet tempfare = querystmt.executeQuery(query);
		int fare = ((Number) tempfare.getObject(1)).intValue();
		ResultSet tempfare2 = querystmt.executeQuery(query2);
		int fare2= ((Number) tempfare2.getObject(1)).intValue();
		//Integer.parseInt(tempfare);
		querystmt.close();
		querystmt2.close();

		String custUsername=request.getParameter("userName");
		//String customer = request.getParameter("custUsername");
		fare+=35;
		fare2+=35;
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
		String queryTwo = "select ticket_ID from tickets order by ticket_ID desc limit 1;";
		ResultSet rst = tStmt.executeQuery(queryTwo);
		int ticketID = ((Number) rst.getObject(1)).intValue();
		ticketID++;
		int ticketID2=ticketID++;
		tStmt.close(); %>


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
			<td><%= "Yes" %></td>
			<td><%= "$35" %></td>
			<td><%= returnDate %></td>
			<td><%= fare2 %></td>
			<td><%= custUsername %></td>
			<td><%= canC %></td>
			<td><%= flight %></td>
	</table>
		<%

		//String insert = "INSERT INTO tickets (round_trip, booking_fee,issue_date, total_fare, custUsername)"
	//			+ "VALUES (0,35,'"result.getString("date")+fare+"','"+custUsername+"');";
		String insert = "INSERT INTO tickets (ticket_ID, round_trip, booking_fee,issue_date, total_fare, custUsername,canChange,flight_ID)"
				+ "VALUES (?,?,?,?,?,?,?,?);";
		String insert2 = "INSERT INTO tickets (ticket_ID, round_trip, booking_fee, issue_date, total_fare, custUsername,canChange,flight_ID)" + "VALUES(?,?,?,?,?,?,?,?);";

		PreparedStatement ps = con.prepareStatement(insert);
		PreparedStatement ps2 = con.prepareStatement(insert2);
		ps.setInt(1,ticketID);
		ps.setInt(2, 1);
		ps.setInt(3, 35);
		ps.setDate(4, returnDate);
		ps.setInt(5, fare);
		ps.setString(6, custUsername);
		ps.setInt(7, canC);
		ps.setInt(8,flight);
		ps.execute();

		ps2.setInt(1,ticketID2);
		ps2.setInt(2, 1);
		ps2.setInt(3, 35);
		ps2.setDate(4, returnDate);
		ps2.setInt(5, fare2);
		ps2.setString(6, custUsername);
		ps2.setInt(7,canC);
		ps2.setInt(8,flight);
		ps2.execute();
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