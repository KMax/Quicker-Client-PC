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
package Quicker.views;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;

import Quicker.Controller;
import Quicker.Constants;

public class ContactsView extends View {
     override protected function create () : Node {
         var provider: Controller = Controller.getInstance();

         return VBox {
              spacing: 2
              content: [

//                  for (i:NoteListItem in provider.getContactList()) {
                       Group {
                          //    cache: true
                          content: [
                             Rectangle {
                                 height: Constants.ITEM_HEIGHT
                                 width: Constants.VIEWER_WIDTH
                                 smooth: false
                                 fill: Color.YELLOW
                             }
                             VBox {
                                 translateY: 3
                                 translateX: 5
                                 spacing: 0
                                 content: [
                                     Text {
                                         font: Font { size: 12 }
                                         content: "Contacts";
                                         wrappingWidth: Constants.VIEWER_WIDTH - 10
                                     }
                                     Text {
                                         font: Font {
                                             size: 10
                                         }
                                         content: "Contacts";
                                         textAlignment: TextAlignment.JUSTIFY
                                         fill: Color.GRAY
                                         wrappingWidth: Constants.VIEWER_WIDTH - 10
                                     }
                                         Text {
                                             font : Font { size: 10 }
                                             content: "Contacts";
                                             fill: Color.GREEN
                                             wrappingWidth: Constants.VIEWER_WIDTH - 10
                                         }
                                  ]
                               } // end VBox
                          ] // end group content
                      } // end droup
    //              } // end for
              ] // end content
          } // end VBox
     } // end create()
 } // end class