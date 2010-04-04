package Quicker;

import javafx.scene.control.ScrollBar;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import javafx.scene.layout.ClipView;
import javafx.scene.Group;

public class ScrollPane extends CustomNode {

    public var content: Node;
    public var width: Float;
    public var height: Float;

    override protected function create(): Node {
	var clip:ClipView = ClipView {
		    pannable: false;
		    width: this.width;
		    height: this.height;
		    clipX: 0.0, clipY: bind (scroll.value * clip.maxClipY);
		    node: this.content;
		};
	var scroll: ScrollBar = ScrollBar {
		    translateX: bind (this.width - scroll.width);
		    height: this.height;
		    min: 0, max: 1;
		    vertical: true;
                    visible: (this.height < clip.maxClipY);
		}
	return Group {
		    content: [
			clip, scroll
		    ]
		};
    }

}
