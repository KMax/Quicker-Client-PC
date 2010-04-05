/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Quicker;

import java.io.IOException;
import java.io.StringReader;
import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Илья
 */
public class XMLParser {
    private DocumentBuilderFactory f;
    private DocumentBuilder builder;
    Document document;
    private XPath xpath;

    public XMLParser(String xml) throws ParserConfigurationException,
            SAXException, IOException {
        f = DocumentBuilderFactory.newInstance();
        f.setNamespaceAware(true);
        builder = f.newDocumentBuilder();
        InputSource is = new InputSource();
        is.setCharacterStream(new StringReader(xml));
        xpath = XPathFactory.newInstance().newXPath();
        document = builder.parse(is);
    }

    public Object execute(String request, QName name)
            throws XPathExpressionException {
        XPathExpression expr = xpath.compile(request);
        return expr.evaluate(document, name);
    }
}
