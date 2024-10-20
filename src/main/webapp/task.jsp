<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   import="java.sql.Connection ,
    java.sql.DriverManager ,java.sql.PreparedStatement,
    java.sql.ResultSet,java.sql.SQLException,java.sql.Statement"%>
    
<%
   boolean insert=false;
   boolean update=false;
   boolean delete=false;
   String userEmail = (String) session.getAttribute("userEmail");
   String sanitizedEmail = userEmail.replace("@", "").replace(".", "");
   String userTableName = sanitizedEmail + "notes";  // Example: dd_gmailcomnotes
   Connection conn = null;
   try {
       Class.forName("com.mysql.cj.jdbc.Driver");
       conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enotedb", "root", "your password");

       // Handling insert operation
       String title = request.getParameter("title");
       String desc = request.getParameter("desc");
       if (title != null && desc != null) {
           String insertQuery = "INSERT INTO " + userTableName + " (note_title, note_description) VALUES (?, ?)";
           PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
           insertStmt.setString(1, title);
           insertStmt.setString(2, desc);
           insertStmt.executeUpdate();
           insert = true;
       }

       // Handling update operation
       String snoEdit = request.getParameter("snoEdit");
       String titleEdit = request.getParameter("titleEdit");
       String descEdit = request.getParameter("descEdit");
       if (snoEdit != null && titleEdit != null && descEdit != null) {
           String updateQuery = "UPDATE " + userTableName + " SET note_title=?, note_description=? WHERE note_id=?";
           PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
           updateStmt.setString(1, titleEdit);
           updateStmt.setString(2, descEdit);
           updateStmt.setString(3, snoEdit);
           updateStmt.executeUpdate();
           update = true;
       }

      //handling delete operation
     String snoDelete = request.getParameter("delete");
     if(snoDelete != null  && !snoDelete.trim().isEmpty()){
    	 //out.println("Delete ID received: " + snoDelete);
    	 PreparedStatement deleteStmt = null;
    	 String deleteQuery = "DELETE FROM " + userTableName + " WHERE note_id=?";
    	 deleteStmt = conn.prepareStatement(deleteQuery);
         deleteStmt.setString(1, snoDelete);
         int rowsAffected = deleteStmt.executeUpdate();
         if (rowsAffected > 0) {
             //out.println("Note deleted successfully.");// Optional: success message
             delete = true;
         } 
     }

   } catch (Exception e) {
       out.println(e.getMessage());
   } finally {
       if (conn != null) {
           conn.close();
       }
   }


