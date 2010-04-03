/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Quicker;

import java.io.IOException;
import java.io.StringReader;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Илья
 */
public class Controller {

    private static Controller instance = null;
    private QuickerNotesProvider provider;
    private LinkedList<NoteListItem> noteList;
    private String note;

    public static Controller getInstance() {
        if (instance == null) {
            instance = new Controller();
        }
        return instance;
    }

    private Controller() {
        //   provider = QuickerNotesProvider.getInstance();
        noteList = new LinkedList<NoteListItem>();
    }

    public LinkedList<NoteListItem> getNoteList() {
        //   provider.getNotesList();

        String note = "<notes>"
                + "<note>"
                + "<id>1</id>"
                + "<title>Заголовок</title>"
                + "<extractions>Бла бла бла</extractions>"
                + "<date>9500000000</date>"
                + "</note>"
                + "<note>"
                + "<id>2</id>"
                + "<title>Второй</title>"
                + "<extractions>Первая строка</extractions>"
                + "<date>9500000000</date>"
                + "</note>"
                + "</notes>";
        try {
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            f.setNamespaceAware(true);
            DocumentBuilder builder = f.newDocumentBuilder();
            InputSource is = new InputSource();
            is.setCharacterStream(new StringReader(note));
            Document document = builder.parse(is);
            XPath xpath = XPathFactory.newInstance().newXPath();
            double num = (Double)xpath.evaluate("count(//note)",
                                    document, XPathConstants.NUMBER);
            XPathExpression expr;
            expr = xpath.compile("/notes//note");
            Object result = expr.evaluate(document, XPathConstants.NODESET);
            NodeList nodes;
            nodes = (NodeList)result;

            NoteListItem item;
            LinkedList<Media> media;
            for (int i = 0; i < num; i++) {
                media = new LinkedList<Media>();
                media.add(Media.Text);
                item = new NoteListItem(
                        nodes.item(i).getChildNodes().item(0).getTextContent(),
                        nodes.item(i).getChildNodes().item(1).getTextContent(),
                        nodes.item(i).getChildNodes().item(2).getTextContent(),
                        Long.parseLong(nodes.item(i).getChildNodes().item(3).getTextContent()),
                        media
                        );
                noteList.add(item);
            }
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            // throw ControllerException(Trowable e)
        } catch (XPathExpressionException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return noteList;
    }

    public String getNote(String id) {
        note = "<note id=\"" + id + "\"><title>Первая заметка</title><content>"
                + "<text>Контент заметки. Много много много много "
                + "много много много теста</text></content><date>"
                + "23.06.1990</date></note>";
        return note;
    }

    public LinkedList<NoteListItem> getEventList() {
        return null;
    }

    public LinkedList<NoteListItem> getContactList() {
        return null;
    }
}