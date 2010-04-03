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

public class QuickerNotesView extends CustomNode {

    override protected function create(): Node {
	var provider: Controller = Controller.getInstance();
	return VBox {
		    spacing: 2
		    width: 50
		    content: [
			for (i: NoteListItem in provider.getNoteList()) {
			    Group {
				//    cache: true
				content: [
				    Rectangle {
					height: Constants.ITEM_HEIGHT
					width: Constants.VIEWER_WIDTH
					smooth: false
					fill: Constants.GRADIENT
					onMouseClicked: function (e: MouseEvent): Void {
					    // NoteWindow.noteText = "sdf";
					    // var w = NoteWindow.window;
					    var nt: NoteWindow = new NoteWindow();
					    nt.create("fdfgdf");

					}
				    }
				    VBox {
					translateY: 3
					translateX: 5
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
						content: bind i.getDate().toString();
						fill: Color.GREEN
						wrappingWidth: Constants.VIEWER_WIDTH - 10
					    }
					]
				    } // end VBox
				] // end group content
			    } // end droup
			} // end for
		    ] // end content
		} // end VBox
    } // end create()
}// end class

