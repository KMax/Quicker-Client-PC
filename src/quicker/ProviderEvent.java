package quicker;

import java.util.EventObject;

public class ProviderEvent extends EventObject {
	private static final long serialVersionUID = -7708104378961465960L;
	private String message;
	
	public ProviderEvent(Object source) {
		this(source, "");
		// TODO Auto-generated constructor stub
	}
	public ProviderEvent(Object source, String msg)
	{
		super(source);
		message = msg;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
}