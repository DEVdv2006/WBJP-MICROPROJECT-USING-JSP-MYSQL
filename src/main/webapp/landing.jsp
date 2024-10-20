<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Welcome to ENotes. Heaven for coding enthusiasts. Explore coding trends, technology, and more.">
    
    <!-- Bootstrap CSS -->
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
     <link rel="style.css">
    <title>ENotes - Take Notes effeciently</title>
</head>
<body>
   <%request.setAttribute("flag",-1);
    request.setAttribute("msg",-1);		
    		%>
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">ENotes APP</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Home</a>
                </li>
            </ul>
            <div class="d-flex">
                <button class="btn btn-danger mx-2" data-toggle="modal" data-target="#loginModal">Login</button>
                <button class="btn btn-danger mx-2" data-toggle="modal" data-target="#signupModal">SignUp</button>
            </div>
        </div>
    </div>
  </nav>
  
  
  
  
  
  
  
        
  
  
  
    		
   
     <% String msgParam=request.getParameter("msg");
     int msg = (msgParam !=null)  ? Integer.parseInt(msgParam):-1;	
     if(msg==1){ 
     %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
		        <strong>Error:</strong> Invalid email or password
		        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		        </button>
		   </div>
     	          
     <% }else if(msg==4){
     %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error:</strong> problem logging in try again later
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        </div>
     <%} %>
     
     
     
      <% String flagParam = request.getParameter("flag");
	     int flag = (flagParam != null) ? Integer.parseInt(flagParam) : -1;
			    
			  
			    // Display the corresponding alert message based on the flag value
			  if (flag == 0) {
     %>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <strong>Error:</strong> Password and Confirm Password do not match!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
   <%
                  } else if (flag == 1) {
   %>
       <div class="alert alert-danger alert-dismissible fade show" role="alert">
	        <strong>Error:</strong> User already exists with this email!
	        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	        </button>
      </div>
  <%
         } else if (flag == 2) {
   %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
	        <strong>Success:</strong> User registered successfully! please login to access service
	        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	        </button>
        </div>
   <%
             } else if (flag == 4) {
   %>
         <div class="alert alert-danger alert-dismissible fade show" role="alert">
               <strong>Error:</strong> An error occurred during signup. Please try again later.
               <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                   <span aria-hidden="true">&times;</span>
               </button>
           </div>
   <%
         }
   %>
     
     
     
     
     
     
     
     <!-- Login Modal -->
  <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Login to ENotes</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form action="login.jsp" method="POST">
                <div class="form-group">
                  <label for="exampleInputEmail1">Email address</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email">
                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control" id="exampleInputPassword1" name="password">
                </div>
                <div class="form-group form-check">
                  <input type="checkbox" class="form-check-input" id="exampleCheck1">
                  <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
              </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
        </div>
      </div>
    </div>
  </div>
 
  
  <!-- Sign Up Modal -->
  <div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Get an ENotes Account</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form action="signup.jsp" method="POST">
                 <div class="form-group">
                    <label for="formGroupExampleInput">Name</label>
                    <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Enter your name" name="name">
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail1">Email address</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email">
                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control" id="exampleInputPassword1" name="password">
                </div>
                <div class="form-group">
                  <label for="cexampleInputPassword1">Confirm Password</label>
                  <input type="password" class="form-control" id="cexampleInputPassword1" name="confirmPassword">
                </div>
                 
                <button type="submit" class="btn btn-primary">Create Account</button>
              </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
        </div>
      </div>
    </div>
  </div>
  
  

