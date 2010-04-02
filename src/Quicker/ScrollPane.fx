package Quicker;

import javafx.scene.control.ScrollBar;
import javafx.scene.layout.VBox;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import javafx.scene.layout.ClipView;
import javafx.scene.Group;

public class ScrollPane extends CustomNode {

    public var content: Node[];
    public var width: Float;
    public var height: Float;

    override protected function create(): Node {
	var scroll: ScrollBar = ScrollBar {
		    translateX: bind (this.width - scroll.width);
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
			clip, scroll
		    ]
		};
    }

}
