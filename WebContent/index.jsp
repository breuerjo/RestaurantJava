<%@ page import="java.sql.*"%>
<html>
<head>

<title>K�che</title>

</head>

<body>
<h1>K�che</h1>

<%

Connection con = null;
try {
    Connection connection = null; 
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    connection =DriverManager.getConnection("jdbc:mysql://localhost/restaurant_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
    if(!connection.isClosed())
         out.println("Successfully connected to " + "MySQL server using TCP/IP...");
    connection.close();
}catch(Exception ex){
    out.println("Unable to connect to database"+ex);
}     
%>

</body>
</html>