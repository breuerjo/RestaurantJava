<!DOCTYPE>
<%@ page import = "java.io.*,java.util.*" %>

<html>
   <head>
      <title>Application object in JSP</title>
   </head>
   
   <body>
      <%
         Integer hitsCount = (Integer)application.getAttribute("hitCounter");
      
         //hitsCount = hitsCount +1 ;
         
         application.setAttribute("hitCounter", hitsCount);
      %>
        <p>Total number of visits: <%= hitsCount%></p>
   
   </body>
</html>