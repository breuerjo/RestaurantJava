<%@ page import="java.sql.*"%>
<html>
<head>

<title>Küche</title>

</head>

<body>
<h1>Küche</h1>

<%

Connection con = null;
try {
	String connectionURL = "jdbc:mysql:host=localhost;dbname=restaurant_db;charset=utf8', 'root', ''";
    Connection connection = null; 
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    connection = DriverManager.getConnection(connectionURL, "root", "");
    if(!connection.isClosed())
         out.println("Successfully connected to " + "MySQL server using TCP/IP...");
    connection.close();
}catch(Exception ex){
    out.println("Unable to connect to database"+ex);
}     
%>

</body>
</html>