/***************************************************************************
*
* Copyright 2010 Quicker Team
*
* Quicker Team is:
* Kirdeev Andrey (kirduk@yandex.ru)
* Koritniy Ilya (korizzz230@bk.ru)
* Kolchin Maxim (kolchinmax@gmail.com)
*/
/****************************************************************************
*
* This file is part of Quicker.
*
* Quicker is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Quicker is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with Quicker. If not, see <http://www.gnu.org/licenses/>


****************************************************************************/
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
import Quicker.views.View;
import javafx.animation.KeyFrame;

package var wHeight: Integer = Constants.HEIGHT;
package var top: Integer = Constants.TOP;

public class MenuButton extends CustomNode {

    public var text: String;
    public var viewer: View;
    var h: Integer = 0;
    public var expanded: Boolean = false;
    var scroll = ScrollPane {
                    content: viewer
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
                KeyFrame {
                    time: .3s
                    values: [h => Constants.hIndent tween Interpolator.LINEAR]
                    action: function () {
                        this.viewer.showInfo();
                    }
                }
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
                KeyFrame {
                    time: .3s
                    values: [
                            wHeight => Constants.HEIGHT + Constants.hIndent tween Interpolator.LINEAR,
                            h => Constants.hIndent tween Interpolator.LINEAR
                    ]
                    action: function () {
                        this.viewer.showInfo();
                    }
                }
                //at (.3s) { top => Constants.TOP - Constants.hIndent tween Interpolator.LINEAR },
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
                                width: Constants.MENU_BUTTON_WIDTH
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
                                translateY: Constants.MENU_BUTTON_HEIGHT / 2 + 5
                                cache: true
                            }
                        ]
                    };
    }

}

