/*
 * Main.fx
 */

package Quicker;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;

import Quicker.Constants;

/**
 * @author Илья
 */

var notes = QuickerMenuButton {
    text: "Заметки"
    id: "notes"
    viewer: QuickerNotesView { visible:false }
}
var events = QuickerMenuButton {
    text: "События"
    id: "events"
    viewer: QuickerEventsView { visible:false }
}
var contacts = QuickerMenuButton {
    text: "Контакты"
    id: "contacts"
    viewer: QuickerContactsView { visible:false }
}

var menu: QuickerMenu = QuickerMenu {
    items: [notes, events, contacts]
}

Stage {
    title: "Quicker"
    x: 750
    y: Constants.TOP//bind QuickerMenuButton.top
    width: 204
    height: bind QuickerMenuButton.wHeight
    //  style: StageStyle.UNDECORATED
    style: StageStyle.TRANSPARENT
    scene: Scene {
     //   fill: Color.YELLOW
     fill : null
        content: menu
    }
}