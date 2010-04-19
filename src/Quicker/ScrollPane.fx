/***************************************************************************
*
*	Copyright 2010 Quicker Team
*
*	Quicker Team is:
*		Kirdeev Andrey (kirduk@yandex.ru)
* 	Koritniy Ilya (korizzz230@bk.ru)
* 	Kolchin Maxim	(kolchinmax@gmail.com)
*/
/****************************************************************************
*
*	This file is part of Quicker.
*
*	Quicker is free software: you can redistribute it and/or modify
*	it under the terms of the GNU Lesser General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	Quicker is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*	GNU Lesser General Public License for more details.
*
*	You should have received a copy of the GNU Lesser General Public License
*	along with Quicker. If not, see <http://www.gnu.org/licenses/>


****************************************************************************/
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
		translateY: bind height - hsb.height;
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
		if(vertical){
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
    }

    override protected function create() {
	return Group {
		    content: [clipContent,vsb, hsb]
		}
    }

}

