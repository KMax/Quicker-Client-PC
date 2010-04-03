package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.control.Button;
import javafx.scene.Group;
import Quicker.noteWindow.TextArea;

public class NoteWindow {

    public function create(noteText: String): Stage {  
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
                                        height: bind window.height - 100;
                                        text: noteText;
                                    }
                                    Button {
                                        text: "Save"
                                        layoutX: bind (window.width / 3)-6;
                                        layoutY: bind window.height - 83;
                                        height: 34;
                                        width: bind (window.width / 3)                                        
                                        onMouseClicked: function (event) {                                            
                                        
                                        }
                                    }
                                ]
                            }
                        ];
                    }
                }
        return window
    }
}

