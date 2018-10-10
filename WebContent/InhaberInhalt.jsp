<!DOCTYPE>
<html>
<head>

  <title>Inhaber-Übersicht</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>

<%@ page import="java.sql.*"%>


<script>
	function getZeitraum(){
		
		return document.getElementById('zeitraum').value;
	}
    
    function reload(){
    	window.location.href = 'InhaberInhalt.jsp?zeitraum=' + getZeitraum();
    } 
    
</script>

<jsp:useBean id= "DateBean" scope= "page" class= "beans.DateBean" type= "beans.DateBean" />
<jsp:useBean id= "InhaberBean" scope= "page" class= "beans.InhaberBean" type= "beans.InhaberBean" />

<body id="InhaberInhalt" data-spy="scroll" data-target=".navbar" data-offset="50">

	<div class="w3-row-padding w3-padding-16 w3-center">
		<h1><b>Wichtige Informationen für 
		<jsp:getProperty name = "InhaberBean" property = "vorname"/>
		<jsp:getProperty name = "InhaberBean" property = "nachname"/>
		
		zum aktuellen Zeitpunkt:</b></h1>      	
		
		<jsp:getProperty name = "DateBean" property = "date"/>
		
				
	</div>
	
	<%
	String zeitraum = "7";
	
	if(request.getParameter("zeitraum")!=null){
		zeitraum = request.getParameter("zeitraum");
	}
	
	//Verbindung zur DB herstellen
	try {
    	Connection connection1, connection2, connection3 = null; 
    	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    	connection1 =DriverManager.getConnection("jdbc:mysql://localhost/restaurant_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
 		
    	
    	if(!connection1.isClosed()){
    		
    		%>
        	
        	<div class="w3-row-padding w3-padding-16 w3-center">
        	
        	<%
    		
    		//Anzahl Gerichte
    		String sqlAnzahlGerichte = "SELECT COUNT(gericht_id) FROM gericht";
    		PreparedStatement statementAnzahlGerichte = connection1.prepareStatement(sqlAnzahlGerichte);
    		ResultSet resultSetAnzahlGerichte = statementAnzahlGerichte.executeQuery();
    		
    		if (resultSetAnzahlGerichte.next()) {
    		%>
						<div class="w3-third">
							<h3><b>Gesamtanzahl der Gerichte:</b></h3>
							<h3><%=resultSetAnzahlGerichte.getString("COUNT(gericht_id)")%> Gerichte</h3>
						</div>	
			<%
    			
    		}
    		
    		//Anzahl Mitarbeiter
    		String sqlAnzahlMitarbeiter = "SELECT COUNT(mitarbeiter_id) FROM mitarbeiter";
    		PreparedStatement statementAnzahlMitarbeiter = connection1.prepareStatement(sqlAnzahlMitarbeiter);
    		ResultSet resultSetAnzahlMitarbeiter = statementAnzahlMitarbeiter.executeQuery();
    		
    		if (resultSetAnzahlMitarbeiter.next()) {
    		%>
						<div class="w3-third">
							<h3><b>Gesamtanzahl der Mitarbeiter:</b></h3>
							<h3><%=resultSetAnzahlMitarbeiter.getString("COUNT(mitarbeiter_id)")%> Mitarbeiter</h3>
						</div>	
			<%
    			
    		}
    		
    		//Gesamtanzahl Gäste
    		String sqlGesamtGaeste = "SELECT COUNT(id) FROM gaeste";
    		PreparedStatement statementGesamtGaeste = connection1.prepareStatement(sqlGesamtGaeste);
    		ResultSet resultSetGesamtGaeste = statementGesamtGaeste.executeQuery();
    		
    		if (resultSetGesamtGaeste.next()) {
    			%>
						<div class="w3-third">
							<h3><b>Gesamtanzahl Gäste</b></h3>
							<h3><%=resultSetGesamtGaeste.getString("COUNT(id)")%> Gäste</h3>
						</div>	
				<%
    			
    		}
    		
    		%>
        	</div>
        	
        	<div class="w3-row-padding w3-padding-16 w3-center w3-margin-top">
        		<h2><b>Zeitraum-Infos:</b></h2>
        		Zeitraum (in Tagen):<br>
				      <select name="zeitraum" id="zeitraum" onchange="reload()">
				      	  <option>Wähle:</option>
				      	  <option >1</option>
				          <option >7</option>
				          <option>14</option>
				          <option>30</option>
				          <option>60</option>
				          <option>180</option>
				          <option>360</option>
				       </select>
				       <br>
				       <!-- <Button class="w3-button w3-blue">Zeitraum aktualisieren</Button> -->
				      <h3>gewählter Zeitraum: <%=zeitraum%> </h3>
				      <br><br><br><br>
        	</div>
        	
        	<div class="w3-row-padding w3-padding-16 w3-center">
        	
        	<%
    		
    		//Anzahl Bestellungen letzte 7 Tage
    		String sqlBestellungen = "SELECT COUNT(bestellung_id) FROM bestellung WHERE bestellung_datum BETWEEN NOW() - INTERVAL "+zeitraum+" DAY AND NOW()";
    		PreparedStatement statementBestellungen = connection1.prepareStatement(sqlBestellungen);
    		ResultSet resultSet = statementBestellungen.executeQuery();
    		
    		if (resultSet.next()) {
    		%>
						<div class="w3-third">
							<h3><b>Anzahl Bestellungen in letzten <%=zeitraum%> Tagen:</b></h3>
							<h3><%=resultSet.getString("COUNT(bestellung_id)")%> Bestellungen</h3>
						</div>	
			<%
    			
    		} 
    		
			
    		
    		//Anzahl Gäste letzte 7 Tage
    		String sqlGaeste = "SELECT COUNT(id) FROM gaeste WHERE datum BETWEEN NOW() - INTERVAL "+zeitraum+" DAY AND NOW()";
    		PreparedStatement statementGaeste = connection1.prepareStatement(sqlGaeste);
    		ResultSet resultSetGaeste = statementGaeste.executeQuery();
    		
    		if (resultSetGaeste.next()) {
    			%>
						<div class="w3-third">
							<h3><b>Anzahl Gaeste in letzten <%=zeitraum%> Tagen:</b></h3>
							<h3><%=resultSetGaeste.getString("COUNT(id)")%> Gaeste</h3>
						</div>	
				<%
    			
    		}
    		
    		//Einnahmen letzte 7 Tage
    		String sqlEinnahmen = "SELECT SUM(gericht_preis) FROM gericht INNER JOIN bestellung_gerichte on bestellung_gerichte.gericht_id = gericht.gericht_id INNER JOIN bestellung on bestellung_gerichte.bestellung_id = bestellung.bestellung_id WHERE bestellung.bestellung_datum BETWEEN NOW() - INTERVAL "+zeitraum+" DAY AND NOW()";
    		PreparedStatement statementEinnahmen = connection1.prepareStatement(sqlEinnahmen);
    		ResultSet resultSetEinnahmen = statementEinnahmen.executeQuery();
    		
    		if (resultSetEinnahmen.next()) {
    			%>
						<div class="w3-third">
							<h3><b>Einnahmen in den letzten <%=zeitraum%> Tagen:</b></h3>
							<h3><%=resultSetEinnahmen.getString("SUM(gericht_preis)")%>&euro;</h3>
						</div>	
				<%
    			
    		}
    		
    		
    		%>
        	</div>
        	
        	
        	<div class="w3-row-padding w3-padding-16 w3-center">
				<a href="../restaurant/src/Startseite.php"><Button class="w3-button w3-blue">Zur Startseite</Button></a>
			</div>
        	<%
        	
        	
    	
    	connection1.close();
    	}
	}
	//Keine Verbindung möglich:
	catch(Exception ex){
    	out.println("Unable to connect to database"+ex);
	}
	

%>

</body>

<footer class="container-fluid md-12 text center navbar-fixed-bottom">
  	<div class="col-md-2 navbar-text pull-left"><p><a href="../restaurant/src/Impressum.php"><b>Impressum</b></a></p></div>
  	<div id="testDiv" class="col-md-7 navbar-text pull-left"><p><b></b></p></div> 
  	<div class="col-md-2 navbar-text pull-right"><p><a href="../restaurant/src/Kontakt.php"><b>Kontakt</b></a></p></div>
</footer>

<script>
$.ajax({ url: 'http://localhost/RestaurantJava/Besucherklicker?login=0',
	dataType: 'html',
	success: function(response)
	{ $('#testDiv').html(response); }
	});
</script>


</html>