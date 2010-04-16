/*
 * Main.fx
 */

package Quicker;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;

import Quicker.Constants;
import Quicker.views.ContactsView;
import Quicker.views.NotesView;
import Quicker.views.EventsView;

/**
 * @author Илья
 */

var notes = MenuButton {
    text: "Заметки"
    id: "notes"
    viewer: NotesView { visible:false }
}
var events = MenuButton {
    text: "События"
    id: "events"
    viewer: EventsView { visible:false }
}
var contacts = MenuButton {
    text: "Контакты"
    id: "contacts"
    viewer: ContactsView { visible:false }
}

var menu: QuickerMenu = QuickerMenu {
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