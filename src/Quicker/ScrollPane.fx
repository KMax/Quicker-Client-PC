package Quicker;

import javafx.scene.control.ScrollBar;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.layout.Resizable;
import java.lang.UnsupportedOperationException;
import javafx.scene.layout.ClipView;

public class ScrollPane extends CustomNode {

    public var content: Node;
    public var vertical: Boolean = false;
    public var horizontal: Boolean = false;
    public var height: Float;
    public var width: Float;
    
    def w: Number = bind content.layoutBounds.width + vsb.width;

    def h: Number = bind content.layoutBounds.height + hsb.height;


    def vsb: ScrollBar = ScrollBar {
		translateX: bind width - vsb.width;
		min: 0
		max: 1
		visible: bind (h > height and vertical)
		vertical: true
		height: bind height
	    }
    def hsb: ScrollBar = ScrollBar {
		min: 0
		max: 1
		visible: bind (w > width and horizontal);
		width: bind if (vsb.visible) then width - vsb.width else width
	    }
    var clipContent:ClipView = ClipView {
				    pannable:false;
				    node: content;
				    width: width;
				    height: height;
				    clipX: bind hsb.value*(width - clipContent.maxClipX);
				    clipY: bind vsb.value*(height - clipContent.maxClipY);
				    }

    override protected function create() {
	return Group {
		    content: [clipContent,vsb, hsb]
		    onMouseWheelMoved: function (event) {
			vsb.value += event.wheelRotation * 10
		    }
		}
    }

}

