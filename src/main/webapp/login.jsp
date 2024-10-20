<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Connection ,java.sql.DriverManager ,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
		 String email = request.getParameter("email");
		 String password = request.getParameter("password");
		 int msg = -1;
		 //String message = "";
		 try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enotedb", "root", "your password");

		        // Query to check the user's credentials
		        String loginQuery = "SELECT * FROM users WHERE email = ? AND password = ?";
		        PreparedStatement stmt = conn.prepareStatement(loginQuery);
		        stmt.setString(1, email); // set the first parameter
		        stmt.setString(2, password); // set the second parameter
		        ResultSet rs = stmt.executeQuery();

		        if (rs.next()) {
		            // User found, login successful
		            msg = 2; // for successful login
		            session.setAttribute("userEmail", email);
		           // message = "Login successful! Welcome, " + email;
		            // Redirect to a welcome page or dashboard
		            response.sendRedirect("task.jsp?msg=" + msg);
		            
		        } else {
		            // Invalid credentials
		            msg = 1; // for invalid login
		            //message = "Invalid email or password.";
		            response.sendRedirect("landing.jsp?msg=" + msg);		
		            		
		        }
		        
		        conn.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        msg = 4; // for database error
		        response.sendRedirect("landing.jsp?msg=" + msg);
		        //message = "Database error: " + e.getMessage();
		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		        msg = 4; // for database error
		        response.sendRedirect("landing.jsp?msg=" + msg);
		        //message = "Driver not found: " + e.getMessage();
		    }
		    
		   
 %>
</body>
</html>