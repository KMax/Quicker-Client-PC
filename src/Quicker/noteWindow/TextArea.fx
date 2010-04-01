package Quicker.noteWindow;

import javafx.ext.swing.SwingComponent;
import javax.swing.JEditorPane;
import javax.swing.JComponent;
import javax.swing.JScrollPane;
import java.awt.event.KeyAdapter;
import java.awt.Color;


public class TextArea extends SwingComponent{

    var editorPane: JEditorPane;
    var updateComponentFlag: Boolean = false;

    public var text: String on replace{
        if(not updateComponentFlag){
            editorPane.setText(text);
        }
    };

    public var editable: Boolean = true on replace{
        editorPane.setEditable(editable);
    };

    public var onKeyUp: function(keyEvent :java.awt.event.KeyEvent);


    function updateComponentField(){
            //System.out.println("[editor pane] updateComponentField!");
            updateComponentFlag = true;
            text = editorPane.getText();
            updateComponentFlag = false;
    }

    override function createJComponent(): JComponent {
        editorPane = new JEditorPane();
        editorPane.setEditable(editable);
	editorPane.setBackground(Color.YELLOW);

        var keyListener:KeyAdapter = KeyAdapter{
            override function keyReleased(e: java.awt.event.KeyEvent) {
                updateComponentField();
                if(onKeyUp != null){onKeyUp(e ); }
            }
        };

        editorPane.addKeyListener( keyListener );
        var scrollPane = new JScrollPane(editorPane);
        return scrollPane;
        //return editorPane;

    }

}


