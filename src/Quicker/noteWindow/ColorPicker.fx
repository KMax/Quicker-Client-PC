/*
 * ColorPicker.fx
 *
 * Created on 09.04.2010, 21:46:26
 */

package Quicker.noteWindow;

/**
 * @author Kirduk's
 */

import java.awt.image.BufferedImage;
import javafx.ext.swing.SwingUtils;
import javafx.scene.CustomNode;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;



/**
 * @author jp202575
 */

public class ColorPicker extends CustomNode{

    var img:BufferedImage;
    public var c2: java.awt.Color;
    var iv:ImageView = ImageView{
        onMouseClicked: function(e:MouseEvent) {
            if (img!=null) {
                var c:java.awt.Color = new java.awt.Color(img.getRGB(e.x,e.y));
                color = Color.rgb(c.getRed(), c.getGreen(), c.getBlue());
                c2 = c;
            }
        }
        onMouseMoved: function(e:MouseEvent) {
            if (img!=null) {
                var c:java.awt.Color = new java.awt.Color(img.getRGB(e.x,e.y));
                previewColor = Color.rgb(c.getRed(), c.getGreen(), c.getBlue());
            }
        }
        onMouseDragged: function(e:MouseEvent) {
            if (img!=null) {
                var c:java.awt.Color = new java.awt.Color(img.getRGB(e.x,e.y));
                color = Color.rgb(c.getRed(), c.getGreen(), c.getBlue());
            }
        }
        onMouseExited: function(e:MouseEvent) {
            previewColor = null;
        }
    };

    public-init var width:Integer;
    public-init var height:Integer;
    public-read var color:Color = Color.RED;
    public-read var previewColor:Color;

    public override function create():Node {
        img = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        var halfW:Number = width/2.0;
        var vSpacing:Number = 1.0/height;
        var hSpacing:Number = 1.0/halfW;       
        for (y in [0..(height-1)], x in [0..(halfW-1)]) {
            img.setRGB(x,y,java.awt.Color.HSBtoRGB(new java.lang.Float(vSpacing*y), 1, new java.lang.Float(hSpacing*x)));
        }
        for (y in [0..(height-1)], x in [halfW..(width-1)]) {
            img.setRGB(x,y,java.awt.Color.HSBtoRGB(new java.lang.Float(vSpacing*y), new java.lang.Float(1-(hSpacing*(x-halfW))), 1));
        }
        iv.image = SwingUtils.toFXImage(img);
        return iv;
    }
}
