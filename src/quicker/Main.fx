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
import javafx.animation.transition.TranslateTransition;

/**
 * @author Илья
 */

 var hIndent: Integer = 350;

 var eventsMoveY: Integer = 0;
 var contactsMoveY: Integer = 0;
 var endMoveY: Integer = 0;
 var notesExpanded: Boolean = false;
 var eventsExpanded: Boolean = false;
 var contactsExpanded: Boolean = false;

 var notesLightning = Glow{ level: 0 };
 var eventsLightning = Glow{ level: 0 };
 var contactsLightning = Glow{ level: 0 };

var notesExpand = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { eventsMoveY => hIndent tween Interpolator.LINEAR },
            at (0.3s) { contactsMoveY => hIndent tween Interpolator.LINEAR }
	]
}
var notesHide = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { eventsMoveY => 0 tween Interpolator.LINEAR },
            at (0.3s) { contactsMoveY => 0 tween Interpolator.LINEAR }
	]
}
var eventsExpand = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { contactsMoveY => hIndent tween Interpolator.LINEAR }
	]
}
var eventsHide = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { contactsMoveY => 0 tween Interpolator.LINEAR }
	]
}
var contactsExpand = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { endMoveY => hIndent tween Interpolator.LINEAR }
	]
}
var contactsHide = Timeline {
	repeatCount: 1
	keyFrames : [
            at (0.3s) { endMoveY => 0 tween Interpolator.LINEAR }
        ]
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

Stage {
    title: "Quicker"
    x: 750
 //   y: bind 550 - (contactsMoveY + endMoveY)
    y: 100
    width: 204
    height: bind contactsMoveY + endMoveY + 128
    style: StageStyle.UNDECORATED
    scene: Scene {
        fill: LinearGradient {
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

        content: [
                VBox {
                    content: [
                        Group {     // notes
                            content: [
                                Rectangle {
                                    width: 200
                                    height: 40
                                    fill: gradient
                                    stroke: Color.BLACK
                                }
                                Text {
                                    font : Font {
                                        size : 16
                                    }
                                    content: "Заметки"
                                    translateX: 10
                                    translateY: 25
                                }
                            ]
                            onMouseClicked: function (e: MouseEvent): Void {
                                if (not notesExpanded) {
                                //    if (contactsExpanded) { contactsExpanded = false; endMoveY -= hIndent; }
                                //    if (eventsExpanded) { eventsExpanded = false; contactsMoveY -= hIndent; }
                                    if (contactsExpanded) { contactsHide.playFromStart(); eventsExpanded = false; }
                                    if (eventsExpanded) { eventsHide.playFromStart(); eventsExpanded = false; }
                                //    eventsMoveY += hIndent;
                                //    contactsMoveY += hIndent;
                                    notesExpand.playFromStart();
                                    tryTransition.play();
                                    notesExpanded = true;
                                }
                             //   else { eventsMoveY -= hIndent; contactsMoveY -= hIndent; notesExpanded = false; }
                                else { notesHide.playFromStart(); notesExpanded = false; }
                            }
                            effect: notesLightning;
                            onMouseEntered: function (e: MouseEvent): Void {
                                notesLightning.level = 0.7;
                            }
                            onMouseExited: function (e: MouseEvent): Void {
                                notesLightning.level = 0.0;
                            }

                        },
                        Group {         // events
                            content: [
                                Rectangle {
                                    width: 200
                                    height: 40
                                    fill: gradient
                                    stroke: Color.BLACK
                                }
                                Text {
                                    font : Font {
                                        size : 16
                                    }
                                    content: "События"
                                    translateX: 10
                                    translateY: 25
                                }
                            ]
                            translateY: bind eventsMoveY
                            onMouseClicked: function (e: MouseEvent): Void {
                              /*  if (not eventsExpanded) {
                                    if (contactsExpanded) { contactsExpanded = false; endMoveY -= hIndent; }
                                    if (notesExpanded) { notesExpanded = false; eventsMoveY -= hIndent; contactsMoveY -= hIndent; }
                                    contactsMoveY += hIndent;
                                    eventsExpanded = true;
                                }
                                else { contactsMoveY -= hIndent; eventsExpanded = false; }*/
                                if (not eventsExpanded) {
                                    if (contactsExpanded) { contactsExpanded = false; contactsHide.playFromStart(); }
                                    if (notesExpanded) { notesExpanded = false; notesHide.playFromStart(); }
                                    eventsExpand.playFromStart();
                                    eventsExpanded = true;
                                }
                                else { eventsHide.playFromStart(); eventsExpanded = false; }
                            }
                            effect: eventsLightning;
                            onMouseEntered: function (e: MouseEvent): Void {
                                eventsLightning.level = 0.7;
                            }
                            onMouseExited: function (e: MouseEvent): Void {
                                eventsLightning.level = 0.0;
                            }
                        }
                        Group {             // contacts
                            content: [
                                Rectangle {
                                    width: 200
                                    height: 40
                                    fill: gradient
                                    stroke: Color.BLACK
                                }
                                Text {
                                    font : Font {
                                        size : 16
                                    }
                                    content: "Контакты"
                                    translateX: 10
                                    translateY: 25
                                }
                            ]
                            translateY: bind contactsMoveY
                            onMouseClicked: function (e: MouseEvent): Void {
                           /*     if (not contactsExpanded) {
                                    if (eventsExpanded) { eventsExpanded = false; contactsMoveY -= hIndent; }
                                    if (notesExpanded) { notesExpanded = false; eventsMoveY -= hIndent; contactsMoveY -= hIndent; }
                                    endMoveY += hIndent; contactsExpanded = true;
                                }
                                else { endMoveY -= hIndent; contactsExpanded = false; }*/
                                if (not contactsExpanded) {
                                    if (eventsExpanded) { eventsExpanded = false; eventsHide.playFromStart(); }
                                    if (notesExpanded) { notesExpanded = false; notesHide.playFromStart(); }
                                    contactsExpand.playFromStart();
                                    contactsExpanded = true;
                                }
                                else { contactsHide.playFromStart(); contactsExpanded = false; }
                            }
                            effect: contactsLightning;
                            onMouseEntered: function (e: MouseEvent): Void {
                                contactsLightning.level = 0.7;
                            }
                            onMouseExited: function (e: MouseEvent): Void {
                                contactsLightning.level = 0.0;
                            }
                        }
                   ]
              }
        ]
    }
}