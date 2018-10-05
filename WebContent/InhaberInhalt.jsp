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

<script>
	function getZeitraum(){
		
		return document.getElementById('zeitraum').value;
	}
	
	/* function saveValue(){
        var zeitraum = document.getElementById('zeitraum').value;
        var val = zeitraum.value; 
        localStorage.setItem(zeitraum, val); 
    }

 
    function getSavedValue  (v){
        if (localStorage.getItem(v) === null) {
            return 7;
        }
        return localStorage.getItem(v);
    }
    
    function reload(){
    	saveValue();
    	//window.location.reload();
    } */
    
</script>


<body id="InhaberInhalt" data-spy="scroll" data-target=".navbar" data-offset="50">

	<div class="w3-row-padding w3-padding-16 w3-center">
		<h1><b>Wichtige Informationen für den Inhaber</b></h1>
	</div>
	
	<%
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
							<h3>Gesamtanzahl der Gerichte:</h3>
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
							<h3>Gesamtanzahl der Mitarbeiter:</h3>
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
							<h3>Anzahl Gaeste in letzten 7 Tagen:</h3>
							<h3><%=resultSetGesamtGaeste.getString("COUNT(id)")%> Gaeste</h3>
						</div>	
				<%
    			
    		}
    		
    		%>
        	</div>
        	
        	<div class="w3-row-padding w3-padding-16 w3-center w3-margin-top">
        		<h2><b>Zeitraum-Infos:</b></h2>
        		Zeitraum (in Tagen):<br>
				      <select name="zeitraum" id="zeitraum">
				          <option>7</option>
				          <option>14</option>
				          <option>30</option>
				          <option>60</option>
				          <option>180</option>
				          <option>360</option>
				       </select>
				       <br>
				       <Button class="w3-button w3-blue" onClick="reload()">Zeitraum aktualisieren</Button>
				      <h1>gewählter Zeitraum: <script>document.write(getZeitraum());</script> </h1>
        	</div>
        	
        	<div class="w3-row-padding w3-padding-16 w3-center">
        	
        	<%
    		
    		//Anzahl Bestellungen letzte 7 Tage
    		String sqlBestellungen = "SELECT COUNT(bestellung_id) FROM bestellung WHERE bestellung_datum BETWEEN NOW() - INTERVAL 7 DAY AND NOW()";
    		PreparedStatement statementBestellungen = connection1.prepareStatement(sqlBestellungen);
    		ResultSet resultSet = statementBestellungen.executeQuery();
    		
    		if (resultSet.next()) {
    		%>
						<div class="w3-third">
							<h3>Anzahl Bestellungen in letzten 7 Tagen:</h3>
							<h3><%=resultSet.getString("COUNT(bestellung_id)")%> Bestellungen</h3>
						</div>	
			<%
    			
    		} 
    		

    		
    		//Anzahl Gäste letzte 7 Tage
    		String sqlGaeste = "SELECT COUNT(id) FROM gaeste WHERE datum BETWEEN NOW() - INTERVAL 7 DAY AND NOW()";
    		PreparedStatement statementGaeste = connection1.prepareStatement(sqlGaeste);
    		ResultSet resultSetGaeste = statementGaeste.executeQuery();
    		
    		if (resultSetGaeste.next()) {
    			%>
						<div class="w3-third">
							<h3>Anzahl Gaeste in letzten 7 Tagen:</h3>
							<h3><%=resultSetGaeste.getString("COUNT(id)")%> Gaeste</h3>
						</div>	
				<%
    			
    		}
    		
    		//Einnahmen letzte 7 Tage
    		String sqlEinnahmen = "SELECT SUM(gericht_preis) FROM gericht INNER JOIN bestellung_gerichte on bestellung_gerichte.gericht_id = gericht.gericht_id INNER JOIN bestellung on bestellung_gerichte.bestellung_id = bestellung.bestellung_id WHERE bestellung.bestellung_datum BETWEEN NOW() - INTERVAL 7 DAY AND NOW()";
    		PreparedStatement statementEinnahmen = connection1.prepareStatement(sqlEinnahmen);
    		ResultSet resultSetEinnahmen = statementEinnahmen.executeQuery();
    		
    		if (resultSetEinnahmen.next()) {
    			%>
						<div class="w3-third">
							<h3>Einnahmen in den letzten 7 Tagen:</h3>
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