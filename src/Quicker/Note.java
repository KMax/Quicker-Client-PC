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
    private LinkedList<String> images;
    private LinkedList<String> audio;
    private String date;

    public Note(int id, String title, String text,
            LinkedList<String> video, LinkedList<String> image,
            LinkedList<String> audio, String date) {
        this.id = id;
        this.title = title;
        this.text = text;
        this.video = video;
        this.images = image;
        this.audio = audio;
        this.date = date;
    }

    public LinkedList<String> getAudios() {
        return audio;
    }

    public String getDate() {
        return date;
    }

    public int getId() {
        return id;
    }

    public LinkedList<String> getImages() {
        return images;
    }

    public String getText() {
        return text;
    }

    public String getTitle() {
        return title;
    }

    public LinkedList<String> getVideos() {
        return video;
    }
}
