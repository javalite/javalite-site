

import java.nio.file.*

GroovyShell shell = new GroovyShell()
common = shell.parse(Paths.get(System.getenv("JAVALITE_SITE_PROJECT") + "/content/src/main/groovy/Common.groovy").toFile())

String src = System.getenv("JAVALITE_SITE_PROJECT") + "/content/src"
String output = System.getenv("JAVALITE_SITE_PROJECT") + "/content/target/output"
String outBlog = "${output}/blog"
String outImages = "${output}/content-images"
String searchIndex = "${output}/search_index"

new File(output).mkdir()
new File("${output}/pages").mkdir()
new File(outBlog).mkdir()
new File(searchIndex).mkdir()


println new File(outImages).mkdir()

println new File(searchIndex).mkdir()
println new File("${outBlog}/authors").mkdir()
println new File("${outBlog}/posts").mkdir()

common.copyFiles(Paths.get("${src}/content-images").toString(), Paths.get(outImages).toString())


common.copyProperties("${src}/blog/authors", "${outBlog}/authors")
common.copyProperties("${src}/blog/posts", "${outBlog}/posts")


common.processMarkDown("${src}/blog/posts", "${outBlog}/posts")
common.processMarkDown("${src}/blog/authors", "${outBlog}/authors")

common.processMarkDown("${src}/activejdbc", "${output}/pages")
common.processMarkDown("${src}/activeweb", "${output}/pages")

common.copyFiles(Paths.get("${src}/activejdbc").toString(), "${output}/pages")
common.copyFiles(Paths.get("${src}/activeweb").toString(), "${output}/pages")