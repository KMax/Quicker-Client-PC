package Quicker;

import javafx.scene.control.ScrollBar;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.scene.layout.VBox;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import javafx.scene.layout.ClipView;
import javafx.scene.layout.HBox;
import javafx.scene.Group;

class ScrollPane extends CustomNode {

    override protected function create(): Node {
	var scroll = ScrollBar {
		    height: this.height;
		    min: 0, max: 1;
		    vertical: true;
		}
	var content = VBox {
			spacing: 5;
			content: this.content;
		    };
	var clip = ClipView {
		    width: this.width;
		    height: this.height;
		    clipX: 0.0, clipY: bind (scroll.value * (content.height - this.height));
		    node: content;
		};
	return Group {
		    content: [
			clip,scroll
		    ]
		};  
}




                            public var content: Node[];
    public var width: Float;
    public var height: Float;
}
var texts: Text[];

for (i in [0..25]) {
    insert Text {
	content: "Заголовок заметки";
    } into texts;

}
var window = Stage {
	    title: "Simple ScrollBar Use"
	    width: 240
	    height: 320
	    style: StageStyle.UNDECORATED
	    scene: Scene {
		fill: Color.GREEN;
		content: [
		    ScrollPane {
			content: texts;
			width: 240;
			height: 100;
		    }
		]
	    }
	}
