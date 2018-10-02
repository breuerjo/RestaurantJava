package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Besucherklicker")
public class Besucherklicker extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static int zaehler = 0;
	
    public Besucherklicker() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Integer hitsCount = (Integer)application.getAttribute("hitCounter");
		zaehler++;
		PrintWriter out = response.getWriter();
		//String contextParameterName = "anfangswert01";
		//String contextParameterWert = this.getInitParameter(contextParameterName);
		//out.println("Der Context-Parameter " + contextParameterName + " hat den Wert " +contextParameterWert + ".");
		out.println("<p><b>Besucher: "+zaehler+"</b></p>");
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
