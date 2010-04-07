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
public class Note {
    private int id;
    private String title;
    private String text;
    private LinkedList<String> video;
    private LinkedList<String> photo;
    private LinkedList<String> audio;
    private String date;

    public Note(int id, String title, String text,
            LinkedList<String> video, LinkedList<String> photo,
            LinkedList<String> audio, String date) {
        this.id = id;
        this.title = title;
        this.text = text;
        this.video = video;
        this.photo = photo;
        this.audio = audio;
        this.date = date;
    }

    public LinkedList<String> getAudio() {
        return audio;
    }

    public String getDate() {
        return date;
    }

    public int getId() {
        return id;
    }

    public LinkedList<String> getPhoto() {
        return photo;
    }

    public String getText() {
        return text;
    }

    public String getTitle() {
        return title;
    }

    public LinkedList<String> getVideo() {
        return video;
    }
}
