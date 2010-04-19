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

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;

/**
* Menu with popups
*/
 public class Menu extends CustomNode {
    public var items: MenuButton[];
    public var spacing: Number;

    /**
    *  places the item to the menu top
    */
    function onTop(it: MenuButton) {
        delete it from items;
        insert it before items[0];
    }

    public override function create(): Node {
        return VBox {
                spacing: spacing
                content: bind items

                // defines what type of animation to use: to effect window size or not
                var changeHeight: Boolean = true;
                onMouseClicked: function (e: MouseEvent): Void {

                        // if click is not on menu item, return
                        if (not(e.source.parent.parent.getClass().equals(items[0].getClass()))) return;
                        var chosen:MenuButton = e.source.parent.parent as MenuButton;

                        // choosing the right way to expand/hide menu items
                        for (item in items) {
                            if ( not item.equals(chosen) ) {
                                if (item.expanded) {
                                    item.colapseEx();
                                    item.viewer.visible = false;
                                }
                            } else {
                                if (not item.expanded) {
                                    if (changeHeight) {
                                        item.expand();
                                        changeHeight = false;
                                    } else {
                                        item.expandEx();
                                        changeHeight = false;
                                    }
                                    item.viewer.visible = true;
                                } else {
                                    item.colapse();
                                    changeHeight = true;
                                    item.viewer.visible = false;
                                }
                            }
                        } // end for
                    //    onTop(chosen);
                }
            };
        }
}
