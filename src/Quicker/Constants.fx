package Quicker;

import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.image.Image;

/**
 * @author Илья
 */

 package def HEIGHT = 98;
 package def TOP = 100;
 package def MENU_BUTTON_HEIGHT = 30;
 package def hIndent: Integer = 350;
 package def ITEM_HEIGHT = 50;
 package def AREA_WIDTH = 160;
 package def VIEWER_WIDTH = 150;
 package def MENU_BUTTON_WIDTH = 180;
 
 package def AUDIO = Image {
         url: "{__DIR__}audio.png"                            
         }
 package def VIDEO = Image {
         url: "{__DIR__}video.png"
         }
 package def IMAGE = Image {
         url: "{__DIR__}image.png"
         }

 package def BUTTON_COLOR = LinearGradient {
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

 package def GRADIENT = LinearGradient {
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