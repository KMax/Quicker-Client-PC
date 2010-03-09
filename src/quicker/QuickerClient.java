package quicker;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

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
		QuickerProvider provider = QuickerProvider.getInstance();
		if (event.getActionCommand() == "add") {
			// Trying to create note
			try {
				if (provider.createNote("First Note", "That's my note. ")) {
					_window.printData("Note created. ");
				} else {
					_window.printData("Error occured. ");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if (event.getActionCommand() == "get") {
			
			// Trying to get note
			try {
				_window.printData(provider.getNote(1));
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if (event.getActionCommand() == "update") {
			
			// Trying to update note
			try {
				if (provider.updateNote(1)) {
					_window.printData("Note 1 deleted. ");
				} else {
					_window.printData("Error occured. ");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if (event.getActionCommand() == "delete") {
			
			// Trying to delete note
			try {
				if (provider.deleteNote(1)) {
					_window.printData("Note 1 deleted. ");
				} else {
					_window.printData("Error occured. ");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if (event.getActionCommand() == "list") {
			
			// Trying to delete note
			try {
				_window.printData(provider.getNotesList());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
