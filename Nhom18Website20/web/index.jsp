<%-- 
    Document   : index
    Created on : Sep 29, 2022, 9:10:32 AM
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
    
    
    
    
    <h1>Join our email list</h1>
    <p>To join our email list, enter your name and
       email address below.</p>
    <p><i>${message}</i></p>
    <form action="email" method="post">
        <input type="hidden" name="action" value="add">        
        <label class="pad_top">Email:</label>
        <input type="email" name="email" value="${user.email}"><br>
        <label class="pad_top">First Name:</label>
        <input type="text" name="firstName" value="${user.firstName}"><br>
        <label class="pad_top">Last Name:</label>
        <input type="text" name="lastName" value="${user.lastName}"><br>        
        <label>&nbsp;</label>
        <input type="submit" value="Join Now" class="margin_left">
    </form>
</body>
</html>