/***************************************************************************
 *
 *   Copyright 2010 Quicker Team
 *
 *   Quicker Team is:
 *   Kirdeev Andrey (kirduk@yandex.ru)
 *   Koritniy Ilya  (korizzz230@bk.ru)
 *   Kolchin Maxim  (kolchinmax@gmail.com)
 */
/****************************************************************************
 *
 *   This file is part of Quicker.
 *
 *   Quicker is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Quicker is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public License
 *   along with Quicker. If not, see <http://www.gnu.org/licenses/>
 *
 ****************************************************************************/
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
import Quicker.ScrollPane;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileFilter;
import javafx.scene.Node;
import Quicker.Controller;
import javafx.scene.effect.GaussianBlur;
import javafx.scene.effect.Glow;
import java.io.File;
import java.lang.Boolean;
import javafx.scene.text.Text;
import java.lang.Void;
import javafx.scene.control.TextBox;
import javafx.scene.text.Font;
import javafx.scene.Cursor;
import java.lang.StringBuilder;

public class NoteWindow {
    public var note: Note;
    var title: String = note.getTitle();
    var sp: ScrollPane;
    var window: Stage;
    var noteText: String = note.getText();
    def color: Color = bind Color.rgb(255, 120, 17);
    var panel: Integer = 0;
    protected var check: Boolean = true;
    protected var butVis: Boolean = true;
    protected var butVis2: Boolean = false;
    protected var group  ;
    var visPicker: Boolean = false;
    var t: TextArea;
    var colorPicker: ColorPicker;
    protected var testMedia = note.getImages();
    //setup for media content (showing)
    var hbx: Node[] = for (i in testMedia) {
                    ImageView {
                                var im: Image = Image {url: "{__DIR__}{i}"};
							    image: im;
							    fitHeight: 40
							    fitWidth: 40
							    onMousePressed: function (ev: MouseEvent) {
								//deleting image
								if (ev.secondaryButtonDown) {
								    if (javafx.stage.Alert.confirm("Warning", "You realy want delete it?")) {
									    delete ev.node
									    from hbx;
									    note.removeImage(i);
								    }
								    } else {
								    //fullscreen show
								    showingWindow {
									h: im.height;
									w: im.width;
									i: im;
								    };
								    }
								}
							}
                                             };

    var mainIm: Image = Image {url: "{__DIR__}Images/format.png"};
    var right: Image = Image {url: "{__DIR__}Images/right.PNG"};
    var left: Image = Image {url: "{__DIR__}Images/left.PNG"};
    var center: Image = Image {url: "{__DIR__}Images/center.PNG"};
    var alAll: Image = Image {url: "{__DIR__}Images/justify.png"};
    var bold: Image = Image {url: "{__DIR__}Images/Bold.PNG"};
    var I: Image = Image {url: "{__DIR__}Images/italic.png"};
    var under: Image = Image {url: "{__DIR__}Images/underlined.png"};
    var closeButton: Image = Image {url: "{__DIR__}Images/close.png"};
    var buttonBind: Image = Image {width: 19 height: 19 url: "{__DIR__}Images/stick_right.png"};
    var buttonDrag1: Image = Image {url: "{__DIR__}Images/Drag.PNG"};
    var buttonSave: Image = Image {url: "{__DIR__}Images/save.png"};
    var buttonMedia: Image = Image {url: "{__DIR__}Images/arrow2.png"};
    var buttonMedia2: Image = Image {url: "{__DIR__}Images/reversed.png"};
    var X: Float;
    var Y: Float;
    var ok_ef = Glow {level: .3}
    var close_ef = Glow {level: .3}
    var stick_ef = Glow {level: .3}
    var media_ef = Glow {level: .3}
    var te: TextBox;

    var button: Node = bind saveButtonArea;
    var saveButtonArea: Node = null;
    
