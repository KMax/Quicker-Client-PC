/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Quicker;

import java.util.LinkedList;

/**
 *
 * @author Илья
 */
public class NoteListItem {
    private String title;
    private String date;
    private String extractions; // some text
    private LinkedList<Media> mediaType;
    private int noteID;

    public NoteListItem(int id, String t, String e, String d,
            LinkedList<Media> m) {
        title = new String(t);
        date = new String(d);
        extractions = new String(e);
        mediaType = new LinkedList<Media>(m);
        noteID = id;
    }

    public String getDate() {
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
    public int getNoteID() {
        return noteID;
    }
}