package Quicker;

import javafx.animation.Interpolator;
import javafx.animation.Timeline;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.effect.Glow;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

package var wHeight: Integer = Constants.HEIGHT;
package var top: Integer = Constants.TOP;

public class QuickerMenuButton extends CustomNode {

    public var text: String;
    public var viewer: Node;
    var h: Integer = 0;
    public var expanded: Boolean = false;
    var scroll = ScrollPane {
		content: viewer;
		width: Constants.VIEWER_WIDTH;
		height: Constants.hIndent - 20;
		vertical: true;
		visible: bind expanded;
	    }

    // colapses an item
    public function colapseEx() {
	Timeline {
	    framerate: 20
	    repeatCount: 1
	    keyFrames: [
		at (.3s) {h => 0 tween Interpolator.LINEAR}
	    ]
	}.play();
	expanded = false;
    }

    // expands an item
    public function expandEx() {
	Timeline {
	    framerate: 20
	    repeatCount: 1
	    keyFrames: [
		at (.3s) {h => Constants.hIndent tween Interpolator.LINEAR}
	    ]
	}.play();
	expanded = true;
    }

    // expands an item, changes window height
    public function expand() {
	Timeline {
	    framerate: 20
	    repeatCount: 1
	    keyFrames: [
		at (.3s) {wHeight => Constants.HEIGHT + Constants.hIndent tween Interpolator.LINEAR},
		//at (.3s) { top => Constants.TOP - Constants.hIndent tween Interpolator.LINEAR },
		at (.3s) {h => Constants.hIndent tween Interpolator.LINEAR}
	    ]
	}.play();
	expanded = true;
    }

    // colapses an item, changes window height
    public function colapse() {
	Timeline {
	    framerate: 20
	    repeatCount: 1
	    keyFrames: [
		at (.3s) {wHeight => Constants.HEIGHT tween Interpolator.LINEAR},
		//at (.3s) { top => Constants.TOP tween Interpolator.LINEAR },
		at (.3s) {h => 0 tween Interpolator.LINEAR},
	    ]
	}.play();
	expanded = false;
    }

    override protected function create(): Node {
	scroll.translateX = 10 + (Constants.AREA_WIDTH - Constants.VIEWER_WIDTH) / 2;
	scroll.translateY = Constants.MENU_BUTTON_HEIGHT + 10;
	return Group {
		    var lightning = Glow { level: 0 };
		    content: [
			Rectangle { // expanding field for text
			    translateY: Constants.MENU_BUTTON_HEIGHT
			    translateX: 8
			    smooth: false
			    width: Constants.AREA_WIDTH + 4
			    height: bind h
			    fill: Color.GRAY
			}
			Rectangle { // expanding field for text
			    translateY: Constants.MENU_BUTTON_HEIGHT
			    translateX: 10
			    smooth: false
			    width: Constants.AREA_WIDTH
			    height: bind h
			    fill: Color.LIGHTYELLOW
			}
			scroll,
			Rectangle { // button
			    smooth: false
			    cache: true
			    width: 200
			    height: Constants.MENU_BUTTON_HEIGHT
			    fill: Constants.BUTTON_COLOR
			    stroke: Color.BLACK
			    effect: lightning;
			    onMouseEntered: function (e: MouseEvent): Void {
				lightning.level = 0.7;
			    }
			    onMouseExited: function (e: MouseEvent): Void {
				lightning.level = 0.0;
			    }
			}
			Text { // button caption
			    font: Font {
				size: 16
			    }
			    content: text
			    translateX: 10
			    translateY: 25
			    cache: true
			}
		    ]
		};
    }

}