    var changed: Boolean = false on replace {
        if (changed) saveButtonArea = Group {
				layoutX: 3;
				layoutY: bind window.height - 23;
                                content: [
                                    Rectangle {
                                        fill: Color.TRANSPARENT
                                        height: 20
                                        width: 20
                                    }
                                    ImageView {
                                        var im = buttonSave;
                                        image: bind im;
                                        effect: bind ok_ef
                                    }
                                ]
                                onMouseEntered: function(e){
                                    ok_ef.level = 1
				}
				onMouseExited: function(e){
                                    ok_ef.level = .3
				}
				onMouseClicked: function(e){
                                        var c = Controller.getInstance();
                                        //if not empty TextArea
					if(not t.getText().equals("")){
					    PrepareToSave();
					    note.setText(noteText);
					    note.setTitle(te.text);
					    java.lang.System.out.println(noteText);
					}else{
					    note.setText("your text");
					    note.setTitle("your title");
					}
					//if it is new note
					var saveResult: Boolean;
                                        var listener = SaveListener {
                                           override public function returnResult (res : Boolean) : Void {
                                               saveResult = res;
                                           }
                                        }
					var stask = SavingTask {
					    n: note
					    add: (note.getId() == 0)
                                            listener: listener;
					    onStart: function () {
						    java.lang.System.out.println("Started");
						java.lang.System.out.println("{saveButtonArea}");
						saveButtonArea = Text { fill: Color.RED font: Font{size:20} content: "AAAA!!! Saving..." }
						java.lang.System.out.println("{saveButtonArea}");
					    }
					    onDone: function () {
						    java.lang.System.out.println("Finished");
                                                changed = false;
                                                saveButtonArea = Text { content: "Saved..." }
						java.lang.System.out.println("{saveButtonArea}");
                                                
                                            }
                                        }
					stask.start();
                                }
                            } else saveButtonArea = Text {content: "qwetyuio"}
    }


   function PrepareToSave(): Void{
            var s:String = t.getText();
            var i1: Integer = s.indexOf("<body>");
            var i2: Integer = s.indexOf("</body>");
            var c1: Character[] = "<br>".toCharArray();
            var c2: Character[] = "&nbsp".toCharArray();
            var sTemp: Character[] = s.substring(i1+10, i2).toCharArray();
            var SB: StringBuilder  = new StringBuilder();
            var i: Integer = 0;
            var tu: Boolean= false;
            while(i < sizeof(sTemp)){
                    if(sTemp[i] == c1[0])
                            if(sTemp[i+1] == c1[1])
                               if (sTemp[i+2] == c1[2])
                                   if (sTemp[i+3] == c1[3]){
                                         SB.append("0x3");
                                         i+=4;
                                         tu = true;
                                       }
                    if(sTemp[i] == c2[0])
                                    if(sTemp[i+1] == c2[1])
                                         if(sTemp[i+2] == c2[2])
                                             if(sTemp[i+3] == c2[3])
                                                if(sTemp[i+4] == c2[4]){
                                                     SB.append(" ");
                                                     i+=5;
                                                     tu = true;
                                                }
                    if(tu){
                        tu=false;
                    }else{
                        SB.append(sTemp[i]);
                        i++;
                    }
       }
           noteText = SB.toString();
    };

