<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Connection ,
    java.sql.DriverManager ,java.sql.PreparedStatement,
    java.sql.ResultSet,java.sql.SQLException,java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
     
      <%
		      String name = request.getParameter("name");
		      String email = request.getParameter("email");
		      String password = request.getParameter("password");
		      String confirmPassword = request.getParameter("confirmPassword");
		      int flag = -1;//flag = 0 password mismatch , flag =1 existing user flag =2 for signup success  flag =4 for error
		      
		      if (!password.equals(confirmPassword)) {
		    	   
		    	     flag=0;
		    	     response.sendRedirect("landing.jsp?flag=" + flag); 
		            
		           
		            return;
		        }
		      try {
		    	    //DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		            Class.forName("com.mysql.cj.jdbc.Driver");
		            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enotedb", "root", "your password");

		            // Step 3: Check if the user already exists
		            String checkUserQuery = "SELECT * FROM users WHERE email = ?";
		            PreparedStatement checkUserStmt = conn.prepareStatement(checkUserQuery);
		            checkUserStmt.setString(1, email);
		            ResultSet rs = checkUserStmt.executeQuery();

		            if (rs.next()) {
		               
		                flag = 1;
		                //response.sendRedirect("landing.jsp?" + flag);
		            } else {
		                // Step 4: Insert new user into the database
		                String insertUserQuery = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
		                PreparedStatement insertUserStmt = conn.prepareStatement(insertUserQuery);
		                insertUserStmt.setString(1, name);
		                insertUserStmt.setString(2, email);
		                insertUserStmt.setString(3, password);
		                insertUserStmt.executeUpdate();

		                
		                //create table dynamically from user's email
		                String sanitizedEmail = email.replace("@", "").replace(".", ""); // Remove invalid characters
		                String tableName = sanitizedEmail + "notes"; // Example: dd_gmailcomnotes

		                String createTableQuery = "CREATE TABLE " + tableName + " ("
		                        + "note_id INT AUTO_INCREMENT PRIMARY KEY, "
		                        + "note_title VARCHAR(255), "
		                        + "note_description TEXT, "
		                        + "note_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
		                        + "user_email VARCHAR(255), "
		                        + "FOREIGN KEY (user_email) REFERENCES users(email)"
		                        + ")";

		                Statement createTableStmt = conn.createStatement();
		                createTableStmt.executeUpdate(createTableQuery);
		                
		                
		                flag = 2;
		                
		                
		                //response.sendRedirect("landing.jsp?" + flag);
		            }

		            conn.close();
		        }catch (SQLException e) {
		        	//e.printStackTrace();
			           //out.println("sql not found");
			           out.println(e.getMessage());
			           e.printStackTrace();
			           //session.setAttribute("flag",4);
			          // request.setAttribute("flag",4);
			           flag =4;
			            //response.sendRedirect("landing.jsp?"+flag);
			        }
		       catch (Exception e) {
		        	//e.printStackTrace();
		           out.println("class not found");
		           //session.setAttribute("flag",4);
		          // request.setAttribute("flag",4);
		           flag =4;
		            //response.sendRedirect("landing.jsp?"+flag);
		        }
		        
		      response.sendRedirect("landing.jsp?flag=" + flag);
		    
          
      %>
</body>
</html>