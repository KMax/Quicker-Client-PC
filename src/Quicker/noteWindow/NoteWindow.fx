package javafxapplication2;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafxapplication2.TextArea;
import javafx.scene.paint.Color;
import javafx.stage.Screen;
import javafx.scene.control.Button;
import javafx.ext.swing.SwingTextField;
import javafx.scene.Group;

var textf = SwingTextField {
            columns: 10
            text: "TextField"
            editable: true
        }
def screen: Screen = Screen.primary;
def bClose = Button {
            text: "Close"
            // width: window.width/2
            action: function () {
                window.close();
            }
        }
var window: Stage = Stage {
            title: "Заголовок";
            x: 100
            y: 100
            width: 400;
            height: 400;
            scene: Scene {
                fill: Color.YELLOW;
                content: [Group {
                        content: [
                            TextArea {
                                width: bind window.width - 6;
                               // height: bind window.height / 2-15;
                               height: bind window.height-100;
                            }

                            Button {
                                layoutX: bind (window.width / 5);
                                layoutY: bind window.height - 83;
                                height: 34;
                                width: bind (window.width / 3)
                            }

                          /*  Button {
                                layoutX: bind (window.width / 8);
                                layoutY: bind (window.height / 8) * 5;
                                height: bind (window.height / 4-15)
                                width: bind (window.width / 4)
                            }
                             Button {
                                layoutX: bind (window.width / 8)*5;
                                layoutY: bind (window.height / 8) * 5;
                                height: bind (window.height / 4-30)
                                width: bind (window.width / 4)
                            }*/
                        ]
                    }
                ];
            }}


//window.x = (Screen.primary.bounds.width - window.width)/2;
//window.y = (Screen.primary.bounds.height - window.height)/2;



