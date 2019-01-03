package org.javalite.index;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Properties;

import static java.nio.file.Files.newInputStream;
import static org.javalite.common.Inflector.capitalize;
import static org.javalite.common.Util.read;

/**
 * @author Igor Polevoy on 1/4/15.
 */
class SearchFileVisitor extends SimpleFileVisitor<Path> {
    private final IndexWriter indexWriter;

    private int count = 0;

    SearchFileVisitor(IndexWriter indexWriter){
        this.indexWriter = indexWriter;
    }

    @Override
    public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) throws IOException {

        if (path.toString().endsWith("html") && !path.toString().contains("excerpt")) {


            Document document = new Document();
            document.add(new StringField("PATH", path.toString(), Field.Store.YES));
            String text = HtmlConverter.convert2text(read(newInputStream(path)));

            Properties props = getDocumentProperties(path);

            String tag = getTag(path);

            addField(document, "TAG", tag);
            String slug = getSlug(path);
            addField(document, "SLUG", slug);
            String title = getTitle(props, slug);
            addField(document, "TITLE", title);
            String[] yearMonthDay = getYearMonthDay(props);
            if (yearMonthDay != null) {
                addField(document, "YEAR", yearMonthDay[0]);
                addField(document, "MONTH", yearMonthDay[1]);
                addField(document, "DAY", yearMonthDay[2]);
            }

            if(path.toString().contains("blog")){
                addField(document, "TYPE","blog");
            }

            if(path.toString().contains("pages")){
                addField(document, "TYPE","page");
            }

            document.add(new TextField("CONTENT", title + ". " + text, Field.Store.YES));

            indexWriter.addDocument(document);
            count++;
        }
        return FileVisitResult.CONTINUE;
    }

    private void addField(Document document, String name, String value){
        document.add(new StringField(name, value, Field.Store.YES));
    }

    private String getTitle(Properties props, String slug){
        return props.getProperty("Title", capitalize(slug.replace("_", " ")));
    }

    private String[] getYearMonthDay(Properties props){
        String date = props.getProperty("Date");
        return date == null ? null : date.split(" ")[0].split("-");
    }


    private String getSlug(Path path) {
        String fileName = path.getFileName().toString();
        return fileName.substring(0, fileName.indexOf("."));
    }

    private String getTag(Path path) {
        return path.getName(2).toString();
    }

    private Properties getDocumentProperties(Path path) {
        try {
            String propertiesFile = path.toString().substring(0, path.toString().indexOf(".") + 1) + "properties";
            Properties props = new Properties();
            try (FileInputStream fin = new FileInputStream(propertiesFile)) {
                props.load(fin);
            }
            return props;
        } catch (Exception e) {
            return new Properties();
        }
    }

    int getCount() {
        return count;
    }
}
