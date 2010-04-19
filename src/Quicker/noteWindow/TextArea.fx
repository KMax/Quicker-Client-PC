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
package Quicker.noteWindow;

import javafx.ext.swing.SwingComponent;
import javax.swing.JEditorPane;
import javax.swing.JComponent;
import javax.swing.JScrollPane;
import java.awt.event.KeyAdapter;
import java.awt.Color;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.MutableAttributeSet;
import javax.swing.text.StyledEditorKit;
import javax.swing.text.StyleConstants;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.AttributeSet;
import javax.swing.text.StyledDocument;

public class TextArea extends SwingComponent {

    var editorPane: JEditorPane;
    var updateComponentFlag: Boolean = false;
    public var text: String on replace {
                if (not updateComponentFlag) {
                    editorPane.setText(text);
                }
            };
    public var editable: Boolean = true on replace {
                editorPane.setEditable(editable);
            };
    public var onKeyUp: function(  keyEvent: java.awt.event.KeyEvent);
             function updateComponentField(){
                        updateComponentFlag = true;
        text= editorPane.getText();
            updateComponentFlag = false;
                }
    public  function getText(): String {
        return editorPane.getText();
	}
    override  function createJComponent(): JComponent {
         editorPane =new JEditorPane();
            editorPane.setEditorKit(new HTMLEditorKit());
            editorPane.setContentType("text/html; charset=utf-8");
            editorPane.setDragEnabled(true);
            editorPane.setDoubleBuffered(true);
            editorPane.setEditable(editable );
            editorPane.setBackground(Color.decode("#FFFFFF"));
        var keyListener: KeyAdapter = KeyAdapter{
    override function keyReleased(e: java.awt.event.KeyEvent) {
                updateComponentField();
                if(onKeyUp != null){onKeyUp(e ); }
            }
    override function keyPressed(e){

            }
        };



        editorPane.addKeyListener( keyListener );
        var scrollPane = new JScrollPane(editorPane,
	JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
	JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        return scrollPane;
    }

    public function makeItalic():Void {       
            if (editorPane != null) {
                 var kit: StyledEditorKit = StyledEditorKit.class.cast(editorPane.getEditorKit());
                 var attr: MutableAttributeSet = kit.getInputAttributes();
                 var italic: Boolean;
                 if(StyleConstants.isItalic(attr)) italic = true else italic = false;
                 var sas : SimpleAttributeSet = new SimpleAttributeSet();
                 StyleConstants.setItalic(sas, not italic);
                 setCharacterAttributes(editorPane, sas, false);
            }
    }

    public function makeUnderlined():Void {
            if (editorPane != null) {
                 var kit: StyledEditorKit = StyledEditorKit.class.cast(editorPane.getEditorKit());
                 var attr: MutableAttributeSet = kit.getInputAttributes();
                 var under: Boolean;
                 if(StyleConstants.isUnderline(attr)) under = true else under = false;
                 var sas : SimpleAttributeSet = new SimpleAttributeSet();
                 StyleConstants.setUnderline(sas, not under);
                 setCharacterAttributes(editorPane, sas, false);
            }
    }

    public function makeBold():Void {
            if (editorPane != null) {
                 var kit: StyledEditorKit = StyledEditorKit.class.cast(editorPane.getEditorKit());
                 var attr: MutableAttributeSet = kit.getInputAttributes();
                 var bold: Boolean;
                 if(StyleConstants.isBold(attr)) bold = true else bold = false;
                 var sas : SimpleAttributeSet = new SimpleAttributeSet();
                 StyleConstants.setBold(sas, not bold);
                 setCharacterAttributes(editorPane, sas, false);
            }
    }


   // 0 - Left
   // 1 - Center
   // 2 - Right
    public function setAlig(i: Integer):Void {
            if (editorPane != null) {
                 var a: Integer= i;
                    var s: String = editorPane.getText();
                var attr:MutableAttributeSet  = new SimpleAttributeSet();
                StyleConstants.setAlignment(attr, a);
                setParagraphAttributes(editorPane, attr, false);
            }
    }

    public function setColor(color: Color): Void {
            var editor = editorPane;
                if (color != null) {
                    var attr: MutableAttributeSet  = new SimpleAttributeSet();
                    StyleConstants.setForeground(attr, color);
                    setCharacterAttributes(editor, attr,  false);
                }
     }
        

    protected function setParagraphAttributes(editor:JEditorPane ,
                                           attr:AttributeSet , repl: Boolean): Void {
            var p0: Integer = editor.getSelectionStart();
            var p1: Integer = editor.getSelectionEnd();
            var doc: StyledDocument  = StyledDocument.class.cast(editor.getDocument());
            doc.setParagraphAttributes(p0, p1 - p0, attr, repl);
    }

     protected function setCharacterAttributes(editor : JEditorPane , attr:AttributeSet , repl: Boolean):Void {
            var p0: Integer = editor.getSelectionStart();
            var p1: Integer = editor.getSelectionEnd();
            if (p0 != p1) {
                var doc : StyledDocument = StyledDocument.class.cast(editorPane.getDocument());
                doc.setCharacterAttributes(p0, p1 - p0, attr, repl);
            }
            var k: StyledEditorKit = StyledEditorKit.class.cast(editorPane.getEditorKit());;
            var inputAttributes : MutableAttributeSet = k.getInputAttributes();
            if (repl) {
                inputAttributes.removeAttributes(inputAttributes);
            }
            inputAttributes.addAttributes(attr);
        }


}


