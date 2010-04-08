package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import Quicker.noteWindow.TextArea;
import Quicker.ScrollPane;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.stage.StageStyle;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.layout.HBox;
import Quicker.noteWindow.showingWindow;
import javafx.scene.input.MouseEvent;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.VBox;

public class NoteWindow {

    public var title: String;
    public var noteText: String;
    def color: Color = Color.YELLOW;
    var panel: Integer = 0;
    protected var check: Boolean = true;
    protected var butVis: Boolean = true;
    protected var group     ;
    protected var testMedia = [
                Image {url: "{__DIR__}Images/closebutton.JPG"},
                Image {url: "{__DIR__}Images/buttonBind.bmp"},
                Image {url: "{__DIR__}Images/testImage.jpg"}
            ];

    public function create(): Stage {
        var window: Stage = Stage {
                    title: title;
                    style: StageStyle.UNDECORATED
                    width: 250;
                    height: 400;
                    scene: Scene {
                        fill: color
                        content: [
                            Group {
                                content: [
                                    TextArea {
                                        layoutX: 0
                                        layoutY: 24
                                        width: bind window.width;
                                        height: bind window.height - 50 - panel;
                                        text: noteText;
                                    }
                                    Rectangle {
                                        layoutX: 30
                                        layoutY: 0
                                        width: bind window.width - 60
                                        height: 20
                                        fill: color;
                                        onMouseDragged: function (e) {
                                            window.x += e.dragX;
                                            window.y += e.dragY;
                                        }
                                    }
                                    ImageView {
                                                    var im
                                               : Image = Image {url: "{__DIR__}Images/closebutton.JPG"};
                                        image: bind im;
                                        layoutX: bind window.width - 23;
                                        layoutY: 3;
                                        onMouseEntered: function (e)
                                        {
                                            im = Image {url: "{__DIR__}Images/buttoncloseEntered.JPG"};
                                        }
                                        onMouseExited: function (e) {
                                            im = Image {url: "{__DIR__}Images/closebutton.JPG"};
                                        }
                                        onMouseClicked: function (e) {
                                            window.close();
                                        }
                                    }
                                    ImageView {
                                                 var im
                                               : Image = Image {url: "{__DIR__}Images/buttonBind.bmp"};
                                        image: bind im;
                                        layoutX: 3;
                                        layoutY: 3;
                                        onMouseEntered: function (e)
                                        {
                                            im = Image {url: "{__DIR__}Images/buttonBind2.bmp"};
                                        }
                                        onMouseExited: function (e) {
                                            im = Image {url: "{__DIR__}Images/buttonBind.bmp"};
                                        }
                                    }
                                    ImageView {
                                                    var im
                                               : Image = Image {url: "{__DIR__}Images/buttonSave.bmp"};
                                        image: bind im;
                                        layoutX: 3;
                                        layoutY: bind window.height - 23;
                                        onMouseEntered: function (e)
                                        {
                                            im = Image {url: "{__DIR__}Images/buttonSave2.bmp"};
                                        }
                                        onMouseExited: function (e) {
                                            im = Image {url: "{__DIR__}Images/buttonSave.bmp"};
                                        }
                                    }
                                    ImageView {
                                                            var im
                                               : Image = Image {url: "{__DIR__}Images/buttonMedia.bmp"};
                                        image: bind im;
                                        visible: bind butVis;
                                        layoutX: bind window.width/2-27;
                                        layoutY: bind window.height-23;
                                        onMouseEntered: function (e)
                                        {
                                            im = Image {url: "{__DIR__}Images/buttonMediaEntered.bmp"};
                                        }
                                        onMouseExited: function (e) {
                                            im = Image {url: "{__DIR__}Images/buttonMedia.bmp"};
                                        }
                                        onMouseClicked: function (e: MouseEvent) {
                                            panel = 65;
                                            butVis = false;
                                            group = Group {
                                                visible: bind if (butVis) false else true;
                                                content: [
                                                    Rectangle {
                                                        layoutX: 5;
                                                        layoutY: bind window.height - 85;
                                                        height: 50;
                                                        width: bind window.width - 10;
                                                        fill: Color.GREENYELLOW;
                                                    }
                                                    HBox {
                                                        spacing: 10
                                                        layoutX: 10;
                                                        layoutY: bind window.height - 80;
                                                        height: 50;
                                                        width: bind window.width - 20;
                                                        content: [
                                                            for (i: Image in testMedia) {
                                                                Group {
                                                                    content: [
                                                                        Group {
                                                                            content: [
                                                                                ImageView {
                                                                                    image: i;
                                                                                    fitHeight: 40
                                                                                    fitWidth: 40
                                                                                    onMouseClicked: function (ev: MouseEvent) {
                                                                                        var sw: showingWindow = showingWindow {
                                                                                                    h: i.height;
                                                                                                    w: i.width;
                                                                                                    i: i;
                                                                                                };
                                                                                    }
                                                                                }
                                                                            ]
                                                                        }
                                                                    ]
                                                                }

                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                            if (check) {
                                                window.scene.content = [window.scene.content, group];
                                                check = false;
                                            }
                                        }
                                    }
                                    ImageView {
                                                                var im
                                               : Image = Image {url: "{__DIR__}Images/buttonMedia2.BMP"};
                                        image: bind im;
                                        visible: bind if (butVis) false else true;
                                        layoutX: bind window.width/2-27;
                                        layoutY: bind window.height-23;
                                        onMouseEntered: function (e)
                                        {
                                            im = Image {url: "{__DIR__}Images/buttonMediaEntered2.BMP"};
                                        }
                                        onMouseExited: function (e) {
                                            im = Image {url: "{__DIR__}Images/buttonMedia2.BMP"};
                                        }
                                        onMouseClicked: function (e) {
                                            panel = 0;
                                            butVis = true;
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                }

        return window
    }
}

