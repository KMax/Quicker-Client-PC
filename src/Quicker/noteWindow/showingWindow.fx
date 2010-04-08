/*
 * showingWindow.fx
 *
 * Created on 07.04.2010, 22:54:05
 */
package Quicker.noteWindow;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.stage.StageStyle;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;

/**
 * @author Kirduk's
 */
public class showingWindow {

    public var w: Float;
    public var h: Float;
    public var i: Image;
    var stage: Stage = Stage {
                style: StageStyle.UNDECORATED
                width: w;
                height: h;
                scene: Scene {
                    fill: null;
                    content: ImageView {
                        image: i;
                        onMouseClicked: function (e) {
                            stage.close();
                        }
                    }
                }
            }

    function create() {
        return stage
    }
}
