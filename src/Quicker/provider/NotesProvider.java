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
        
    }

	public void deleteNote(int id) {
       
    }

	public void createNote(String note) {
		
	}

	public static void main(String args[]){
		NotesProvider p = NotesProvider.getInstance();
		System.out.println(p.getNotesList());
	}
}

