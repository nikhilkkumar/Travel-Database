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
	<table border="2">
	<tr>
		<td>ticket_ID</td>
		<td>round_trip</td>
		<td>booking_fee</td>
		<td>issue_date</td>
		<td>total_fare</td>
		<td>custUsername</td>
		<td>canChange</td>
		<td>flightID</td>
		</tr>
	<%
	try {
		String url = "jdbc:mysql://cs336db.c14sne2blqin.us-east-1.rds.amazonaws.com:3306/TravelReservations";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection(url, "admin", "ILoveThisClass");

		//Create a SQL statement
		
		String username=request.getParameter("custUsername");
		String query = "select * from tickets where custUsername='"+username+"';";
		Statement stmt = con.createStatement();

		ResultSet rs=stmt.executeQuery(query);
		while(rs.next())
		{

		%>
    	<tr><td><%=rs.getInt("Ticket_ID"); %></td></tr>
    	<tr><td><%=rs.getInt("round_trip"); %></td></tr>
    	<tr><td><%=rs.getInt("booking_fee"); %></td></tr>
    	<tr><td><%=rs.getDate("issue_date"); %></td></tr>
    	<tr><td><%=rs.getInt("total_fare"); %></td></tr>
    	<tr><td><%=rs.getString("custUsername"); %></td></tr>
    	<tr><td><%=rs.getInt("canChange"); %></td></tr>
    	<tr><td><%=rs.getInt("flightID"); %></td></tr>
        <%

}
%>
    </table>
    <%
    rs.close();
    stmt.close();
    conn.close();
    }
catch(Exception e)
{
		out.print(ex);
		out.print("show tix failed");
	}
%>
</body>
</html>