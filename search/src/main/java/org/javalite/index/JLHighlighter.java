package org.javalite.index;

import org.apache.lucene.search.uhighlight.DefaultPassageFormatter;
import org.apache.lucene.search.uhighlight.PassageFormatter;

/**
 * @author igor on 2/17/18.
 */
public class JLHighlighter //extends PostingsHighlighter
{

    private DefaultPassageFormatter formatter =
            new DefaultPassageFormatter("<span class='highlighted'>", "</span>", " ... ", false);


    protected PassageFormatter getFormatter(String field) {
        return formatter;
    }
}
