package org.javalite.index;

import java.io.IOException;
import java.io.StringReader;
import javax.swing.text.html.HTMLEditorKit.ParserCallback;
import javax.swing.text.html.parser.ParserDelegator;


/**
 * @author igor on 11/26/17.
 */
public class HtmlConverter {

    public static String convert2text(String html) throws IOException {
        StringBuilder sb = new StringBuilder();

        ParserDelegator parserDelegator = new ParserDelegator();
        ParserCallback parserCallback = new ParserCallback() {

            public void handleText(char[] data, int pos) {
                    sb.append(new String(data)).append(" ");
            }
        };
        parserDelegator.parse(new StringReader(html), parserCallback, true);
        return sb.toString();
    }
}
