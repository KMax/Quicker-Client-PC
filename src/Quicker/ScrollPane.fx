package Quicker;

import javafx.scene.control.ScrollBar;
import javafx.scene.Node;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.layout.ClipView;
import javafx.scene.input.MouseEvent;

public class ScrollPane extends CustomNode {

    public var content: Node;
    //Включает появление вертикального ScrollBar'a
    public var vertical: Boolean = false;
    //Включает появление гризонтального ScrollBar'a
    public var horizontal: Boolean = false;
    public var height: Float;
    public var width: Float;
    //Скорость прокручивания вертикального ScrollBar колёсиком
    public var wheelSpeed: Float = 10;
    
    def w: Float = bind {
		if(vertical){
		    content.layoutBounds.width + vsb.width;
		}else{
		    content.layoutBounds.width;
		}
	    };

    def h:Float = bind {
		if(horizontal){
		    content.layoutBounds.height + hsb.height;
		}else{
		    content.layoutBounds.height;
		}
	    };

    def vsb: ScrollBar = ScrollBar {
		translateX: bind width - vsb.width;
		min: 0.0;
		max: 1.0;
		visible: bind (h > height and vertical)
		vertical: true
		height: bind height
	    }
    def hsb: ScrollBar = ScrollBar {
		min: 0.0;
		max: 1.0;
		visible: bind (w > width and horizontal);
		width: bind if (vsb.visible) then width - vsb.width else width
	    }
    var clipContent:ClipView = ClipView {
	pannable:false;
	node: content;
	width: width;
	height: height;
	clipX: bind hsb.value*(w - width);
	clipY: bind vsb.value*(h - height);

	onMouseWheelMoved:function(e:MouseEvent){
		def tmp = vsb.value + e.wheelRotation/wheelSpeed;
		if(tmp <= vsb.max){
		    if(tmp >=vsb.min){
			vsb.value = tmp;
		    }else{
			vsb.value = vsb.min;
		    }
		}else{
		    vsb.value = vsb.max;
		}
	}
    }

    override protected function create() {
	return Group {
		    content: [clipContent,vsb, hsb]
		}
    }

}