<!-- Login Modal -->
  <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Login to ENotes</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form action="/signup" method="post">
                <div class="form-group">
                  <label for="exampleInputEmail1">Email address</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control" id="exampleInputPassword1">
                </div>
                <div class="form-group form-check">
                  <input type="checkbox" class="form-check-input" id="exampleCheck1">
                  <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
              </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
        </div>
      </div>
    </div>
  </div>
 
  
  <!-- Sign Up Modal -->
  <div class="modal fade" id="signupModal" tabindex="-1" role="dialog" aria-labelledby="signupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Get an ENotes Account</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form action="/signup" method="post">
                <div class="form-group">
                     <label for="exampleInputName1">Name</label>
                     <input type="text" class="form-control" id="exampleInputName1">
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail1">Email address</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control" id="exampleInputPassword1">
                </div>
                <div class="form-group">
                  <label for="cexampleInputPassword1">Confirm Password</label>
                  <input type="password" class="form-control" id="cexampleInputPassword1">
                </div>
                 
                <button type="submit" class="btn btn-primary">Creat Account</button>
              </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
        </div>
      </div>
    </div>
  </div>
  
  <div id="carouselExampleCaptions" class="carousel slide carousel-fade" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
            <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/1.jpg" class="d-block w-100 rounded mx-auto d-block" alt="..." width=500 height=600>
                <div class="carousel-caption d-none d-md-block">
                    <h2>Welcome to ENotes</h2>
                    <p>Tracking becomes easy</p>
                   
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/2.jpg" class="d-block w-100 rounded mx-auto d-block" alt="..." width=500 height=600>
                <div class="carousel-caption d-none d-md-block">
                     <h2>Welcome to ENotes</h2>
                    <p>Note of the day</p>
                   
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/3.jpg" class="d-block w-100 rounded mx-auto d-block" alt="..." width=500 height=600>
                <div class="carousel-caption d-none d-md-block">
                     <h2 style="color:gray;">Welcome to ENotes</h2>
                    <p style="color:gray;">Stay Organized</p>
                    
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    
    
    
    <div class="container my-4">
		        <div class="row mb-2">
		            <div class="col-md-6">
		              <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		                <div class="col p-4 d-flex flex-column position-static">
		                  <strong class="d-inline-block mb-2 text-primary">Mastering Notes:</strong>
		                  <h3 class="mb-0">Wisdom in Words</h3>
		                  <div class="mb-1 text-muted">The palest ink is better than the best memory." – Chinese Proverb</div>
		                  <p class="card-text mb-auto">"Your notes today are the blueprints of tomorrow’s success." – Unknown</p>
		                  <a href="#" class="stretched-link">Continue reading</a>
		                </div>
		                <div class="col-auto d-none d-lg-block">
		                  <img class="bd-placeholder-img" width="200" height="250" src="images/thumb1.jpg" alt="">
		                </div>
		              </div>
		            </div>
		            <div class="col-md-6">
		              <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		                <div class="col p-4 d-flex flex-column position-static">
		                  <strong class="d-inline-block mb-2 text-success">"Note-taking is the art of capturing fleeting ideas before they disappear." – Tony Buzan</strong>
		                  <h3 class="mb-0">"Write down the thoughts of the moment. Those that come unsought for are commonly the most valuable." – Francis Bacon</h3>
		                  <div class="mb-1 text-muted">"Taking notes is the first step in turning information into action." – Michael Hyatt</div>
		                  <p class="mb-auto">"The shortest pencil is longer than the longest memory." – Mark Batterson</p>
		                  <a href="#" class="stretched-link">Continue reading</a>
		                </div>
		                <div class="col-auto d-none d-lg-block">
		                    <img class="bd-placeholder-img" width="200" height="250" src="images/thumb2.jpg" alt="">
		
		                </div>
		              </div>
		            </div>
		          </div>
		        <div class="row mb-2">
		            <div class="col-md-6">
		              <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		                <div class="col p-4 d-flex flex-column position-static">
		                  <strong class="d-inline-block mb-2 text-danger">"Ink Your Ideas: Notes that Matter"</strong>
		                  <h3 class="mb-0">"The Power of Notes: Ideas in Ink"</h3>
		                  <div class="mb-1 text-muted">"Note-taking is the seed of every great idea." – Jim Rohn</div>
		                  <p class="card-text mb-auto">"A good note-taker is a master of their own knowledge." – Steven Covey</p>
		                  <a href="#" class="stretched-link">Continue reading</a>
		                </div>
		                <div class="col-auto d-none d-lg-block">
		                  <img class="bd-placeholder-img" width="200" height="250" src="images/thumb3.jpg" alt="">
		                </div>
		              </div>
		            </div>
		            <div class="col-md-6">
		              <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		                <div class="col p-4 d-flex flex-column position-static">
		                  <strong class="d-inline-block mb-2 text-warning">"Notes to Success: Jot it Down, Make it Happen"</strong>
		                  <h3 class="mb-0">"Ideas come and go, but written notes endure." – Peter Drucker</h3>
		                  <div class="mb-1 text-muted">"When in doubt, write it out." – Unknown</div>
		                  <p class="mb-auto">"An idea captured on paper is an idea saved from being forgotten." – John C. Maxwell</p>
		                  <a href="#" class="stretched-link">Continue reading</a>
		                </div>
		                <div class="col-auto d-none d-lg-block">
		                    <img class="bd-placeholder-img" width="200" height="250" src="images/thumb4.jpg" alt="">
		
		                </div>
		              </div>
		            </div>
		          </div>
    </div>
    <footer class="container">
        <p class="float-right"><a href="#">Back to top</a></p>
        <p>© 2024-2025 ENotes, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
      </footer>
  
   
    
    
     <!-- jQuery, Popper.js, and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    

</body>    
    
</html>