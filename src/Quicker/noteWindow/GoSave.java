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
	public GoSave(Note n, SaveListener l) {
		provider = Controller.getInstance();
		note = n;
                listener = l;
	}
	@Override
	public void run() throws Exception {
		provider.saveNote(note);

	}
        private void returnResult() {
            Entry.deferAction(new Runnable() {
            @Override
                public void run() {
                    listener.returnResult(true);
                }
            });
        }

}
