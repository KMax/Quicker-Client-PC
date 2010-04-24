/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Quicker;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import org.xml.sax.SAXException;
import Quicker.exceptions.ControllerException;
import Quicker.provider.Provider;
import java.net.URL;

/**
 *
 * @author Илья
 */
public class Controller {

    private static Controller instance = null;
    private Provider provider;
    private LinkedList<NoteListItem> noteList;
    private Note note;

    public static Controller getInstance() {
        if (instance == null) {
            instance = new Controller();
        }
        return instance;
    }

    private Controller() {
		try {
			provider = new Provider(new URL("https://localhost:8181/Quicker/"), "maxim", "123");
		} catch (MalformedURLException ex) {
			Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
		}
        noteList = new LinkedList<NoteListItem>();
    }

    public LinkedList<NoteListItem> getNoteList()
            throws ControllerException {
        String notes;
        notes = provider.get("maxim/notes/", String.class);

        try {
            XMLParser parser = new XMLParser(notes);
            double num = (Double) parser.execute("count(//note)",
                    XPathConstants.NUMBER);

            NoteListItem item;
            LinkedList<Media> media;
            for (int i = 1; i <= num; i++) {
                media = new LinkedList<Media>();
                if (((String) parser.execute("/notes/note[" + i + "]/@audio", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Audio);
                }
                if (((String) parser.execute("/notes/note[" + i + "]/@video", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Video);
                }
                if (((String) parser.execute("/notes/note[" + i + "]/@image", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Graphics);
                }
                item = new NoteListItem(
                        Integer.parseInt((String) parser.execute("/notes/note[" + i + "]/id", XPathConstants.STRING)),
                        (String) parser.execute("/notes/note[" + i + "]/title", XPathConstants.STRING),
                        (String) parser.execute("/notes/note[" + i + "]/extractions", XPathConstants.STRING),
                        (String) parser.execute("/notes/note[" + i + "]/date", XPathConstants.STRING),
                        media);
                noteList.add(item);
            }
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            throw new ControllerException(ex);
        } catch (XPathExpressionException ex) {
            throw new ControllerException(ex);
        } catch (SAXException ex) {
            throw new ControllerException(ex);
        } catch (IOException ex) {
            throw new ControllerException(ex);
        }

        return noteList;
    }

    public Note getNote(int id) throws ControllerException {
        String sNote;
        sNote = provider.get("maxim/note/"+id, String.class);
        try {
            XMLParser parser = new XMLParser(sNote);
            String text = (String) parser.execute("/note/content/text",
                    XPathConstants.STRING);
            String title = (String) parser.execute("/note/title",
                    XPathConstants.STRING);

            int count = 0;
            String c = (String) parser.execute("count(/note/content/video)",
                    XPathConstants.STRING);
            if (!c.equals("")) {
                count = Integer.parseInt(c);
            }
            LinkedList<String> videos = new LinkedList<String>();
            for (int i = 1; i <= count; i++) {
                String video = (String) parser.execute("/note/content/video",
                        XPathConstants.STRING);
                videos.add(video);
            }

            count = 0;
            c = (String) parser.execute("count(/note/content/audio)",
                    XPathConstants.STRING);
            if (!c.equals("")) {
                count = Integer.parseInt(c);
            }
            LinkedList<String> audios = new LinkedList<String>();
            for (int i = 1; i <= count; i++) {
                String audio = (String) parser.execute("/note/content/audio",
                    XPathConstants.STRING);
                audios.add(audio);
            }

            count = 0;
            c = (String) parser.execute("count(/note/content/image)",
                    XPathConstants.STRING);
            if (!c.equals("")) {
                count = Integer.parseInt(c);
            }
            LinkedList<String> images = new LinkedList<String>();
            for (int i = 1; i <= count; i++) {
                String image = (String) parser.execute("/note/content/image[" + i + "]",
                        XPathConstants.STRING);
                images.add(image);
            }
            String date = (String) parser.execute("/note/date", XPathConstants.STRING);

            note = new Note(id, title, text, videos, images, audios, date);
        } catch (ParserConfigurationException ex) {
            throw new ControllerException(ex);
        } catch (SAXException ex) {
            throw new ControllerException(ex);
        } catch (IOException ex) {
            throw new ControllerException(ex);
        } catch (XPathExpressionException ex) {
            throw new ControllerException(ex);
        }
        return note;
    }

    public Note newNote() {
        note = new Note();
        return note;
    }

    public void saveNewNote(Note noteToSave) {
        System.out.println("Saved. ");
        String toSend = "<note>" +
                "<title>" + noteToSave.getTitle() + "</title>" +
                "<content>" +
                "<text>" + noteToSave.getText() + "</text>";
        LinkedList<String> imgs = noteToSave.getImages();
        if (imgs.size() > 0) {
            for (String img : imgs) {
                toSend += "<image>"+img+"</image>";
            }
        }
        LinkedList<String> vids = noteToSave.getVideos();
        if (vids.size() > 0) {
            for (String vid : vids) {
                toSend += "<image>"+vid+"</image>";
            }
        }
        LinkedList<String> auds = noteToSave.getAudios();
        if (auds.size() > 0) {
            for (String a : imgs) {
                toSend += "<image>"+a+"</image>";
            }
        }
        toSend += "</content><date>"+noteToSave.getDate()+"</date>" +
                "</note>";
        provider.post("maxim/note", toSend);
    }

    public void saveNote(Note noteToSave) {
        System.out.println("Saved. ");
        String toSend = "<note>" +
                "<id>" + noteToSave.getId() + "</id>" +
                "<title>" + noteToSave.getTitle() + "</title>" +
                "<content>" +
                "<text>" + noteToSave.getText() + "</text>";
        LinkedList<String> imgs = noteToSave.getImages();
        if (imgs.size() > 0) {
            for (String img : imgs) {
                toSend += "<image>"+img+"</image>";
            }
        }
        LinkedList<String> vids = noteToSave.getVideos();
        if (vids.size() > 0) {
            for (String vid : vids) {
                toSend += "<image>"+vid+"</image>";
            }
        }
        LinkedList<String> auds = noteToSave.getAudios();
        if (auds.size() > 0) {
            for (String a : imgs) {
                toSend += "<image>"+a+"</image>";
            }
        }
        toSend += "</content><date>"+noteToSave.getDate()+"</date>" +
                "</note>";
        // ToDo: update note list
        provider.put("maxim/note/"+noteToSave.getId(), toSend);
    }

    public void deleteNote(int id) {
        provider.delete("maxim/note/"+id);
    }

    public LinkedList<NoteListItem> getEventList() {
        return null;
    }

    public LinkedList<NoteListItem> getContactList() {
        return null;
    }
}
