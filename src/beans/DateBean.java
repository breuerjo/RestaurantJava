package beans;

import java.util.Date;

public class DateBean implements java.io.Serializable{
	private Date date;
	
	public Date getDate() {
		date = new Date();
		return date;
	}
	
}
