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
package Quicker.views;

import Quicker.Controller;
import Quicker.NoteListItem;
import com.sun.javafx.runtime.Entry;
import java.util.LinkedList;
import javafx.async.RunnableFuture;

public class ListRunnable implements RunnableFuture {

	private LinkedList<NoteListItem> list;
	private NotesListener listener;

	public ListRunnable(NotesListener listener) {
		this.listener = listener;
	}

	@Override
	public void run() throws Exception {
		list = Controller.getInstance().getNoteList();
		postResult();
	}
	public void postMessage(final String msg) {
		Entry.deferAction(new Runnable() {

			@Override
			public void run() {
				listener.callback(msg);
			}
		});
	}
	public void postResult() {
		Entry.deferAction(new Runnable() {

			@Override
			public void run() {
				listener.post(list);
			}

		});
	}
	public LinkedList<NoteListItem> getList() {
		return list;
	}
}
