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
import javafx.scene.control.ProgressIndicator;
import java.lang.Void;

public class NotesView extends View {

    var provider: Controller = Controller.getInstance();
    var notes: Node;
    def prog = ProgressIndicator {
                    progress: bind ProgressIndicator.computeProgress(100, 30)
                };
    var a: Node[] = prog;

    override public function showInfo()               {
        if (a[0] != prog) return;
        // тут начать поток
        onDataReady();
    } // end showInfo()

    override protected function create(): Node {
        notes = VBox {
            spacing: 2
            width: 50
            content: bind a
        } // end VBox
        return notes;
    }

    override public function onDataReady()               {
        delete  a;
        insert HBox {
            translateX: Constants.VIEWER_WIDTH - 30
            spacing: 2
            content: [
                ImageView { image: Constants.ADD_BUTTON
                    onMouseClicked: function (e: MouseEvent) {
                        var w = NoteWindow {
                                        note: provider.newNote()
                                    }
                        w.create();
                    }
                }
            ]
        } into a;
        for (i: NoteListItem in provider.getNoteList()) { // handle exception
            insert Group {
                cache: true
                content: [
                    Rectangle {
                        id: "{i.getNoteID()}"
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
                    HBox { spacing: 0 translateY: 3 translateX: 5 content: [
                            VBox {
                                spacing: 0
                                content: [
                                    Text {
                                        font: Font { size: 12 }
                                        content: bind i.getTitle();
                                        wrappingWidth: Constants.VIEWER_WIDTH - 10
                                    }
                                    Text {
                                        font: Font {
                                            size: 10
                                        }
                                        content: bind i.getExtractions();
                                        textAlignment: TextAlignment.JUSTIFY
                                        fill: Color.GRAY
                                        wrappingWidth: Constants.VIEWER_WIDTH - 10
                                    }
                                    Text {
                                        font: Font { size: 10 }
                                        content: bind i.getDate();
                                        fill: Color.GREEN
                                        wrappingWidth: Constants.VIEWER_WIDTH - 10
                                    }
                                    ImageView {
                                        id: "{i.getNoteID()}"
                                        image: Constants.REMOVE_BUTTON
                                        onMouseClicked: function (e: MouseEvent) {
                                            delete e.node.parent.parent.parent from a;
                                         //   provider.deleteNote(Integer.parseInt(this.id));
                                        }
                                        blocksMouse: true
                                    }
                                ]
                            } // end VBox
                            // indicates type of media in each note
                            VBox { spacing: 2 content: [for (p in i.getMediaType()) {
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
}// end class

