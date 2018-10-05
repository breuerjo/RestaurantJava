<!DOCTYPE>
<html>
<head>

  <title>Speisekarte</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>

<%@ page import="java.sql.*"%>
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

<body id="InhaberInhalt" data-spy="scroll" data-target=".navbar" data-offset="50">
	<a href="../restaurant/src/Login.php"><b>zum Login</b></a>
</body>

<footer class="container-fluid md-12 text center navbar-fixed-bottom">
  	<div class="col-md-2 navbar-text pull-left"><p><a href="Impressum.php"><b>Impressum</b></a></p></div>
  	<div id="testDiv" class="col-md-7 navbar-text pull-left"><p><b></b></p></div> 
  	<div class="col-md-2 navbar-text pull-right"><p><a href="Kontakt.php"><b>Kontakt</b></a></p></div>
</footer>

<script>
$.ajax({ url: 'http://localhost/RestaurantJava/Besucherklicker?login=0',
	dataType: 'html',
	success: function(response)
	{ $('#testDiv').html(response); }
	});
</script>

</html>