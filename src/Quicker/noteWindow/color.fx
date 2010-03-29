package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.input.MouseEvent;

/**
 * @author code-better.com
 */

def colors = [
    "ALICEBLUE", "ANTIQUEWHITE", "AQUA", "AQUAMARINE", "AZURE", "BEIGE",
    "BISQUE", "BLACK", "BLANCHEDALMOND", "BLUE", "BLUEVIOLET", "BROWN",
    "BURLYWOOD", "CADETBLUE", "CHARTREUSE", "CHOCOLATE", "CORAL",
    "CORNFLOWERBLUE", "CORNSILK", "CRIMSON", "CYAN", "DARKBLUE", "DARKCYAN",
    "DARKGOLDENROD", "DARKGREEN", "DARKGREY", "DARKKHAKI",
    "DARKMAGENTA","DARKOLIVEGREEN", "DARKORANGE", "DARKORCHID", "DARKRED",
    "DARKSALMON", "DARKSEAGREEN", "DARKSLATEBLUE",
    "DARKSLATEGREY", "DARKTURQUOISE", "DARKVIOLET", "DEEPPINK", "DEEPSKYBLUE",
    "DIMGREY", "DODGERBLUE", "FIREBRICK", "FLORALWHITE",
    "FORESTGREEN", "FUCHSIA", "GAINSBORO", "GHOSTWHITE", "GOLD", "GOLDENROD",
    "GREEN", "GREENYELLOW", "GREY", "HONEYDEW", "HOTPINK", "INDIANRED",
    "INDIGO", "IVORY", "KHAKI", "LAVENDER", "LAVENDERBLUSH", "LAWNGREEN",
    "LEMONCHIFFON", "LIGHTBLUE", "LIGHTCORAL", "LIGHTCYAN",
    "LIGHTGOLDENRODYELLOW", "LIGHTGREEN", "LIGHTGREY", "LIGHTPINK",
    "LIGHTSALMON", "LIGHTSEAGREEN", "LIGHTSKYBLUE",
    "LIGHTSLATEGREY", "LIGHTSTEELBLUE", "LIGHTYELLOW", "LIME", "LIMEGREEN",
    "LINEN", "MAGENTA", "MAROON", "MEDIUMAQUAMARINE", "MEDIUMBLUE",
    "MEDIUMORCHID", "MEDIUMPURPLE", "MEDIUMSEAGREEN", "MEDIUMSLATEBLUE",
    "MEDIUMSPRINGGREEN", "MEDIUMTURQUOISE", "MEDIUMVIOLETRED", "MIDNIGHTBLUE",
    "MINTCREAM", "MISTYROSE", "MOCCASIN", "NAVAJOWHITE", "NAVY", "OLDLACE",
    "OLIVE", "OLIVEDRAB", "ORANGE", "ORANGERED", "ORCHID", "PALEGOLDENROD",
    "PALEGREEN", "PALETURQUOISE", "PALEVIOLETRED", "PAPAYAWHIP", "PEACHPUFF",
    "PERU", "PINK", "PLUM", "POWDERBLUE", "PURPLE", "RED", "ROSYBROWN",
    "ROYALBLUE", "SADDLEBROWN", "SALMON", "SANDYBROWN", "SEAGREEN", "SEASHELL",
    "SIENNA", "SILVER", "SKYBLUE", "SLATEBLUE", "SLATEGREY",
    "SNOW", "SPRINGGREEN", "STEELBLUE", "TAN", "TEAL", "THISTLE", "TOMATO",
    "TURQUOISE", "VIOLET", "WHEAT", "WHITE", "WHITESMOKE", "YELLOW",
    "YELLOWGREEN" ];
    // removed duplicate spellings of grey/gray

var backColor = "WHITE";


Stage {
    title: "Color Constants"
    scene: Scene {
        width: 600
        height: 700
        content: [
            Rectangle {
                width:600  height:700
                fill: bind Color.web(backColor)
            }

            Text {
                x: 40  y: 650
                content: bind backColor
                fill: bind if (backColor=="BLACK") then Color.WHITE else Color.BLACK
            }
            for(color in colors){
                Rectangle{
                    fill: Color.web(color)
                    x: (indexof color mod 12) * 50
                    y: (indexof color / 12) * 50
                    width: 50
                    height: 50
                    onMousePressed: function(me:MouseEvent){
                        backColor=color;
                    }
                }
            }
        ]
    }
}