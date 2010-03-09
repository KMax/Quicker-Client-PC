

package quicker;

import java.io.IOException;

public class QuickerClient {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	//	QuickerProvider provider = new QuickerProvider("User", "http://www.restlet.org");
		QuickerProvider provider = QuickerProvider.getInstance("User", "localhost:8080");
		/*try {
			System.out.println(provider.test());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

		// try to create note
		try {
			System.out.println(provider.createNote("First Note", "<note>That's my note. </note>"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// try to get note
		try {
			System.out.println(provider.getNote(1));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// try to update note
		try {
			System.out.println(provider.updateNote(1));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// try to delete note
		try {
			System.out.println(provider.deleteNote(1));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
