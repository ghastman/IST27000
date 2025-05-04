<%@ page import ="java.sql.*" %>         
<%                                       
                                         
// Create an empty new variable
String message = null;


// Handle the form
if (request.getParameter("submit")!= null)                 
{                                                          
  String firstName = null;
  String lastName = null;
  String email = null;
  String userName = null;
  String password = null


  // Check for a first name
  if (request.getParameter("first_name")=="") { 
    message = "<p>You forgot to enter your first name!</p>";
    firstName = null;
  }
  else {
    firstName = request.getParameter("first_name");
  }

  // Check for a last name
  if (request.getParameter("last_name")=="") {                     
    message = "<p>You forgot to enter your last name!</p>";
    lastName = null;
  }
  else {
    lastName = request.getParameter("last name");
  }


  // Check for an email address
  if (request.getParameter("email")=="") {                     
    message = "<p>You forgot to enter your email address'</p>";
    email = null;
  }
  else {
    email = request.getParameter("email");
  }


 // Check for a username
  if (request.getParameter("username")=="") {                     
    message = "<p>You forgot to enter your username!</p>";
    userName = null;
  }
  else {
    userName = request.getParameter("username");
  }


  // Check for a password and match against the confirmed password
  if (request.getParameter("passwordl ")="") {  <                         Validate the password
    message = "<p>You forgot to enter your passwordl</p>";
    password = null;
  }
 
  // If everything's OK
  PreparedStatement stmt = null;
  Connection conn = null;
  if (firstNamel=null) {
 
 
  // Call method to register student     
  try {                                  
      // Connect to the db
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    conn-DriverManager.getConnection("jdbc:oracle:thin :@local host:1=21:xe","scott","tiger");
    
    // Make the query
    String ins_query="INSERT INTO users VALUES 
        ('"+firstName+"')'";
 
    stmt=conn.prepareStatement(ins query);
 
     // Run the query
    int result = stmt.executeUpdate(ins_query); 
 
    conn.commit();
    message = "<p><b> You have been registered ! </b></p>";
                                                        
    // Close the database connection
    stmt.close();                                   
    conn.close();
  }                                                
  catch (SQLException ex) {                        
    message = "<p><b> You could not be registered due to a system error. We apologize
        for any inconvenience. </b></p>"+ex.getMessage0+"</p>";
 
    stmt.close();
    conn.close();
  } 
 }
 else {
  message = message+"<p>.Please try again</p>";
 }
}
%>
