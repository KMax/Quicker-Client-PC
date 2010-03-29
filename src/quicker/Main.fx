/*
 * Main.fx
 *
 * Created on 24.03.2010, 12:53:10
 */

package quicker;

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

 var provider: QuickerNotesProvider = QuickerNotesProvider.getInstance();

 def HEIGHT = 128;
 def TOP = 100;
 def ITEM_HEIGHT = 40;
 def hIndent: Integer = 350;
 
 var wHeight: Integer = HEIGHT;
 var top: Integer = TOP;

 var toDisplay = "test fdsdasfdfadfffafewawee";

 class QuickerMenu extends CustomNode {
    var items: QuickerMenuItem[];
    
    /**
    *  places the item to the top of the menu
    */
    function onTop(it: QuickerMenuItem) {
        delete it from items;
        insert it before items[0];
    }

    public override function create(): Node {
        return VBox {
                content: bind items

                // defines what type of animation to use: to effect window size or not
                var changeHeight: Boolean = true;
                onMouseClicked: function (e: MouseEvent): Void {

                        // if click is not at menu item, return
                        if (not(e.source.parent.parent.getClass().equals(items[0].getClass()))) return;
                        var temp:QuickerMenuItem = e.source.parent.parent as QuickerMenuItem;

                        // choosing the right way to expand/hide menu items
                        for (item in items) {
                            if ( not item.equals(temp) ) {
                                if (item.expanded) {
                                    item.colapseEx();
                                }
                            } else {
                                if (not item.expanded) {
                                    if (changeHeight) {
                                        item.expand();
                                        changeHeight = false;
                                    } else {
                                        item.expandEx();
                                        changeHeight = false;
                                    }
                                } else {
                                    item.colapse();
                                    changeHeight = true;
                                }
                            }
                        } // end for
                        onTop(temp);
                        // desiding what content to show
                        if (e.source.parent.parent.id == "notes") {
                            toDisplay = "offline";
                        } else {
                            toDisplay = "test fdsdasfdfadfffafewawee";
                        }

                }
            }
        }
}


 class QuickerMenuItem extends CustomNode {
     var text: String;
     var expanded: Boolean = false;
     var h: Integer = 0;

     // colapses an item
     public function colapseEx() {
         Timeline {
              framerate: 20
              repeatCount: 1
              keyFrames : [
                    at (.3s) { h => 0 tween Interpolator.LINEAR }
              ]
         }.play();
         expanded = false;
     }

     // expands an item
     public function expandEx() {
         Timeline {
              framerate: 20
              repeatCount: 1
              keyFrames : [
                     at (.3s) { h => hIndent tween Interpolator.LINEAR }
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
                     at (.3s) { wHeight => HEIGHT + hIndent tween Interpolator.LINEAR },
                  //   at (.3s) { top => TOP - hIndent tween Interpolator.LINEAR },
                     at (.3s) { h => hIndent tween Interpolator.LINEAR }
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
                     at (.3s) { wHeight => HEIGHT tween Interpolator.LINEAR },
                 //    at (.3s) { top => TOP tween Interpolator.LINEAR },
                     at (.3s) { h => 0 tween Interpolator.LINEAR },
             ]
         }.play();
         expanded = false;
     }
     override protected function create () : Node {
         return Group {
                            var lightning = Glow{ level: 0 };
                            content: [
                                Rectangle { // expanding field for text
                                    translateY: ITEM_HEIGHT
                                    translateX: 8
                                    smooth: false
                                    width: 184
                                    height: bind h
                                    fill: Color.YELLOW
                                }
                                Rectangle { // expanding field for text
                                    translateY: ITEM_HEIGHT
                                    translateX: 10
                                    smooth: false
                                    width: 180
                                    height: bind h
                                    fill: Color.LIGHTYELLOW
                                }
                                Text {
                                    fill: Color.BLACK
                                    wrappingWidth: 200
                                    content: bind toDisplay
                                    font: Font {
                                        size: 14
                                        name: "Comic Sans MC"
                                    }
                                    textAlignment: TextAlignment.JUSTIFY
                                    translateX: 10
                                    translateY: 60
                                    visible: bind expanded
                                }

                                Rectangle { // button
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
                                Text { // button caption
                                    font : Font {
                                        size : 16
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

var notes = QuickerMenuItem {
    text: "Заметки"
    id: "notes"
}
var events = QuickerMenuItem {
    text: "События"
    id: "events"
}
var contacts = QuickerMenuItem {
    text: "Контакты"
    id: "contacts"
}

var menu: QuickerMenu = QuickerMenu {
    items: [notes, events, contacts]
}

Stage {
    title: "Quicker"
    x: 750
    y: bind top
    width: 204
    height: bind wHeight
  //  style: StageStyle.UNDECORATED
  style: StageStyle.TRANSPARENT
    scene: Scene {
     //   fill: Color.YELLOW
     fill : null
        content: menu
    }
}