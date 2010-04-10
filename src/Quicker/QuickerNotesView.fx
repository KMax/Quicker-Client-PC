package Quicker;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import Quicker.Constants;
import javafx.scene.input.MouseEvent;
import Quicker.noteWindow.NoteWindow;
import javafx.scene.layout.HBox;
import javafx.scene.image.ImageView;
import javafx.geometry.HPos;

public class QuickerNotesView extends CustomNode {

    override protected function create(): Node {
	var provider: Controller = Controller.getInstance();
	return VBox {
		    spacing: 2
		    width: 50
		    content: [
			for (i: NoteListItem in provider.getNoteList()) { // handle exception
			    Group {
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
					]
				    } // end VBox
                                    // indicates type of media in each note
                                    VBox { spacing: 2 content: [ for (p in i.getMediaType()) {
                                            ImageView {
                                                image: if (p.equals(Media.Audio)) Constants.AUDIO
                                                        else if (p.equals(Media.Graphics)) Constants.IMAGE
                                                        else if (p.equals(Media.Video)) Constants.VIDEO
                                                        else null
                                            }
                                            }]
                                    }
                                    ]}
				] // end group content
			    } // end droup
			} // end for
		    ] // end content
		} // end VBox
    } // end create()
}// end class

