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

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;

import Quicker.Constants;
import Quicker.views.ContactsView;
import Quicker.views.NotesView;
import Quicker.views.EventsView;


var notes = MenuButton {
    text: "Notes"
    id: "notes"
    viewer: NotesView { visible:false }
}
var events = MenuButton {
    text: "Events"
    id: "events"
    viewer: EventsView { visible:false }
}
var contacts = MenuButton {
    text: "Contacts"
    id: "contacts"
    viewer: ContactsView { visible:false }
}

var menu: Menu = Menu {
    items: [notes, events, contacts]
    spacing: 0
}

Stage {
    title: "Quicker"
    x: 750
    y: Constants.TOP//bind QuickerMenuButton.top
    width: Constants.MENU_BUTTON_WIDTH + 4
    height: bind MenuButton.wHeight
    style: StageStyle.TRANSPARENT
    scene: Scene {
     fill : null
        content: menu
    }
}