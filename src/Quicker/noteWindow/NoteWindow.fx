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
import java.lang.StringBuilder;
import java.lang.Character;
import javafx.scene.effect.GaussianBlur;

public class NoteWindow {




    var path: String = "C:/";   // PATH TO TEMPORARY FILES





    public var note: Note;
    var title: String = note.getTitle();
    var sp: ScrollPane;
    var window: Stage;
    var noteText: String = "<i><b>{title}</b></i><br><br>{note.getText()}";
    def color: Color = Color.YELLOW;
    var panel: Integer = 0;
    protected var check: Boolean = true;
    protected var butVis: Boolean = true;
    protected var butVis2: Boolean = false;
    protected var group ;
    var visPicker: Boolean = false;
    var t: TextArea;
    var colorPicker: ColorPicker;
    protected var testMedia = [
                               for (i in note.getImages()) {
                                   i
                                }
            ];


            //setup for media content (showing)
            var hbx:Node[] =  for (i in testMedia) {
                                                                    ImageView {
                                                                                var im: Image= Image{url:"{__DIR__}{i}"};
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
                                                                    }

    var mainIm: Image = Image {url: "{__DIR__}Images/mainB.PNG"};
    var right: Image = Image {url: "{__DIR__}Images/right.PNG"};
    var left: Image = Image {url: "{__DIR__}Images/left.PNG"};
    var center: Image = Image {url: "{__DIR__}Images/center.PNG"};
    var alAll: Image = Image {url: "{__DIR__}Images/alligmAll.PNG"};
    var bold: Image = Image {url: "{__DIR__}Images/Bold.PNG"};
    var I: Image = Image {url: "{__DIR__}Images/I.PNG"};
    var under: Image = Image {url: "{__DIR__}Images/Underline.PNG"};
    var closeButton: Image = Image { url: "{__DIR__}Images/closebutton.JPG" };
    var closeButtonEntered: Image = Image { url: "{__DIR__}Images/buttoncloseEntered.JPG"};
    var buttonBind: Image = Image { url: "{__DIR__}Images/buttonBind.bmp" };
    var buttonBindEntered: Image = Image { url: "{__DIR__}Images/buttonBind2.bmp"};
    var buttonDrag1: Image = Image{url: "{__DIR__}Images/Drag.PNG"};
    var buttonSave: Image = Image { url: "{__DIR__}Images/buttonSave.bmp" };
    var buttonSaveEntered: Image = Image { url: "{__DIR__}Images/buttonSave2.bmp"};
    var buttonMedia: Image = Image { url: "{__DIR__}Images/buttonMedia.bmp" };
    var buttonMediaEntered: Image = Image { url: "{__DIR__}Images/buttonMediaEntered.bmp"};
    var buttonMedia2: Image = Image { url: "{__DIR__}Images/buttonMedia2.BMP" };
    var buttonMediaEntered2: Image = Image { url: "{__DIR__}Images/buttonMediaEntered2.BMP"};
    var X: Float;
    var Y: Float;

    function getTitle(): Void{
            var s: Character[] = t.getText().toCharArray();
            var i = 0;
            var pattern:Character[] = "<br>".toCharArray();
            var SB: StringBuilder = new StringBuilder();
            while(i < sizeof(s))
            {
                    if (s[i] != pattern[0]){
                            SB.append(s[i]);
                            i++;
                            }else{
                                    try{
                                    if (s[i+1]==pattern[1] and s[i+2]==pattern[2] and s[i+3]==pattern[3]){
                                            title = SB.toString();
                                            SB = new StringBuilder();
                                            while (i < sizeof(s)){
                                            SB.append(s[i]);
                                            i++;}
                                            noteText = SB.toString();
                                            return;
                                            }else{
                                                    SB.append(s[i]);
                                                    i++;
                                                    }
                                    }catch(ex){
                                            title = SB.toString();
                                            SB = new StringBuilder();
                                            while (i < sizeof(s)){
                                            SB.append(s[i]);
                                            i++;}
                                            noteText = SB.toString();
                                            return;
                                            }
                                    }
            }
            }

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
                                                        var dest: FileOutputStream = new FileOutputStream( "{path}{jfc.getSelectedFile().getName()}" );
                                                        var srcChannel: FileChannel = src.getChannel();
                                                        var destChannel: FileChannel = dest.getChannel();
                                                        srcChannel.transferTo(0, srcChannel.size(), destChannel);
                                                        java.lang.System.out.println(jfc.getSelectedFile().getName());
                                                        //adding image into node to sending on server
                                                        note.addImage(jfc.getSelectedFile().getName());
                                                        //adding image for media content
                                                        insert ImageView {
                                                                                var im: Image= Image{url: "file:///{path}{jfc.getSelectedFile().getName()}"};
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

        window = Stage {
            title: title;
            style: StageStyle.UNDECORATED
            width: 300;
            height: 400;
            scene: Scene {
                fill: color
                content: [
                    Group {
                        content: [
                            //TextArea
                            t = TextArea {
                                layoutX: 0
                                layoutY: 24
                                width: bind window.width;
                                height: bind window.height - 50 - panel;
                                text: noteText;
                            }
                            //Button for changing window size
                            ImageView {
                                        var im:  Image = Image {url: "{__DIR__}Images/Drag.PNG"};
					image: bind im;
					layoutX: bind window.width - 11;
					layoutY: bind window.height - 11;
                                        var x1;
                                        var y1;
                                        onMouseDragged: function(e){
                                                x1 = e.dragX;
                                                y1 = e.dragY;
                                                }
                                                onMouseReleased: function(e)
                                                {
                                                        window.width= window.width+x1;
                                                        window.height = window.height+y1;
                                                        }
                                    }
                            //This node need's for drag the window
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
                                    window.x = event.screenX - X;
                                    window.y = event.screenY - Y;
                                }
                                blocksMouse: true
                            }
                            //Button for showing editable buttons (modify text)
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
                                        }
                                    }
                                    //Alligment center
                                    ImageView {
                                        image: center;
                                        layoutX: 72
                                        layoutY: 3
                                        onMouseClicked: function (e) {
                                            t.setAlig(1);
                                        }
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
                                        onMouseClicked: function (e) {
                                            t.setAlig(3);
                                        }
                                    }
                                    //Italic
                                    ImageView {
                                        image: I;
                                        layoutX: 135
                                        layoutY: 3
                                        onMouseClicked: function (e) {
                                            t.makeItalic();
                                        }
                                    }
                                    //Bold
                                    ImageView {
                                        image: bold;
                                        layoutX: 156
                                        layoutY: 3
                                        onMouseClicked: function (e) {
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
                                        fill: bind if (colorPicker.previewColor != null) colorPicker.previewColor else colorPicker.color
                                        stroke: Color.web("#BBBBBB");
                                        onMouseClicked: function (e) {
                                            t.setColor(if (colorPicker.c2 != null) colorPicker.c2 else java.awt.Color.RED);
                                        }
                                    }
                                    //Button for choose color
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
                                    //Color picker
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
                            //Close button
                            ImageView {
                                        var im = closeButton;
					image: bind im;
					layoutX: bind window.width - 23;
					layoutY: 3;
					onMouseEntered: function (e) {
					    im = closeButtonEntered;
                                }
                                onMouseExited: function (e) {
                                    im = closeButton;
                                }
                                onMouseClicked: function (e) {
                                    window.close();
                                }
                            }
                            //This button bind the current window to your desktop
                            //Dont working now
                            ImageView {
                                        var im = buttonBind;
					image: bind im;
					layoutX: 3;
					layoutY: 3;
					onMouseEntered: function (e) {
					    im = buttonBindEntered;
                                }
                                onMouseExited: function (e) {
                                    im = buttonBind;
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
                                                onMouseReleased: function(e)
                                                {
                                                        window.width= window.width+x1;
                                                        window.height = window.height+y1;
                                                        }
                                    }
                            //Button Save
                            ImageView {
                                        var im = buttonSave;
					image: bind im;
					layoutX: 3;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = buttonSaveEntered;
                                }
                                onMouseExited: function (e) {
                                    im = buttonSave;
                                }
                                onMouseClicked: function (e) {
                                    var c = Controller.getInstance();
                                    //if not empty TextArea
                                    if(t.getText() != ""){
                                    getTitle();                                    
                                    note.setText(noteText);
                                    note.setTitle(title);
                                    }else{
                                            note.setText("");
                                            note.setTitle("");
                                    }
                                    //if it is new note
                                    if(note.getId() == 0)
                                    c.saveNewNote(note)
                                    else
                                    c.saveNote(note);
                                    java.lang.System.out.println(title);
                                    java.lang.System.out.println(noteText);
                                }
                            }
                            //Button for opening media content
                            ImageView {
                                        var im = buttonMedia;
					image: bind im;
					visible: bind butVis;
					layoutX: bind window.width / 2 - 27;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = buttonMediaEntered;
                                }
                                onMouseExited: function (e) {
                                    im = buttonMedia;
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
                                                fill: Color.ORANGE;
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
                                    //Button for closing media
                                    ImageView {
                                        var im = buttonMedia2;
					image: bind im;
					visible: bind if (butVis) false else true;
					layoutX: bind window.width / 2 - 27;
					layoutY: bind window.height - 23;
					onMouseEntered: function (e) {
					    im = buttonMediaEntered2;
                                }
                                onMouseExited: function (e) {
                                    im = buttonMedia2;
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

