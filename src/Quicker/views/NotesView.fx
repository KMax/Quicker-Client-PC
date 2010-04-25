/***************************************************************************
 *
 * Copyright 2010 Quicker Team
 *
 * Quicker Team is:
 * Kirdeev Andrey (kirduk@yandex.ru)
 * Koritniy Ilya (korizzz230@bk.ru)
 * Kolchin Maxim (kolchinmax@gmail.com)
 */
/****************************************************************************
 *
 * This file is part of Quicker.
 *
 * Quicker is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Quicker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Quicker. If not, see <http://www.gnu.org/licenses/>


 ****************************************************************************/
package Quicker.views;

import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.image.ImageView;
import javafx.scene.text.TextAlignment;
import Quicker.Controller;
import Quicker.NoteListItem;
import Quicker.Constants;
import Quicker.Media;
import Quicker.noteWindow.NoteWindow;
import java.lang.Void;
import java.util.LinkedList;
import javafx.scene.Cursor;

public class NotesView extends View {

    var provider: Controller = Controller.getInstance();
    var notes: Node;
    var a: Node[] = null;

    override public function showInfo()   {
        if (a[0] != null)
            return;
        var theList: LinkedList;
        var mes ;
        var listener: NotesListener = NotesListener {
                        override public function post(list: LinkedList): Void {
                            java.lang.System.out.println("{list.size()}");
                            theList = list;
                            java.lang.System.out.println("{theList.size()}");
                        }
                        override function callback(msg: String) {
                            mes = msg;
                            java.lang.System.out.println(msg);
                        }
                    }
        var task = ListTask {
                        listener: listener
                        onStart: function () {
                            insert Text {content: "Loading..."} into a;
                        }
                        onDone: function () {

                            delete  a;
                            insert HBox {
                                translateX: Constants.VIEWER_WIDTH - 30
                                spacing: 2
                                content: [
                                    Group {
                                        content: [
                                            Rectangle { width: 16 height: 16 fill: Color.TRANSPARENT }
                                            ImageView {
                                                image: Constants.ADD_BUTTON

                                            }
                                         ]
                                         onMouseClicked: function (e: MouseEvent) {
                                                    var w = NoteWindow {
                                                        note: provider.newNote()
                                                    }
                                                    w.create();
                                                }
                                    }
                                ]
                            } into a;
                            for (i in [0..<theList.size()]) { // ToDo: handle exception
                                var item: NoteListItem = theList.get(i) as NoteListItem;
                                java.lang.System.out.println("{item.getNoteID()}");
                                insert Group {
                                    cache: true
				    cursor: Cursor.HAND
                                    content: [
                                        Rectangle {
                                            id: "{item.getNoteID()}"
                                            height: Constants.ITEM_HEIGHT
                                            width: Constants.VIEWER_WIDTH
                                            smooth: false
                                            fill: Constants.GRADIENT
                                            onMouseClicked: function (e: MouseEvent): Void {
                                                var nt: NoteWindow = NoteWindow {
                                                                note: provider.getNote(Integer.parseInt(e.node.id));
                                                            };
                                                nt.create();
                                            }
                                        }
                                        HBox {spacing: 0 translateY: 3 translateX: 5 content: [
                                                VBox {
                                                    spacing: 0
                                                    content: [
                                                        Text {
                                                            font: Font {size: 12}
                                                            content: bind item.getTitle();
                                                            wrappingWidth: Constants.VIEWER_WIDTH - 10
                                                        }
                                                        Text {
                                                            font: Font {
                                                                size: 10
                                                            }
                                                            content: bind item.getExtractions();
                                                            textAlignment: TextAlignment.JUSTIFY
                                                            fill: Color.GRAY
                                                            wrappingWidth: Constants.VIEWER_WIDTH - 10
                                                        }
                                                        Text {
                                                            font: Font {size: 10}
                                                            content: bind item.getDate();
                                                            fill: Color.GREEN
                                                            wrappingWidth: Constants.VIEWER_WIDTH - 10
                                                        }
                                                        // button for removing the note
                                                        Group {
                                                            id: "{item.getNoteID()}"
                                                            content: [
                                                                Rectangle {
                                                                    width: 16
                                                                    height: 16
                                                                    fill: Color.TRANSPARENT
                                                                }
                                                                ImageView {
                                                                    image: Constants.REMOVE_BUTTON
                                                                }
                                                            ]
                                                            onMouseClicked: function (e: MouseEvent) {
                                                                delete e.node.parent.parent.parent from a;
                                                                provider.deleteNote(Integer.parseInt(e.node.id));
                                                            }
                                                            blocksMouse: true
                                                        }
                                                    ]
                                                } // end VBox
                                                // indicates type of media in each note
                                                VBox {spacing: 2 content: [for (p in item.getMediaType()) {
                                                            ImageView {
                                                                image: if (p.equals(Media.Audio)) Constants.AUDIO else if (p.equals(Media.Graphics)) Constants.IMAGE else if (p.equals(Media.Video)) Constants.VIDEO else null
                                                            }
                                                        }]
                                                }
                                            ]
                                        } // end HBox
                                    ] // end group content
                                } // end droup
                                into a;
                            } // end for
                        }
                    }
        task.start();
    } // end showInfo()

    override protected function create(): Node {
        notes = VBox {
            spacing: 2
            width: 50
            content: bind a
        } // end VBox
        return notes;
    }
}// end class

