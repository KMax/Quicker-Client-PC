/***************************************************************************
*
*	Copyright 2010 Quicker Team
*
*	Quicker Team is:
*		Kirdeev Andrey (kirduk@yandex.ru)
* 	Koritniy Ilya (korizzz230@bk.ru)
* 	Kolchin Maxim	(kolchinmax@gmail.com)
*/
/****************************************************************************
*
*	This file is part of Quicker.
*
*	Quicker is free software: you can redistribute it and/or modify
*	it under the terms of the GNU Lesser General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	Quicker is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*	GNU Lesser General Public License for more details.
*
*	You should have received a copy of the GNU Lesser General Public License
*	along with Quicker. If not, see <http://www.gnu.org/licenses/>


****************************************************************************/
package Quicker;

import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.image.Image;


 public def HEIGHT = 98;
 public def TOP = 150;
 public def MENU_BUTTON_HEIGHT = 30;
 public def hIndent: Integer = 350;
 public def ITEM_HEIGHT = 60;
 public def AREA_WIDTH = 160;
 public def VIEWER_WIDTH = 150;
 public def MENU_BUTTON_WIDTH = 180;
 
 public def AUDIO = Image {
         url: "{__DIR__}audio.png"
         }
 public def VIDEO = Image {
         url: "{__DIR__}video.png"
         }
 public def IMAGE = Image {
         url: "{__DIR__}image.png"
         }
 public def ADD_BUTTON = Image {
         url: "{__DIR__}views/add.png"
         height:16
         width:16
 }
  public def REMOVE_BUTTON = Image {
         url: "{__DIR__}views/remove.png"
 }



 public def BUTTON_COLOR = LinearGradient {
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

 public def GRADIENT = LinearGradient {
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