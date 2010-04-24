package Quicker.noteWindow;

import Quicker.Controller;
import Quicker.Note;
import javafx.async.RunnableFuture;

/**
 *
 * @author Maxim
 */
public class GoSave implements RunnableFuture {
	private Controller provider;
	private Note note;
	public GoSave(Note n) {
		provider = Controller.getInstance();
		note = n;
	}
	@Override
	public void run() throws Exception {
		provider.saveNote(note);
	}

}
