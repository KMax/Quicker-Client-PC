package Quicker;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;

/**
* Menu with popups
* @author Илья
*/
 public class QuickerMenu extends CustomNode {
    public var items: QuickerMenuButton[];
    public var spacing: Number;

    /**
    *  places the item to the menu top
    */
    function onTop(it: QuickerMenuButton) {
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
                        var chosen:QuickerMenuButton = e.source.parent.parent as QuickerMenuButton;

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