%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">  
<link rel="stylesheet" href="//cdn.datatables.net/2.0.3/css/dataTables.dataTables.min.css">        
     
 
<title>Insert title here</title>
</head>
<body> 

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ENotes APP</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="#">Contact Us</a>
                    </li>

                </ul>
                <form class="d-flex " role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>

       <%
        String msgParam=request.getParameter("msg");
        int msg = (msgParam !=null)  ? Integer.parseInt(msgParam):-1;	
        if(msg==2){
     
        %>
             <div class='alert alert-success alert-dismissible fade show' role='alert'>
                    <strong>Success</strong> user logedd in successfully.
                    <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
             </div>    
		        
       <%  } %>


        
      <%
               if (insert) {
       %>         
                            <div class='alert alert-success alert-dismissible fade show' role='alert'>
                              <strong>Success</strong> Note added Successfully.
                              <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                           </div> 
                           
      <%
                } else if (update) {
       %> 
                            <div class='alert alert-success alert-dismissible fade show' role='alert'>
                              <strong>Success</strong> Note Edited Successfully.
                              <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                           </div>         
       <%
               } else if (delete) {
       %>
                             
                            <div class='alert alert-success alert-dismissible fade show' role='alert'>
                              <strong>Success</strong> Note Deleted Successfully.
                              <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                           </div> 
      <%
              }
      %>
     
		        
       
     <!-- edit modal -->
     <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="editModalLabel">Edit Tasks</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action=" " method="post">
                        <input type="hidden" name="snoEdit" id="snoEdit">
                        <!-- <h2>Add a Note</h2> -->
                        <div class="form-group">
                            <label for="title">Task Name</label>
                            <input type="text" class="form-control" id="titleEdit" name="titleEdit" aria-describedby="notetitle">
                        </div>
                        <div class="mb-4">
                            <label for="desc">Task Description</label>
                            <textarea class="form-control" id="descEdit" name="descEdit" rows="3"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Update Task</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    
   
    
    
    
    
    
    
    
    
     <!-- insert update delete alerts here -->
     <!-- for adding a task -->
     <div class="container my-4">
        <form action="task.jsp" method="post">
            <h2>Add a Note</h2>
            <div class="form-group">
                <label for="title">Note Name</label>
                <input type="text" class="form-control" id="title" name="title" aria-describedby="notetitle">
            </div>
            <div class="mb-4">
                <label for="desc">Note Description</label>
                <textarea class="form-control" id="desc" name="desc" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Add Note</button>
        </form>
    </div>
    <div class="container my-4">


         <table class="table" id="myTable">
        <thead>
            <tr>
                <th scope="col">S.no</th>
                <th scope="col">Note Name</th>
                <th scope="col">Note Description</th>
                <th scope="col">Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Assuming the table name is stored in userTableName variable
              
                int sno = 0;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/enotedb", "root", "your password");

                    String sql = "SELECT * FROM " + userTableName;
                    PreparedStatement stmt = connection.prepareStatement(sql);
                    ResultSet result = stmt.executeQuery();

                    // Loop through each task and print it in the table
                    while (result.next()) {
                        sno += 1;
                        String taskId = result.getString("note_id"); // Replace with correct column name
                        String taskName = result.getString("note_title"); // Replace with correct column name
                        String taskDescription = result.getString("note_description"); // Replace with correct column name

                        out.println("<tr>");
                        out.println("<th scope='row'>" + sno + "</th>");
                        out.println("<td>" + taskName + "</td>");
                        out.println("<td>" + taskDescription + "</td>");
                        out.println("<td><button class='edit btn btn-sm btn-primary' id=" + taskId + ">Edit</button> " +
                                    "<button class='delete btn btn-sm btn-primary' id='d" + taskId + "'>Delete</button></td>");
                        out.println("</tr>");
                    }
                    connection.close();
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>


    </div> 
     
      
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

   
    <script src="//cdn.datatables.net/2.0.3/js/dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#myTable').DataTable();
        });
    </script>
    <script>
        edits = document.getElementsByClassName('edit');
        Array.from(edits).forEach((element) => {
            element.addEventListener("click", (e) => {
                console.log("edit ", );
                tr = e.target.parentNode.parentNode;
                title = tr.getElementsByTagName("td")[0].innerText;
                description = tr.getElementsByTagName("td")[1].innerText;
                titleEdit.value = title;
                descEdit.value = description;
                snoEdit.value = e.target.id;
                console.log(e.target.id);
                $('#editModal').modal('toggle');
            })
        })


 

        	
        
       // Get all elements with the class 'delete'
       const deletes = document.getElementsByClassName('delete');

// Convert the HTMLCollection to an array and add event listeners to each element
			Array.from(deletes).forEach((element) => {
			    element.addEventListener("click", (e) => {
			        console.log("Delete button clicked");
			        
			        const buttonId = e.target.id;
			        console.log("Button ID:", buttonId); // Log the button ID
			        
			        // Get the table row (tr) that contains the delete button
			        const tr = e.target.parentNode.parentNode;
			
			        // Retrieve the title and description from the table cells
			        const title = tr.getElementsByTagName("td")[0].innerText;
			        const description = tr.getElementsByTagName("td")[1].innerText;
			
			        // Extract the serial number (sno) from the button's ID
			        const sno = e.target.id.substring(1);
			
			        console.log("Serial Number (sno):", sno);
			        console.log("Title:", title);  // Optional: Log title for debugging
			        console.log("Description:", description);  // Optional: Log description for debugging
			        const deleteUrl = `task.jsp?delete=${sno}`;
                    console.log("Redirecting to:", deleteUrl);
			        // Confirm deletion
			        if (confirm("Are you sure you want to delete this item?")) {
			            console.log("Deletion confirmed");
			            // Redirect to task.jsp with the delete parameter
			            //window.location.href = `task.jsp?delete=${sno}`;
			            const deleteUrl = `task.jsp/?delete=${sno}`;
			            
                       // console.log("Redirecting to:", deleteUrl); // Log the URL
                        window.location.replace("task.jsp?delete="+sno);
                        //window.location.href = deleteUrl; // Redirect
			        } else {
			            console.log("Deletion canceled");
			        }
			    });
			});

        
        
        
        
        
    </script> 
    
    
</body>
</html>