package Quicker.noteWindow;

import Quicker.Controller;
import Quicker.Note;
import com.sun.javafx.runtime.Entry;
import javafx.async.RunnableFuture;

/**
 *
 * @author Maxim
 */
public class GoSave implements RunnableFuture {

	private Controller provider;
	private Note note;
	private SaveListener listener;
	private Boolean add;

	public GoSave(Note n, SaveListener l, Boolean add) {
		provider = Controller.getInstance();
		note = n;
		listener = l;
		this.add = add;
	}

	@Override
	public void run() throws Exception {
		System.out.println("inside run");
		if (!add) {
			returnResult(provider.saveNote(note));
			System.out.println("saved");
		} else {
			returnResult(provider.saveNewNote(note));
			System.out.println("added");
		}
	}

	private void returnResult(final Boolean result) {
		Entry.deferAction(new Runnable() {

			@Override
			public void run() {
				listener.returnResult(result);
			}
		});
	}
}
