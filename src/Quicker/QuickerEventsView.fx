package Quicker;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;

/**
 * @author Илья
 */

public class QuickerEventsView extends CustomNode {
     override protected function create () : Node {
         var provider: Controller = Controller.getInstance();

         return VBox {
              spacing: 2
              content: [

       //           for (i:NoteListItem in provider.getEventList()) {
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
                                         content: "Event";
                                         wrappingWidth: Constants.VIEWER_WIDTH - 10
                                     }
                                     Text {
                                         font: Font {
                                             size: 10
                                         }
                                         content: "Event";
                                         textAlignment: TextAlignment.JUSTIFY
                                         fill: Color.GRAY
                                         wrappingWidth: Constants.VIEWER_WIDTH - 10
                                     }
                                         Text {
                                             font : Font { size: 10 }
                                             content: "Event";
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
