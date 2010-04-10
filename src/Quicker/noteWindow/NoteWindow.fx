package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import Quicker.noteWindow.TextArea;
import javafx.stage.StageStyle;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.layout.HBox;
import Quicker.noteWindow.showingWindow;
import javafx.scene.input.MouseEvent;
import javafx.scene.shape.Rectangle;
import Quicker.Note;

public class NoteWindow {
    public var note:Note;
    var title: String = note.getTitle();
    var noteText: String = note.getText();
    def color: Color = Color.YELLOW;
    var panel: Integer = 0;
    protected var check: Boolean = true;
    protected var butVis: Boolean = true;
    protected var butVis2: Boolean = false;
    protected var group  ;
    var visPicker: Boolean = false;
    var t: TextArea;
    var colorPicker: ColorPicker;
    protected var testMedia =  [ for (i in note.getPhoto()) {
		java.lang.System.out.println(i);
		Image { url: "{__DIR__}{i}"}
		}
	    ];
    var mainIm: Image = Image { url: "{__DIR__}Images/mainB.PNG" };
    var right: Image = Image { url: "{__DIR__}Images/right.PNG" };
    var left: Image = Image { url: "{__DIR__}Images/left.PNG" };
    var center: Image = Image { url: "{__DIR__}Images/center.PNG" };
    var alAll: Image = Image { url: "{__DIR__}Images/alligmAll.PNG" };
    var bold: Image = Image { url: "{__DIR__}Images/Bold.PNG" };
    var I: Image = Image { url: "{__DIR__}Images/I.PNG" };
    var under: Image = Image { url: "{__DIR__}Images/Underline.PNG" };
    var X: Float;
    var Y: Float;

    public function create(): Stage {
	var window: Stage = Stage {
		    title: title;
		    style: StageStyle.UNDECORATED
		    width: 300;
		    height: 400;
		    scene: Scene {
			fill: color
			content: [
			    Group {
				content: [
				    t = TextArea {
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

					onMousePressed: function (event) {
					    X = event.sceneX;
					    Y = event.sceneY;
					}
					onMouseDragged: function (event) {
					    window.x = event.screenX-X;
					    window.y = event.screenY-Y;
					}
                                        blocksMouse: true
				    }
				    ImageView {
					image: mainIm;
					layoutX: 25
					layoutY: 3
					onMouseClicked: function (e) {
					    butVis2 = not butVis2;
					}
				    }
				    Group {
					visible: bind butVis2;
					content: [
					    ImageView {
						image: left;
						layoutX: 51
						layoutY: 3
						onMouseClicked: function (e) {
						    t.setAlig(0);

						}
					    }
					    ImageView {
						image: center;
						layoutX: 72
						layoutY: 3
						onMouseClicked: function (e) {
						    t.setAlig(1);

						}
					    }
					    ImageView {
						image: right;
						layoutX: 93
						layoutY: 3
						onMouseClicked: function (e) {
						    t.setAlig(2);

						}
					    }
					    ImageView {
						image: alAll;
						layoutX: 114
						layoutY: 3
						onMouseClicked: function (e) {
						    t.setAlig(3);

						}
					    }
					    ImageView {
						image: I;
						layoutX: 135
						layoutY: 3
						onMouseClicked: function (e) {
						    t.makeItalic();
						}
					    }
					    ImageView {
						image: bold;
						layoutX: 156
						layoutY: 3
						onMouseClicked: function (e) {
						    t.makeBold();
						}
					    }
					    ImageView {
						image: under;
						layoutX: 177
						layoutY: 3
						onMouseClicked: function (e) {
						    t.makeUnderlined();
						}
					    }
					    Rectangle {
						layoutX: 198
						layoutY: 3
						width: 20
						height: 20
						fill: bind if (colorPicker.previewColor != null) colorPicker.previewColor else colorPicker.color
						stroke: Color.web("#BBBBBB");
						onMouseClicked: function (event) {
						    t.setColor(colorPicker.c2);
						}
					    }
					    Rectangle {
						fill: Color.BLACK;
						layoutX: 219
						layoutY: 3
						width: 5
						height: 20
						onMouseClicked: function (e) {
						    visPicker = true;
						}
					    }
					    Group {
						visible: bind visPicker;
						layoutX: 224
						layoutY: 3
						content: [
						    colorPicker = ColorPicker {
							width: 30
							height: 180
							onMouseClicked: function (e) {
							    visPicker = false;
							}
						    }
						]
					    }
					]
				    }
				    ImageView {
					var im: Image = Image { url: "{__DIR__}Images/closebutton.JPG" };
					image: bind im;
					layoutX: bind window.width - 23;
					layoutY: 3;
					onMouseEntered: function (e) {
					    im = Image { url: "{__DIR__}Images/buttoncloseEntered.JPG" };
					}
					onMouseExited: function (e) {
					    im = Image { url: "{__DIR__}Images/closebutton.JPG" };
					}
					onMouseClicked: function (e) {
					    window.close();
					}
				    }
				    ImageView {
					var im: Image = Image { url: "{__DIR__}Images/buttonBind.bmp" };
					image: bind im;
					layoutX: 3;
					layoutY: 3;
					onMouseEntered: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonBind2.bmp" };
					}
					onMouseExited: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonBind.bmp" };
					}
					onMouseClicked: function (e) {
					    java.lang.System.out.println(t.getText());
					}
				    }
				    ImageView {
					var im: Image = Image { url: "{__DIR__}Images/buttonSave.bmp" };
					image: bind im;
					layoutX: 3;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonSave2.bmp" };
					}
					onMouseExited: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonSave.bmp" };
					}
				    }
				    ImageView {
					var im: Image = Image { url: "{__DIR__}Images/buttonMedia.bmp" };
					image: bind im;
					visible: bind butVis;
					layoutX: bind window.width / 2 - 27;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonMediaEntered.bmp" };
					}
					onMouseExited: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonMedia.bmp" };
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
											showingWindow {
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
					var im: Image = Image { url: "{__DIR__}Images/buttonMedia2.BMP" };
					image: bind im;
					visible: bind if (butVis) false else true;
					layoutX: bind window.width / 2 - 27;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonMediaEntered2.BMP" };
					}
					onMouseExited: function (e) {
					    im = Image { url: "{__DIR__}Images/buttonMedia2.BMP" };
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

