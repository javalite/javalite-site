package app.services;

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
import org.apache.lucene.search.postingshighlight.PostingsHighlighter;
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
    private final Path indexPath;

    public SearchService(Path indexPath) {
        this.indexPath = indexPath;
    }

    /**
     * Searches in the indexed corpus.
     *
     * @param queryString Lucene query string as in: "dogs and cats"
     * @return results
     */
    public List<ResultDoc> search(String queryString) throws ParseException, IOException {
        if (blank(queryString)) {
            return emptyList();
        }

        List<ResultDoc> resultDocs = new ArrayList<>();
        IndexReader reader = DirectoryReader.open(FSDirectory.open(indexPath.toFile()));
        IndexSearcher searcher = new IndexSearcher(reader);
        QueryParser parser = new QueryParser("CONTENT", analyzer);
        Query query = parser.parse(QueryParserUtil.escape(queryString));
        TopDocs docs = searcher.search(query, 20);
        String[] fragments = getPostingsHighlightedFragment(query, searcher, docs);
        for (int i = 0; i < docs.scoreDocs.length; i++) {
            ScoreDoc scoreDoc = docs.scoreDocs[i];
            Document doc = searcher.doc(scoreDoc.doc);
            resultDocs.add(new ResultDoc(doc.get("SLUG"), fragments[i], doc.get("TITLE"), doc.get("TYPE")));
        }
        return resultDocs;
    }

    private String[] getPostingsHighlightedFragment(Query query, IndexSearcher searcher, TopDocs hits) throws IOException {
        PostingsHighlighter highlighter = new JLHighlighter();
        return highlighter.highlight("CONTENT", query, searcher, hits, 2);
    }
}