    public function create(): Stage {
        //insert add button for media content
        insert ImageView {
            image: Image {url: "{__DIR__}Images/addBtn.png"};
            onMouseClicked: function (e) {
                try {
                    var jfc = new JFileChooser();
                    def extensions = [".jpg", ".PNG", ".png", ".JPEG"];  // TODO a lot of types
                    jfc.addChoosableFileFilter(
                    FileFilter {
                        override function getDescription() {
                            "Images {extensions.toString()}"
                        }
                        override function accept(file) {
                            if (file.isDirectory())
                                return true;
                            def name = file.getName().toLowerCase();
                            for (extension in extensions)
                                if (name.endsWith(extension))
                                    return true;
                            return false
                        }
                    });

                    //Copying file to temporary folder
                    jfc.showOpenDialog(null);
                    var dir = jfc.getSelectedFile().getAbsolutePath();
                    var src: FileInputStream = new FileInputStream(dir);
                    var f: File = new File("");
                    java.lang.System.out.println(f.getAbsolutePath());
                    var dest: FileOutputStream = new FileOutputStream("{f.getAbsolutePath()}/{jfc.getSelectedFile().getName()}");
                    var srcChannel: FileChannel = src.getChannel();
                    var destChannel: FileChannel = dest.getChannel();
                    srcChannel.transferTo(0, srcChannel.size(), destChannel);
                    java.lang.System.out.println(jfc.getSelectedFile().getName());
                    //adding image into node to sending on server
                    note.addImage("{f.getAbsolutePath()}/{jfc.getSelectedFile().getName()}");
                    //adding image for media content
                    insert ImageView {
                                var im: Image = Image {url: "file:///{ f.getAbsolutePath()}/{jfc.getSelectedFile().getName()}"};
							image: im;
							fitHeight: 40
							fitWidth: 40
							onMousePressed: function (ev: MouseEvent) {
							 //deleting image
                                                            if (ev.secondaryButtonDown) {
                                                                if (javafx.stage.Alert.confirm("Warning", "You realy want delete it?")) {
                                                                    delete ev.node
                                                                    from hbx;
                                                                    note.removeImage(jfc.getSelectedFile().getName());
                                                                }
                                                            } else {
                                                                showingWindow {
                                                                    h: im.height;
                                                                    w: im.width;
                                                                    i: im;
                                                                };
                                                            }
							}
							    }before hbx[1];
				    } catch (ex) {
					    java.lang.System.out.println(ex);
				    }
				}
			    } before hbx[0];
	java.lang.System.out.println(note.getText());

        window = Stage {
            title: title;
            style: StageStyle.TRANSPARENT;
            width: 300;
            height: 400;
            scene: Scene {
                fill: null
                content: [
                    Group {
			onMouseClicked: function (e: MouseEvent) {
			    changed = true
			}
                        content: bind [
				Rectangle{
                                        x:0;
                                        y:0;
                                        width: bind window.width;
                                        height: bind window.height;
                                        arcHeight:20
                                        arcWidth:20
                                        fill: color;
                                        },
                            te = TextBox {
                                        text: title;
                                        columns: 12;
                                        style: "border-width:-1;"
                                        font: Font{
                                                size: 12
                                                }
                                        layoutX:2;
                                        layoutY:24
                                        width: bind window.width-4;
                                        height: 20;

                                    }
                            t = TextArea {
                                        layoutX: 0
                                        layoutY: 54
					cursor: Cursor.TEXT
                                        width: bind window.width;
                                        height: bind window.height - 80 - panel;
                                        text: noteText;
                                         },
                            //Button for changing window size
                            ImageView {
                                var im: Image = Image{url: "{ __DIR__  }Images/Drag.PNG"};
                                image: bind im;
                                layoutX: bind  window.width - 11   ;
                                layoutY:bind window.height - 11;
                                var x1;
                                var y1;
                                onMouseDragged: function (e) {
                                    x1 = e.dragX;
                                    y1 = e.dragY;
                                }
                                onMouseReleased: function (e) {
                                    window.width = window.width + x1;
                                    window.height = window.height + y1;
                                }
                            },
                            //This node need's for drag the window
                            Rectangle {
                                layoutX: 30
                                layoutY: 0
                                width: bind window.width-60
                                height: 20
                                fill: bind color;
                                onMousePressed: function (event) {
                                    X = event.sceneX;
                                    Y = event.sceneY;
                                }
                                onMouseDragged: function (event) {
                                    window.x = event.screenX - X;
                                    window.y = event.screenY - Y;
                                }
                                blocksMouse: true
                            },
                            //Button for showing edit buttons (to modify text)
                            ImageView {
                                image: mainIm;
                                layoutX: 25
                                layoutY: 3
                                onMouseClicked: function (e) {
                                    butVis2 = not butVis2;
                                }
                            }
                            //Group with all editable buttons
                            Group {
                                visible: bind butVis2;
                                content: [
                                    //Alligment left
                                    ImageView {
                                        image: left;
                                        layoutX: 51
                                        layoutY: 3
                                        onMouseClicked: function (e) {
					    t.setAlig(0);
                                        };
                                    }
                                    //Alligment center
                                    ImageView {
                                        image: center;
                                        layoutX: 72
                                        layoutY: 3
                                        onMouseClicked: function (e) {
					    t.setAlig(1);
                                        };
                                    }
                                    //Alligment right
                                    ImageView {
                                        image: right;
                                        layoutX: 93
                                        layoutY: 3
                                        onMouseClicked: function (e) {
                                            t.setAlig(2);
                                        }
                                    }
                                    //Alligment *dont know its name:)*
                                    ImageView {
                                        image: alAll;
                                        layoutX: 114
                                        layoutY: 3
                                        onMouseClicked: function(e){
					    t.setAlig(3);
                                        }
                                    }
                                    //Italic
                                    ImageView {
                                        image: I;
                                        layoutX: 135
                                        layoutY: 3
                                        onMouseClicked: function(e){
                                            t.makeItalic();
                                        }
                                    }
                                    //Bold
                                    ImageView {
                                        image: bold;
                                        layoutX: 156
                                        layoutY: 3
                                        onMouseClicked: function(e){
					    t.makeBold();
                                        }
                                    }
                                    //Underlined
                                    ImageView {
                                        image: under;
                                        layoutX: 177
                                        layoutY: 3
                                        onMouseClicked: function (e) {
					    t.makeUnderlined();
                                        }
                                    }
                                    // Color shower
                                    Rectangle {
                                        layoutX: 198
                                        layoutY: 3
                                        width: 20
                                        height: 20
                                        fill: bind if (colorPicker.previewColor != null)
							colorPicker.previewColor else colorPicker.color
                                        stroke: Color.web("#BBBBBB");
                                        onMouseClicked: function (e) {
                                            t.setColor(if (colorPicker.c2 != null)
							colorPicker.c2 else java.awt.Color.RED);
                                        }
                                    }
                                    //Button for choose color
                                    Rectangle {
                                        fill: Color.BLACK;
                                        layoutX: 219
                                        layoutY: 3
                                        width: 5
                                        height: 20
                                        onMouseClicked: function(e){
					    visPicker = true;
                                        }
                                    }
                                    //Color picker
                                    Group {
                                        visible: bind visPicker;
                                        layoutX: 224
                                        layoutY: 3
                                        content: [
                                            colorPicker = ColorPicker {
                                                width: 50
                                                height: 180
                                                onMouseClicked: function (e) {
                                                    visPicker = false;
                                                }
                                            }
                                        ]
                                    }
                                ]
                            },
                            //Close button
                            ImageView {
				    var im = closeButton;
				    image: bind im;
				    layoutX: bind window.width - 23;
				    layoutY: 3;
                                    effect: close_ef
				    onMouseEntered: function (e) {
					close_ef.level = 1
				    }
				    onMouseExited: function (e) {
					close_ef.level = .3
				    }
				    onMouseClicked: function (e) {
					window.close();
				    }
                            },
                            //This button bind the current window to your desktop
                            //Dont working now
                            ImageView {
				    var im = buttonBind;
				    image: bind im;
				    layoutX: 3;
				    layoutY: 3;
                                    effect: stick_ef
				    onMouseEntered: function (e) {
					stick_ef.level = 1
				    }
				    onMouseExited: function (e) {
					stick_ef.level = .3
				    }
				    onMouseClicked: function (e) {
				    }
                            }
                            //Button Drag
                            ImageView {
                                        var im = buttonDrag1;
					image: bind im;
					layoutX: bind window.width - 11;
					layoutY: bind window.height - 11;
                                        var x1;
                                        var y1;
                                        onMouseDragged: function(e){
                                                x1 = e.dragX;
                                                y1 = e.dragY;
                                        }
					onMouseReleased: function(e){
						window.width= window.width+x1;
						window.height = window.height+y1;
					}
                            },
                            //Button Save
                            button,
                            //Button for opening media content
			    Group {
				content: [
				    Rectangle { width: 45 height: 12 fill: Color.TRANSPARENT }
				    ImageView {
					var im = buttonMedia;
					image: bind  im;
					visible: bind butVis;
				    }
				]
				layoutX: bind window.width / 2  -27;
				layoutY: bind window.height - 23;
				effect:  media_ef
                                onMouseEntered: function (e) {
                                    media_ef.level = 1
                                }
                                onMouseExited: function (e) {
                                    media_ef.level = .3
                                }
                                onMouseClicked: function (e: MouseEvent) {
					//needs upping TextArea
					panel = 64;
					//And make media visible
					butVis = false;
					//if this is first click, we must create media panel
					if (check) {
					group = Group {
					    visible: bind not butVis;
					    content: [
						//Background for media content
						Rectangle {
						    layoutY: bind window.height - 87;
						    height: 60;
						    width: bind window.width;
						    fill: Color.rgb(245, 180, 50);
						    effect: GaussianBlur{ radius: 20 }//
						}
						//SrollPane
						sp = ScrollPane {
						    horizontal: true;
						    layoutX: 3;
						    layoutY: bind window.height - 84;
						    height: 55;
						    visible: true;
						    width: bind window.width - 20;
						    content: bind  HBox {
							spacing: 10
							height: 70
							content: bind hbx
							width: bind (sizeof(hbx)*50-39);
							    };
						       }
						    ]
						}
						insert group into window.scene.content;
						check = false;
						}
					    }
			    }

                            ,
                            //Button for closing media
                            ImageView {
				    var im = buttonMedia2;
				    image: bind im;
				    visible: bind (not butVis);
				    layoutX: bind window.width / 2 - 27;
				    layoutY: bind window.height - 23;
                                    effect: media_ef
				    onMouseEntered: function (e) {
					media_ef.level = 1
				    }
				    onMouseExited: function (e) {
					media_ef.level = .3
				    }
				    onMouseClicked: function (e) {
					panel = 0;
					butVis = true;
				    }
                            }
                        ];
                    }
                ]
            }
        }
        return window
    }
}

