package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.control.Button;
import javafx.scene.Group;
import Quicker.noteWindow.TextArea;
import Quicker.ScrollPane;
import javafx.scene.Node;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;

public class NoteWindow {
    def gradient = LinearGradient {
                startX: 0.0
                startY: 0.0
                endX: 0.0
                endY: 1.8
                stops: [
                    Stop {
                        color: Color.GRAY
                        offset: 0.0
                    },
                    Stop {
                        color: Color.LIGHTYELLOW
                        offset: 1.0
                    },
                ]
            }
    public function create(title: String, noteText: String): Stage {
        var viewer: Node;
        var scroll = ScrollPane {
                    content: viewer;
                    width: 100;
                    height: 300;
                }
        var window: Stage = Stage {
                    title: "Quicker - {title}";
                    x: 100
                    y: 100
                    width: 400;
                    height: 400;
                    scene: Scene {
                        fill: gradient
                        content: [Group {
                                content: [
                                    TextArea {
                                        layoutX: 10
                                        layoutY: 10
                                        width: bind window.width - 136;
                                        // height: bind window.height / 2-15;
                                        height: bind window.height - 100;
                                        text: noteText;
                                    }
                                    Button {
                                        text: "Save"
                                        layoutX: bind (window.width / 8);
                                        layoutY: bind window.height - 83;
                                        height: 34;
                                        width: bind (window.width / 8 * 2.5)
                                        onMouseClicked: function (event) {
                                        }
                                    }
                                    Button {
                                        text: "Close"
                                        layoutX: bind (window.width / 2);
                                        layoutY: bind window.height - 83;
                                        height: 34;
                                        width: bind (window.width / 8 * 2.5)
                                        onMouseClicked: function (event) {
                                            window.close();
                                        }
                                    }
                                    Rectangle { // button
                                        translateX: bind window.width - 110;
                                        translateY: 10;
                                        width: 90
                                        height: bind window.height - 100
                                        fill: Color.WHITE
                                        smooth: false
                                    }
                                    scroll
                                ]
                            }
                        ];
                    }
                }

        return window
    }
}

