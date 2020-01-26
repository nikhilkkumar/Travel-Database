<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		Statement stmt = con.createStatement();
		int aAircraftID=request.getParameter(aAircraftID);
		int aAirlineID=request.getParameter(aAirlineID);
		int lAirlineID=request.getParameter(lAirlineID);
		String lAirlinename=request.getParameter(lAirlinename);
		int fAircraftID=request.getParameter(fAircraftID);
		int fAirlineID=request.getParameter(fAirlineID);
		int fAirportID=request.getParameter(fAirlineID);
		int flightID=request.getParameter(flightID);
		int flightType=request.getParameter(flightType);
		
		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");


		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users (username, password)"
				+ "VALUES (?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, 'vineeth2');
		ps.setString(2, 'pass2');
		ps.executeUpdate();
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		ps.close();
		con.close();
		out.print("insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("edit failed");
	}
%>
</body>
</html>