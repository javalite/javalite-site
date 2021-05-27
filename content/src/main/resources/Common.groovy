

import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import static groovy.io.FileType.FILES


def copyProperties(String src, String target){
    Path path = Paths.get(src)
    path.toFile().eachFileRecurse(FILES) {
        if(it.name.endsWith('.properties')) {
            Files.copy(Paths.get(it.canonicalPath), Paths.get(target +"/"+  it.name))
        }
    }
}

def processMarkDown(String src, String target){
    Path dir = Paths.get(src)
    dir.toFile().eachFileRecurse(FILES) {
        if(it.name.endsWith('.md')) {
            println "Processing ${it.absolutePath}"

            def proc = System.getProperty("os.name").equals("Linux") ?
                    "pandoc -f markdown -t html  --html-q-tags ${it.absolutePath} -o ${target}/${it.name}.html".execute() :
                    "pandoc -f markdown -t html   \"${it.absolutePath}\" -o \"${target}/${it.name}.html\"".execute()

            proc.waitForProcessOutput(System.out, System.err)
            if (proc.exitValue() != 0){
                System.err.println("Failed to execute Pandoc, see error above")
                System.exit(-1);
            }
        }
    }
}

def copyFiles(String source, String target){
    ant = new AntBuilder()
    ant.sequential {
        copy(todir: target) {
            fileset(dir: source) {
                include(name: "**/*.*")
            }
        }
    }
}

def copyFile(String fileCanonicalPath, String destinationDir){
    println "Copying file: $fileCanonicalPath to: $destinationDir"
    new AntBuilder().copy( file:"$fileCanonicalPath", todir: "$destinationDir")
}