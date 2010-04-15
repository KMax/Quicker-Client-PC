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

    public void addVideo(String vid) {
        this.video.add(vid);
    }

    public void addAudio(String audio) {
        this.audio.add(audio);
    }

    public void addImage(String img) {
        this.images.add(img);
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void removeVideo(int position) {
        this.video.remove(position);
    }

    public void removeVideo(String s) {
        this.video.remove(s);
    }

    public void removeAudio(int position) {
        this.audio.remove(position);
    }

    public void removeAudio(String s) {
        this.audio.remove(s);
    }

    public void removeImage(int position) {
        this.images.remove(position);
    }

    public void removeImage(String s) {
        this.images.remove(s);
    }
}
