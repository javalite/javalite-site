package org.javalite.index;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.en.EnglishAnalyzer;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.IndexWriterConfig.OpenMode;
import org.apache.lucene.store.FSDirectory;

/**
 * @author igor on 11/26/17.
 */
public class Indexer {
    private final Analyzer analyzer = new EnglishAnalyzer();
    private Path indexPath;

    public Indexer(Path indexPath) {
        this.indexPath = indexPath;
    }

    public int index(String contentPath) throws IOException {

        FSDirectory dir = FSDirectory.open(indexPath);
        IndexWriterConfig config = new IndexWriterConfig(this.analyzer);
        config.setOpenMode(OpenMode.CREATE_OR_APPEND);
        IndexWriter indexWriter = new IndexWriter(dir, config);
        Path directory = Paths.get(contentPath);
        SearchFileVisitor visitor;
        Files.walkFileTree(directory, visitor = new SearchFileVisitor(indexWriter));
        indexWriter.commit();
        indexWriter.close();
        dir.close();
        return visitor.getCount();
    }

}
