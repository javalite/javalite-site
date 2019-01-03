<div class="page-header">
   <h1>Async</h1>
</div>

JavaLite Async is a lightweight system for processing asynchronous jobs.
When developing a website, you often need to run some process while not slowing down 
user page refresh.


Async uses [Apache Artemis](https://activemq.apache.org/artemis/) under the hood, but makes it 
very easy to do so. While Apache Artemis is a [JMS](https://en.wikipedia.org/wiki/Java_Message_Service) 
broker, the Async adds an abstraction layer based on a [Command Pattern](https://en.wikipedia.org/wiki/Command_pattern), 
which makes it trivial to add asynchronous processing: 



## Embedded broker instance

Setting up Apache Artemis requires substantial knowledge of JMS and this specific implementation. 
However, JavaLite Async makes it easy by configuring Apache Artemis with reasonable defaults 


~~~~ {.java  .numberLines}
Async async = new Async("/opt/project1", false, new QueueConfig("email", new CommandListener(), 50));
async.start();
~~~~

where `/opt/project1` is a place to store persistent messages, `email` is a name of a queue, and 50 is number of 
 listeners (threads) to create for processing. 



## Writing a simple command

Lets write a command, which will simply print a message to console: 

```java
public class HelloCommand extends Command {

    private String message;

    public HelloCommand(String message) {
        this.message = message;
    }

    public HelloCommand() {} //necessary to provide

    @Override
    public void execute() {
        System.out.println(message);
    }
}

```



## Processing a command


Lets instantiate and start the broker: 
```java
Async async = new Async(filePath, false, new QueueConfig("MESSAGES_QUEUE", new CommandListener(), 5));
async.start();

```

after that, sending a command for asynchronous processing is a one line of code: 

```java
for(int i = 0; i < 100; i++){
    async.send("MESSAGES_QUEUE", new HelloCommand("Hello, Dolly " + i));
}

```


as expected, the output of this  process will be: 

```
Hello, Dolly 0
Hello, Dolly 2
Hello, Dolly 1
Hello, Dolly 3
Hello, Dolly 4
...
```

> In the example above, we allocated 5 threads for  processing, therefore the order of execution of the comands will not necessarily 
be linear, since threads will process messages in parallel.


## Creating multiple queues

The `JavaLite Async` allows to create  and configure multiple queues: 

```java
Async async = new Async(filePath, false, 
new QueueConfig("MESSAGES_QUEUE", new CommandListener(), 5), 
new QueueConfig("ERROR_QUEUE", new CommandListener(), 0));
```

The constructor accepts an array of `QueueConfig` instances as a 
[vararg](https://docs.oracle.com/javase/1.5.0/docs/guide/language/varargs.html).


## Peeking into queues

Sometimes you need to peek into what is in the queue. Normally this is done in some administrative tools. 
Lets take a look at 3 top commands in the queue (the ones at the head of the queue):

```java

List<Command> topCommands =  async.getTopCommands(3, "ERROR_QUEUE"); 
```

> IMPORTANT: peeking into a queue does not remove commands from a queue. 


## Reading synchronously

You can read and process commands from an individual queue one at the time without a listener. 
In some cases, such as DMQ, you do not want to process errors automatically. Here is how you can 
process one command at the time: 

```java

ErrorCommand errorCommand = (ErrorCommand)receiveCommand("ERROR_QUEUE");
// act on the information in your command.

```

## Text vs Binary messages

Since the underlying technology is [JMS - Java Messaging Service](https://en.wikipedia.org/wiki/Java_Message_Service), 
the communication protocol is limited to the types of messages supported by JMS. 
JavaLite Async may use one of two: `javax.jms.TextMessage` or `javax.jms.TextMessage`. In both cases, the serialization of a command is 
first done to XML with the use of [XStream](http://x-stream.github.io/). 

If your command has a tranient field that cannot/should not be serialized, use the XStream annotation to ignore it: 

```java
public class HelloCommand extends Command {
    @XStreamOmitField
    private Object ignoredElement;

....
}
```


In order to set Async to a binary mode, use this setter: 

```java
async.setBinaryMode(true);
```

> Do not switch from mode to mode while having persistent messages stored in your queues.


## Commands with DB access


In cases where your queue processing requires a database connetion, you can use a class 
[DBCommandListener](http://javalite.github.io/activeweb/snapshot/org/javalite/async/DBCommandListener.html): 

```java
Async async = new Async(filePath, false, new QueueConfig("MESSAGES_QUEUE", new DBCommandListener("java:comp/env/jdbc/yout_project"), 5));
```

So long as you configure a JNDI connection with access string: `java:comp/env/jdbc/yout_project`, 
the listener will find and open a database connection. 

Look at the documentation of your container to learn how to configure a database connection pool and allocate a name to it.
Here is an example from [Tomcat JNDI datasource examples](https://tomcat.apache.org/tomcat-8.0-doc/jndi-datasource-examples-howto.html).


From the documentation of this class:

_This class will open a new connection, start a new transaction and will execute the command. After that, the transaction will be committed. In case execution of a command fails, the transaction will be rolled back and command and exception wil be passed to `onException(Command, Exception)` method, where a subclass can process them further. The connection will be closed regardless of outcome._




## Dependency injection

Like any other parts of JavaLite, the Async integrates with [Google Guice](https://github.com/google/guice):
 
```java

Async async = Async(dataDirectory, useLibAio, injector, queueConfigs);
```

The third parameter is an instance of a [Guice Injector](https://github.com/google/guice/blob/master/core/src/com/google/inject/Injector.java).
 
As long as your commands have an `@Inject` annotation, they will be injected with services prior execution: 

```java
public class HelloCommand extends Command {

    @Inject
    PrintingService printingService;

    private String message;

...

    @Override
    public void execute() {
        printingService.println(message);
    }
}

```


## Access to Artemis Config

If you have a complex configuration, you can access and use the Artemis API directly 

```java
org.apache.activemq.artemis.core.config.Condifuration artemisCOnfig = async.getConfig();
```

for more information, refer to [Artemis documentation](https://activemq.apache.org/artemis/docs/latest/index.html).