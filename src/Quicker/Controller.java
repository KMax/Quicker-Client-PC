/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Quicker;

import java.io.IOException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import Quicker.exceptions.ControllerException;

/**
 *
 * @author Илья
 */
public class Controller {

    private static Controller instance = null;
    private QuickerNotesProvider provider;
    private LinkedList<NoteListItem> noteList;
    private Note note;

    public static Controller getInstance() {
        if (instance == null) {
            instance = new Controller();
        }
        return instance;
    }

    private Controller() {
        //   provider = QuickerNotesProvider.getInstance();
        noteList = new LinkedList<NoteListItem>();
    }

    public LinkedList<NoteListItem> getNoteList()
            throws ControllerException {
        String notes;
        //   notes = provider.getNotesList();

        notes = "<notes count=\"4\">"
                + "<note video=\"1\">"
                + "<id>1</id>"
                + "<title>Заголовок</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note image=\"1\">"
                + "<id>2</id>"
                + "<title>Второй</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"

                + "<note video=\"1\" image=\"1\">"
                + "<id>3</id>"
                + "<title>Третий</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note video=\"1\" image=\"\">"
                + "<id>4</id>"
                + "<title>Четвёртый</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                
                + "<note audio=\"1\">"
                + "<id>1</id>"
                + "<title>Заголовок</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note>"
                + "<id>2</id>"
                + "<title>Второй</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"

                + "<note>"
                + "<id>1</id>"
                + "<title>Заголовок</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note>"
                + "<id>2</id>"
                + "<title>Второй</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note>"
                + "<id>1</id>"
                + "<title>Заголовок</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"
                + "<note>"
                + "<id>2</id>"
                + "<title>Второй</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>31 фев 2010 23:57:34</date>"
                + "</note>"/* */
                + "</notes>";
        try {
            XMLParser parser = new XMLParser(notes);
            double num = (Double)parser.execute("count(//note)",
                    XPathConstants.NUMBER);

            NoteListItem item;
            LinkedList<Media> media;
            for (int i = 1; i <= num; i++) {
                media = new LinkedList<Media>();
                if (((String)parser.execute("/notes/note["+i+"]/@audio", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Audio);
                }
                if (((String)parser.execute("/notes/note["+i+"]/@video", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Video);
                }
                if (((String)parser.execute("/notes/note["+i+"]/@image", XPathConstants.STRING)).equals("1")) {
                    media.add(Media.Graphics);
                }
                item = new NoteListItem(
                        Integer.parseInt((String)parser.execute("/notes/note["+i+"]/id", XPathConstants.STRING)),
                        (String)parser.execute("/notes/note["+i+"]/title", XPathConstants.STRING),
                        (String)parser.execute("/notes/note["+i+"]/extractions", XPathConstants.STRING),
                        (String)parser.execute("/notes/note["+i+"]/date", XPathConstants.STRING),
                        media
                        );
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
        //note = provider.getNote(id);
        sNote = "<note id=\"" + id + "\"><title>Заголовок</title><content>"
                + "<text>Бла бла бла. Контент заметки. Много много много много "
                + "много много много теста. </text>" +
                "<image>Images/testImage.jpg</image>" +
                "<video>Images/testImage.jpg</video></content><date>"
                + "31 фев 2010 23:57:34</date></note>";
        try {
            XMLParser parser = new XMLParser(sNote);
            String text = (String)parser.execute("/note/content/text", XPathConstants.STRING);
            String title = (String)parser.execute("/note/title", XPathConstants.STRING);
            String video = (String)parser.execute("/note/content/audio", XPathConstants.STRING);
            LinkedList<String> videos = new LinkedList<String>();
            videos.add(video);
            String audio = (String)parser.execute("/note/content/video", XPathConstants.STRING);
            LinkedList<String> audios = new LinkedList<String>();
            audios.add(audio);
            String image = (String)parser.execute("/note/content/image", XPathConstants.STRING);
            LinkedList<String> images = new LinkedList<String>();
            images.add(image);
            String date = (String)parser.execute("/note/date", XPathConstants.STRING);
            
            note = new Note(id, title, text, videos, audios, audios, date);
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

    public LinkedList<NoteListItem> getEventList() {
        return null;
    }

    public LinkedList<NoteListItem> getContactList() {
        return null;
    }
}
