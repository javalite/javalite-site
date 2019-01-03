package org.javalite.index;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.en.EnglishAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.queryparser.flexible.standard.QueryParserUtil;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.FSDirectory;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import static java.util.Collections.emptyList;
import static org.javalite.common.Util.blank;

/**
 * @author igor on 2/17/18.
 */
public class SearchService {

    private final Analyzer analyzer = new EnglishAnalyzer();
    private IndexSearcher searcher;
    private String highlightLeft, highlightRight;

    public SearchService(Path indexPath, String highlight1, String highlight2) throws IOException {
        IndexReader reader = DirectoryReader.open(FSDirectory.open(indexPath));
        searcher = new IndexSearcher(reader);
        this.highlightLeft = highlight1;
        this.highlightRight = highlight2;
    }

    /**
     * Searches in the indexed corpus.
     *
     * @param queryString Lucene query string as in: "dogs and cats"
     * @return results
     */
    public List<ResultDoc> search(String queryString) throws ParseException, IOException, InvalidTokenOffsetsException {
        if (blank(queryString)) {
            return emptyList();
        }

        List<ResultDoc> resultDocs = new ArrayList<>();
        QueryParser parser = new QueryParser("CONTENT", analyzer);
        Query query = parser.parse(QueryParserUtil.escape(queryString));
        TopDocs docs = searcher.search(query, 20);

        for (int i = 0; i < docs.scoreDocs.length; i++) {
            ScoreDoc scoreDoc = docs.scoreDocs[i];
            Document doc = searcher.doc(scoreDoc.doc);
            String[] fragments = getHighlightedFields(query, "CONTENT", doc.get("CONTENT"));
            resultDocs.add(new ResultDoc(doc.get("SLUG"), fragments[0], doc.get("TITLE"), doc.get("TYPE")));
        }
        return resultDocs;
    }

    private String[] getHighlightedFields(Query query, String fieldName, String fieldValue) throws IOException, InvalidTokenOffsetsException {
        Formatter formatter = new SimpleHTMLFormatter(highlightLeft, highlightRight);
        QueryScorer queryScorer = new QueryScorer(query);
        Highlighter highlighter = new Highlighter(formatter, queryScorer);
        highlighter.setTextFragmenter(new SimpleSpanFragmenter(queryScorer, 200));
        highlighter.setMaxDocCharsToAnalyze(Integer.MAX_VALUE);
        return highlighter.getBestFragments(this.analyzer, fieldName, fieldValue, 2);
    }
}
