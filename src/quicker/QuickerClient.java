package quicker;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.SwingUtilities;

public class QuickerClient implements ActionListener {
	static QuickerWindow _window;
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			
			@Override
			public void run() {
				_window = new QuickerWindow(new QuickerClient());
			}
		});
	}

	@Override
	public void actionPerformed(ActionEvent event) {
		QuickerNotesProvider provider = QuickerNotesProvider.getInstance();
		if (event.getActionCommand().equals("add")) {
			// Trying to create note
			if (provider.createNote(_window.outputArea.getText())) {
				_window.printData("Note created. ");
			} else {
				_window.printData("Error occured. ");
			}
		} else if (event.getActionCommand().equals("get")) {
			
			// Trying to get note
			_window.printData(provider.getNote(1));
		} else if (event.getActionCommand().equals("update")) {
			
			// Trying to update note
			if (provider.updateNote(1)) {
				_window.printData("Note 1 deleted. ");
			} else {
				_window.printData("Error occured. ");
			}
		} else if (event.getActionCommand().equals("delete")) {
			
			// Trying to delete note
			if (provider.deleteNote(1)) {
				_window.printData("Note 1 deleted. ");
			} else {
				_window.printData("Error occured. ");
			}
		} else if (event.getActionCommand().equals("list")) {
			
			// Trying to delete note
			_window.printData(provider.getNotesList());
		}
	}
}
