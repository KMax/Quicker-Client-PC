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
import javafx.scene.text.TextAlignment;

/**
 * @author Илья
 */

 def HEIGHT = 128;
 def TOP = 100;
 def ITEM_HEIGHT = 40;
 def hIndent: Integer = 350;
 
 var wHeight: Integer = HEIGHT;
 var top: Integer = TOP;

 class QuickerItem extends CustomNode {
     var text: String;
     var expanded: Boolean = false;
     var h: Integer = 0;
     var other1: QuickerItem;
     var other2: QuickerItem;

     public function hideEx() {
         Timeline {
              framerate: 20
              repeatCount: 1
              keyFrames : [
                    at (.3s) { h => 0 tween Interpolator.LINEAR }
              ]
         }.play();
     }
     public function expandEx() {
         Timeline {
              framerate: 20
              repeatCount: 1
              keyFrames : [
                     at (.3s) { h => hIndent tween Interpolator.LINEAR }
              ]
          }.play();
     }
     public function expand() {
         Timeline {
             framerate: 20
             repeatCount: 1
             keyFrames: [
                     at (.3s) { wHeight => HEIGHT + hIndent tween Interpolator.LINEAR },
                  //   at (.3s) { top => TOP - hIndent tween Interpolator.LINEAR },
                     at (.3s) { h => hIndent tween Interpolator.LINEAR }
             ]
         }.play();
     }
     public function hide() {
         Timeline {
             framerate: 20
             repeatCount: 1
             keyFrames: [
                     at (.3s) { wHeight => HEIGHT tween Interpolator.LINEAR },
                 //    at (.3s) { top => TOP tween Interpolator.LINEAR },
                     at (.3s) { h => 0 tween Interpolator.LINEAR },
             ]
         }.play();

     }
     override protected function create () : Node {
         return Group {
                            var lightning = Glow{ level: 0 };
                            content: [
                                Rectangle {
                                    translateY: ITEM_HEIGHT
                                    smooth: false
                                    width: 200
                                    height: bind h
                                    fill: Color.LIGHTYELLOW
                                }
                                Text {
                                    fill: Color.BLACK
                                    wrappingWidth: 200
                                    content: "test fdsdasfdfadfffafewawee"
                                    font: Font {
                                        size: 14
                                        name: "Comic Sans MC"
                                    }
                                    textAlignment: TextAlignment.JUSTIFY
                                    translateX: 10
                                    translateY: 60
                                    visible: bind expanded
                                }

                                Rectangle {
                                    smooth: false
                                    cache: true
                                    width: 200
                                    height: ITEM_HEIGHT
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
                                    cache: true
                                }
                            ]
                            onMouseClicked: function (e: MouseEvent): Void {
                                onTop(this);
                                if (not expanded) {
                                    if (other1.expanded) {
                                        other1.hideEx();
                                        other1.expanded = false;
                                        expandEx();
                                    } else if (other2.expanded) {
                                        other2.hideEx();
                                        other2.expanded = false;
                                        expandEx();
                                    } else {
                                        expand();
                                        java.lang.System.out.println("not expanded");
                                    }
                                    expanded = true;
                                } else {
                                    hide();
                                    expanded = false;
                                }
                                /*
                                if (not expanded) {
                                    if (other1.expanded) {
                                        other1.h = ITEM_HEIGHT;
                                        other1.expanded = false;
                                        h = ITEM_HEIGHT + hIndent;
                                    } else if (other2.expanded) {
                                        other2.h = ITEM_HEIGHT;
                                        other2.expanded = false;
                                        h = ITEM_HEIGHT + hIndent;
                                    } else {
                                        h = ITEM_HEIGHT + hIndent;
                                        wHeight = wHeight + hIndent;
                                        top = top - hIndent;
                                        expanded = true;
                                    }
                                    expanded = true;
                                } else {
                                    h = ITEM_HEIGHT;
                                    wHeight = HEIGHT;
                                    top = TOP;
                                    expanded = false;
                                }
                                onTop(this);*/
                            } // end onMouseClicked
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
    id: "notes"
}
var events = QuickerItem {
    text: "События"
    id: "events"
}
var contacts = QuickerItem {
    text: "Контакты"
    id: "contacts"
}
events.other1 = notes;
events.other2 = contacts;
notes.other1 = events;
notes.other2 = contacts;
contacts.other1 = notes;
contacts.other2 = events;

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
        fill: Color.YELLOW

        content: [
                VBox {
                    content: 
                        bind items;
                   
              }
        ]
    }
}