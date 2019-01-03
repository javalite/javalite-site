package org.javalite.index;

import org.javalite.common.Util;
import org.junit.Test;

import java.io.IOException;

import static org.javalite.test.jspec.JSpec.a;

/**
 * @author igor on 2/17/18.
 */
public class HtmlConverterSpec {

    @Test
    public void shouldConvertHTMLToTextAndNotSpliceWordsTogether() throws IOException {
        String html =  Util.readResource("/activejdbc.md.html");
        a(HtmlConverter.convert2text(html)).shouldContain("SQLServer MySQL Oracle PostgreSQL H2 SQLite3 DB2");
    }
}
