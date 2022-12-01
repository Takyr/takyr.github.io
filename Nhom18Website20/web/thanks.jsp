<%-- 
    Document   : thanks
    Created on : Sep 29, 2022, 9:23:02 AM
    Author     : DELL
--%>

<!DOCTYPE html>
<html>
<head>
    
    
     <meta charset="utf-8">
    <title>Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main2.css" type="text/css"/>  
    
     <style>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  border: 1px solid #e7e7e7;
  background-color: #f3f3f3;
}
 li {
  float: left;
}

li a {
  display: block;
  color: #666;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover:not(.active) {
  background-color: #ddd;
}

li a.active {
  color: white;
  background-color: #04AA6D;
}
</style>
     
</head>

<body>
    
    
    
<div class="header">
  <h1>Group 18 - LTWeb</h1>
  <p>Gaming Merchandise Shop</p>
</div>

    
    
<!-- The navigation menu -->
<div class="navbar">
  <a href="index.html">Home</a>
   <a href="about.html">About Us</a>

  <div class="subnav">
    <button class="subnavbtn">LABs? <i class="fa fa-caret-down"></i></button>
    <div class="subnav-content">
      <a href="index2.html">ch04_ex1_survey</a>
      <a href="index.jsp">ch05_ex1_email</a>
      <a href="#package">ch05_ex2_email</a>
      <a href="#express">ch06_ex1_email</a>
      <a href="index2.html">ch06_ex2_survey</a>
      <a href="index.jsp">ch07_ex1_download</a>
      <a href="#package">ch07_ex2_download</a>
      <a href="#express">ch07_ex3_cart</a>
      <a href="index2.html">ch08_ex1_email</a>
      <a href="index.jsp">ch09_ex1_download</a>
      <a href="#package">ch09_ex2_cart</a>
      
      
      
      
      
    </div>
  </div>
   
    <a href="about.html">Final Project</a>
</div>   
    
    
    
    <h1>Thanks for joining our email list</h1>

    <p>Here is the information that you entered:</p>

    <label>Email:</label>
    <span>${user.email}</span><br>
    <label>First Name:</label>
    <span>${user.firstName}</span><br>
    <label>Last Name:</label>
    <span>${user.lastName}</span><br>

    <p>To enter another email address, click on the Back 
    button in your browser or the Return button shown 
    below.</p>

    <form action="" method="post">
        <input type="hidden" name="action" value="join">
        <input type="submit" value="Return">
    </form>

</body>
</html>