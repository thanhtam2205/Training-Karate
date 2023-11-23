package examples.testHRM.utils;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.StringReader;

public class ConvertXML {

    final static String str = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
            "<company>\n" +
            "    <staff id=\"1001\">\n" +
            "        <name>mkyong</name>\n" +
            "        <role>support</role>\n" +
            "        <salary currency=\"USD\">5000</salary>\n" +
            "        <!-- for special characters like < &, need CDATA -->\n" +
            "        <bio><![CDATA[HTML tag <code>testing</code>]]></bio>\n" +
            "    </staff>\n" +
            "    <staff id=\"1002\">\n" +
            "        <name>yflow</name>\n" +
            "        <role>admin</role>\n" +
            "        <salary currency=\"EUR\">8000</salary>\n" +
            "        <bio><![CDATA[a & b]]></bio>\n" +
            "    </staff>\n" +
            "</company>";
    private static Document convertStringToXml() {


        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

        try {

            // optional, but recommended
            // process XML securely, avoid attacks like XML External Entities (XXE)
            dbf.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

            DocumentBuilder builder = dbf.newDocumentBuilder();

            Document doc = builder.parse(new InputSource(new StringReader(str)));

            return doc;

        } catch (ParserConfigurationException | IOException | SAXException e) {
            throw new RuntimeException(e);
        }
    }

    private int getNumber(int number) {
        return number *2;
    }
}
