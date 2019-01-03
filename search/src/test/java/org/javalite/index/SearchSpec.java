package org.javalite.index;

import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.javalite.common.Util;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;

import static org.javalite.test.jspec.JSpec.the;

/**
 * @author igor on 11/7/18.
 */
public class SearchSpec {

    private Path indexPath = Paths.get("target/index");

    @Before
    public void setup() throws IOException {
        Util.recursiveDelete(indexPath);
    }

    @Test
    public void indexAndSearch() throws IOException, InvalidTokenOffsetsException, ParseException {
        new Indexer(indexPath).index("src/test/resources/");
        SearchService searchService  = new SearchService(indexPath, "<strong>", "</strong>");
        List<ResultDoc> resultDocs =  searchService.search("model");
        the(resultDocs.size()).shouldBeEqual(2);
        the(resultDocs.get(0).getFragment()).shouldContain("of setting up a <strong>model</strong>. Approach #1");
        the(resultDocs.get(1).getFragment()).shouldContain("The corresponding <strong>model</strong> looks ");
    }
}
