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
		
		Statement querystmt = con.createStatement();
		int ticketID = Integer.parseInt(request.getParameter("ticket_ID"));
		ResultSet tempfare = querystmt.executeQuery("select canChange from tickets where Ticket_ID='"+ticketID+"'");
		int cc = ((Number) tempfare.getObject(1)).intValue();
		String query="";
		if(cc==1){
			query="delete from tickets where ticket_ID='" +ticketID+"'";
		} else {
			out.print("You cannot cancel because you are not First Class");
		}

		PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		ps.close();
		con.close();
		out.print("cancellation was successful");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("cancellation was unsuccessful");
	}
%>
</body>
</html>