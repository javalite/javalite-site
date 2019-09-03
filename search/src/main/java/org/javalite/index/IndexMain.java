package org.javalite.index;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

/**
 * @author Igor Polevoy on 10/16/15.
 */
public class IndexMain {
    public static void main(String[] args) throws IOException {

        String target = args[0];
        File targetDir = Paths.get(target).toFile();
        if (targetDir == null || !targetDir.exists() || !targetDir.isDirectory()) {
            throw new RuntimeException("failed to find target directory: " + target);
        }

        System.out.println("IndexMain: Completed indexing, processed: "
                + new Indexer(Paths.get(target)).index(args[1]) + " documents");
        System.out.println("IndexMain: Completed indexing, processed: "
                + new Indexer(Paths.get(target)).index(args[2]) + " documents");
    }
}
