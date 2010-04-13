package Quicker.provider;

/**
 *
 */
public class NotesProvider {

	private static NotesProvider instance = null;
	private Provider provider;

	private NotesProvider(){
		provider = Provider.getInstance();
	}

	public static NotesProvider getInstance() {
		if (instance == null) {
			try {
				instance = new NotesProvider();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return instance;
	}

	public String getNotesList() {
		return provider.get("maxim/notes/",String.class);
	}

	public String getNote(int id) {
        return provider.get("maxim/note/"+id, String.class);
    }

	public void updateNote(String note, int id) {
        provider.put("maxim/note/"+id, note);
    }

	public void deleteNote(int id) {
		provider.delete(Provider.user+"/"+id);
    }

	public void createNote(String note) {
		provider.post(Provider.user+"/note/", note);
	}
}

