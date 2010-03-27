/*
 * Main.fx
 *
 * Created on 24.03.2010, 12:53:10
 */

package Quicker;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.StageStyle;
import javafx.animation.Timeline;
import javafx.animation.Interpolator;
import javafx.scene.effect.Glow;
import javafx.scene.CustomNode;
import javafx.scene.Node;

/**
 * @author Илья
 */

 def HEIGHT = 128;
 def TOP = 450;

 var hIndent: Integer = 350;
 
 var wHeight: Integer = HEIGHT;
 var top: Integer = TOP;

 class QuickerItem extends CustomNode {
     var text: String;
     var expanded: Boolean = false;
     var h: Integer = 40;
     var other1: QuickerItem;
     var other2: QuickerItem;

     public function hide1() {
         Timeline {
              framerate: 15
              repeatCount: 1
                   keyFrames : [
                        at (0.3s) { h => 40 tween Interpolator.LINEAR }
                   ]
              }.playFromStart();
     }
     
     override protected function create () : Node {
         return Group {     // notes
                            var lightning = Glow{ level: 0 };
                            content: [
                                Rectangle {
                                    smooth: false
                                    width: 200
                                    height: bind h
                                    fill: Color.LIGHTYELLOW
                                }
                                Rectangle {
                                    smooth: false
                                    width: 200
                                    height: 40
                                    fill: gradient
                                    stroke: Color.BLACK
                                    effect: lightning;
                                    onMouseEntered: function (e: MouseEvent): Void {
                                        lightning.level = 0.7;
                                    }
                                    onMouseExited: function (e: MouseEvent): Void {
                                        lightning.level = 0.0;
                                    }
                                }
                                Text {
                                    font : Font {
                                        size : 16
                                    }
                                    content: text
                                    translateX: 10
                                    translateY: 25
                                }
                            ]
                            var expand = Timeline {
                                    framerate: 15
                                    repeatCount: 1
                                        keyFrames : [
                                            at (0.3s) { wHeight => (wHeight+hIndent) tween Interpolator.LINEAR },
                                            at (0.3s) { top => (top-hIndent) tween Interpolator.LINEAR }
                                            at (0.3s) { h => h+hIndent tween Interpolator.LINEAR }
                                        ]
                                };
                            var hide = Timeline {
                                    framerate: 15
                                    repeatCount: 1
                                        keyFrames : [
                                            at (0.3s) { wHeight => HEIGHT tween Interpolator.LINEAR },
                                            at (0.3s) { top => TOP tween Interpolator.LINEAR }
                                            at (0.3s) { h => 40 tween Interpolator.LINEAR }
                                        ]
                                };
                            var expandEx = Timeline {
                                            repeatCount: 1
                                                keyFrames : [
                                                        at (0.3s) { h => h+hIndent tween Interpolator.LINEAR }
                                                ]
                                        };
                            onMouseClicked: function (e: MouseEvent): Void {
                              /*  if (not expanded) {
                                    if (other1.expanded) {
                                        other1.hide();
                                        other1.expanded = false;
                                        expandEx.playFromStart();
                                    } else if (other2.expanded) {
                                        other2.hide();
                                        other2.expanded = false;
                                        expandEx.playFromStart();
                                    } else {
                                        expand.playFromStart();
                                    }
                                    expanded = true;
                                } else {
                                    hide.playFromStart();
                                    expanded = false;
                                }*/
                                if (not expanded) {
                                    if (other1.expanded) {
                                        other1.h = 40;
                                        other1.expanded = false;
                                        h = 40 + hIndent;
                                    } else if (other2.expanded) {
                                        other2.h = 40;
                                        other2.expanded = false;
                                        h = 40 + hIndent;
                                    } else {
                                        h = 40 + hIndent;
                                        wHeight = wHeight + hIndent;
                                        top = top - hIndent;
                                        expanded = true;
                                    }
                                    expanded = true;
                                } else {
                                    h = 40;
                                    wHeight = HEIGHT;
                                    top = TOP;
                                    expanded = false;
                                }
                                onTop(this);
                            }
                        };
     }
 }

 var gradient = LinearGradient {
            startX: 0.0
            startY: 1.0
            endX: 0.0
            endY: 0.0
            stops: [
                Stop {
                    color : Color.GRAY
                    offset: 0.0
                },
                Stop {
                    color : Color.LIGHTGRAY
                    offset: 1.0
                },
            ]
        }

var background = LinearGradient {
            startX: 0.0
            startY: 0.0
            endX: 1.0
            endY: 0.0
            stops: [
                Stop {
                    color : Color.YELLOW
                    offset: 0.0
                },
                Stop {
                    color : Color.LIGHTYELLOW
                    offset: 1.0
                },
            ]
        }

var notes = QuickerItem {
    text: "Заметки"
}
var events = QuickerItem {
    text: "События"
    other1: notes
}
var contacts = QuickerItem {
    text: "Контакты"
    other1: notes
    other2: events
}
events.other2 = contacts;
notes.other1 = events;
notes.other2 = contacts;

var items = [notes, events, contacts];

function onTop(i: QuickerItem) {
    delete i from items;
    insert i before items[0];
}


Stage {
    title: "Quicker"
    x: 750
    y: bind top
    width: 204
    height: bind wHeight
    style: StageStyle.UNDECORATED
    scene: Scene {
        fill: background

        content: [
                VBox {
                    content: 
                        bind items;
                   
              }
        ]
    }
}