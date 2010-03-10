package quicker;

import java.sql.Date;

public class Note {
	private int id;
	private String title;
	private String content;
	private Date dateOfCreation;
	private Boolean isEvent;
	
	public Note(String note)
	{
		// parse XML
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @return the dateOfCreation
	 */
	public Date getDateOfCreation() {
		return dateOfCreation;
	}
	/**
	 * @return the isEvent
	 */
	public Boolean getIsEvent() {
		return isEvent;
	}
}