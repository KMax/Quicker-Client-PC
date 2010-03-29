/*
 * Main.fx
 *
 * Created on 25.03.2010, 10:57:08
 */
package Quicker.notesWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.*;
import java.io.File;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.stage.StageStyle;
import java.lang.System;
import javafx.scene.shape.Rectangle;
import javafx.scene.control.Slider;
import java.awt.Color;
import javafx.scene.Group;

/**
 * @author kirduk
 */
//var awtFont = java.awt.Font.createFont(java.awt.Font.TRUETYPE_FONT, new File("C://RAGE.TTF"));
var image = Image { url: "{__DIR__}background1.jpg" };
def ibe1 = Image { url: "{__DIR__}ibe1.png" };
def cb1 = Image { url: "{__DIR__}cb1.png" };
def mb1 = Image { url: "{__DIR__}mb1.png" };
def db1 = Image { url: "{__DIR__}db1.png" };
var X: Float;
var Y: Float;
X = 100;
Y = 100;

//awtFont = awtFont.deriveFont(22.0);

//def fxFont = com.sun.javafx.tk.Toolkit.getToolkit().getFontLoader().font(awtFont);
var v = ImageView { image: bind image };
def editButton = ImageView {
            x: 343
            y: 416
            image: ibe1;
            onMouseClicked: function (event) { 
               }
        }
def closeButton = ImageView {
            x: 352
            y: 5
            image: cb1;
            onMouseClicked: function (event) {

                System.exit(0);
            }
        }
def minimazeButton = ImageView {
            x: 327
            y: 5
            image: mb1;
            onMouseClicked: function (event) {
                //Сворачивание
            }
        }
def drag = ImageView {
            x: 0, y: 0
            image: db1;
            onMouseDragged: function (event) {
                X = X + event.dragX;
                Y = Y + event.dragY;
                }
        }

Stage {
    title: "Имя _заметки"
    style: StageStyle.UNDECORATED
    x: bind X;
    y: bind Y;
    width: 378;
    height: 451;
    scene: Scene {             
        content: [
                v,
                editButton,
                closeButton,
                minimazeButton,
                drag,
                Text {
                    x: 60
                    y: 65
                    //font: fxFont
                    textAlignment: TextAlignment.LEFT
                    wrappingWidth: 300
                    content: "lot of text!"
                }
            ]
    }
}

