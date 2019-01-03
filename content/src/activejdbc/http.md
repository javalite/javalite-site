<div class="page-header">
   <h1>Http</h1>
   <h4>Tiny client for web services</h4>
</div>



JavaLite HTTP is a tiny library for making HTTP requests and returning responses. It has no dependencies other than the JDK.

## How to GET

~~~~ {.java  .numberLines}
Get get = Http.get("http://yahoo.com");
System.out.println(get.text());
System.out.println(get.headers());
System.out.println(get.responseCode())
~~~~

## How to POST

### POST binary content

~~~~ {.java  .numberLines}

byte[] content = ...; // fill with your data

Post post = Http.post("http://yahoo.com", content)
                .header(headerName, headerValue);
System.out.println(post.text());
System.out.println(post.headers());
System.out.println(post.responseCode())
~~~~

### POST JSON content 

~~~~ {.java .numberLines}
Post post = Http.post(url, content)
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");
~~~~

### How to POST a form

Posting a single value is easy:

~~~~ {.java .numberLines}
Post post = Http.post("http://example.com/hello")
                .param("name", "John");
System.out.println(post.text());
~~~~

Posting multiple values can be done: 

~~~~ {.java .numberLines}
Post post = Http.post("http://example.com/hello")
                .param("first_name", "John")
                .param("last_name", "Doe");
System.out.println(post.text());
~~~~

or even better: 

~~~~ {.java .numberLines}
Post post = Http.post("http://example.com/hello").params("first_name", "John", "last_name", "Doe");
System.out.println(post.text());
~~~~




## How to PUT and DELETE

Similar to the above.  You can find full JavaDoc here:
<a href="http://javalite.github.io/activejdbc/snapshot/org/javalite/http/package-summary.html">JavaLite HTTP JavaDoc</a>

## Basic authentication

~~~~ {.java .numberLines}
String response = Http.get(url).basic(user, password).text();
~~~~

## Sending multipart requests

In case you need to send [multipart messages](https://en.wikipedia.org/wiki/MIME#Multipart_messages), you can do so simply 
by executing one line of code: 


~~~~ {.java .numberLines}
Multipart mp = Http.multipart("http://myserver.com/upload/")
                .field("name1", "val1")
                .file("file1", "/home/johndoe/test.txt");
System.out.println(mp.text());
~~~~

You can use any combination of other methods to modify timeouts, basic authentication, headers, etc. 



## How to get the dependency

~~~~ {.xml  .numberLines}
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>javalite-common</artifactId>
    <version>LATEST_VERSION</version>
</dependency>
~~~~

For latest version and  download, refer to [Maven Central](http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22javalite-common%22)
