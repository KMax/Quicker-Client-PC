/***************************************************************************
*
*	Copyright 2010 Quicker Team
*
*	Quicker Team is:
*		Kirdeev Andrey (kirduk@yandex.ru)
* 	Koritniy Ilya (korizzz230@bk.ru)
* 	Kolchin Maxim	(kolchinmax@gmail.com)
*/
/****************************************************************************
*
*	This file is part of Quicker.
*
*	Quicker is free software: you can redistribute it and/or modify
*	it under the terms of the GNU Lesser General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	Quicker is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*	GNU Lesser General Public License for more details.
*
*	You should have received a copy of the GNU Lesser General Public License
*	along with Quicker. If not, see <http://www.gnu.org/licenses/>


****************************************************************************/
package Quicker;

import java.util.LinkedList;

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