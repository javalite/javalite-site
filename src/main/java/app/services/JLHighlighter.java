package app.services;

import org.apache.lucene.search.postingshighlight.DefaultPassageFormatter;
import org.apache.lucene.search.postingshighlight.PassageFormatter;
import org.apache.lucene.search.postingshighlight.PostingsHighlighter;

/**
 * @author igor on 2/17/18.
 */
public class JLHighlighter extends PostingsHighlighter {

    private DefaultPassageFormatter formatter =
            new DefaultPassageFormatter("<span class='highlighted'>", "</span>", " ... ", false);

    @Override
    protected PassageFormatter getFormatter(String field) {
        return formatter;
    }
}
