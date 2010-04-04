/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Quicker;

import java.util.Date;
import java.util.LinkedList;

/**
 *
 * @author Илья
 */
public class NoteListItem {
    private String title;
    private Date date;
    private String extractions; // some text
    private LinkedList<Media> mediaType;
    private String noteID;

    public NoteListItem(String id, String t, String e, long d, // change to Date d
            LinkedList<Media> m) {
        title = new String(t);
        date = new Date(d);
        extractions = new String(e);
        mediaType = new LinkedList<Media>(m);
        noteID = new String(id);
    }

    public Date getDate() {
        return date;
    }
    public String getExtractions() {
        return extractions;
    }
    public String getTitle() {
        return title;
    }
    public LinkedList<Media> getMediaType() {
        return mediaType;
    }
    public String getNoteID() {
        return noteID;
    }
}