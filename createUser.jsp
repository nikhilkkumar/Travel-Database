<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account Page</title>
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
		//Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm = request.getParameter("confirmpass");

		if (!password.equals(confirm)){
			response.sendRedirect("failedCreate.jsp");
		}else {
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO users (username, password)"
					+ "VALUES (?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, username);
			ps.setString(2, password);
			try{
				ps.executeUpdate();
				response.sendRedirect("showLoginUser.jsp");			
			}catch (Exception e) {
				response.sendRedirect("failedCreate.jsp");
			}
			//Run the query against the DB
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			ps.close();
			con.close();
		}
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
</body>
</html>