package Quicker;

import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;

/**
 * @author Илья
 */

 package def HEIGHT = 128;
 package def TOP = 100;
 package def MENU_BUTTON_HEIGHT = 40;
 package def hIndent: Integer = 350;
 package def ITEM_HEIGHT = 50;
 package def AREA_WIDTH = 180;
 package def VIEWER_WIDTH = 170;

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