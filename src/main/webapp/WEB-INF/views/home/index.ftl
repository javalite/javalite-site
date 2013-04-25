<@content for="title">ActiveJDBC & ActiveWeb - Java, light as a feather</@content>

<span class="jumbotron subhead">
  <h1>JavaLite</h1>
  <p class="lead">Java, light as a feather...</p>
</span>


<!-- Headings & Paragraph Copy -->
<div class="row">
    <div class="span5">
        <div class="well">
            <h1><@link_to controller="activejdbc">ActiveJDBC</@link_to></h1>

            <h3>ActiveJDBC is a lightweight and fast Java ORM</h3>

            <p></p>
            <h5>If you:</h5>

            <ul>
                <li>are tired of configuring ORMs</li>
                <li>do not like to write a ton of persistent code</li>
                <li>like conventions over configuration</li>
                <li>do not want to learn another query language</li>
                <li>want your persistent code to run fast</li>
                <li>are tired of DAOs and DTOs</li>
                <li>want to simply understand your code better...</li>
            </ul>

            <h5>... then ActiveJDBC is your ORM!</h5>
            <h5 style="float: right"><@link_to controller="activejdbc">find out more...</@link_to></h5>
        </div>
    </div>

    <div class="span5">

        <div class="well">
            <h1><@link_to controller="activeweb">ActiveWeb</@link_to></h1>

            <h3>Full stack Java web framework for agile development</h3>


            <p></p>
            <h5>If you:</h5>

            <ul>
                <li>do not like piece-mealing solutions for days</li>
                <li>like conventions over configuration</li>
                <li>want to be productive the first minute</li>
                <li>want to see your code changes reflected immediately</li>
                <li>want beautiful REST-like URLs</li>
                <li>want to use the same standard Java project structure</li>
                <li>want to easily write high quality tests</li>
            </ul>
            <h5>... then ActiveWeb is your Web framework!</h5>
            <h5 style="float: right;" ><@link_to controller="activeweb">find out more...</@link_to></h5>
        </div>
    </div>


    <div class="span5" style="width: 780px">
        <a name="news">&nbsp;</a>
        <div class="well-large" style="border-style: solid; border-width: 1px; border-color: #e9322d;">
            <h2>News</h2>

            <p>
                <strong>March 20 2012</strong>
                ActiveWeb and ActiveJDBC were presented to the <a href="http://mchenry.softwarecraftsmanship.org/">Software Craftsmanship McHenry County</a> - got great
                reception. Part of the presentation was to build a simple live application with test coverage.
            </p>

            <p>
                <strong>January 25 2012 ActiveWeb: </strong> - support for flexible routing model added.
            </p>


            <p>
                <strong>January 25 2012</strong> - Support for Microsoft SQL Server was added. This brings the number of
                databases supported
                by
                ActiveJDBC to 5: MySQL, PostgreSQL, Oracle, H2, MS SQLServer. Kudos to John Richardson for this
                contribution.
                Support of MS SQLServer includes both Microsoft and TDS drivers.
            </p>


            <p>
                <strong>January 3 2012</strong> - I did a presentation at Groupon Geekfest on ActiveWeb and ActiveJDBC:
                <a href="http://geekfest.gathers.us/events/geekfest-activeweb-and-activejdbc">http://geekfest.gathers.us/events/geekfest-activeweb-and-activejdbc</a>.
                It was very well received. Some folks offered a helping hand to add support for Microsoft SQLServer.
            </p>

            <p>
                <strong>September 18 2011 </strong> - A new caching provider has been integrated into the project:
                EHCache. This was done
                because it seems that OSCache, however good of a project, is retired by OpenSymphony.
            </p>

            <p>
                <strong>August 18 2010</strong> - yesterday I ran a presentation on ActibeJDBC at Thoughtworks.
                Attendance was at healthy 25 people, and all were engaged and asked a lot of questions. To those
                attended:
                thank you
                for interest in the framework, your questions and suggestions! This proves once again that there is room
                for
                a new
                Java ORM system. If you'd like to get the presentation slides, follow this link:
                <a href="http://activejdbc.googlecode.com/svn/trunk/doc/activejdbc-cjug.pdf">http://activejdbc.googlecode.com/svn/trunk/doc/activejdbc-cjug.pdf</a>

            </p>

            <p>
                <strong>August 10 2011</strong> - Dear community, we are preparing for a first formal release of
                ActiveJDBC and publishing it
                to the Maven Central. In preparations, we upgraded the version from 1.1-SNAPSHOT to 1.2-SNAPSHOT and
                also moved all
                classes from package: activejdbc to package: <code>org.javalite.activejdbc</code>

                We also moved group artifact from: activejdbc to: <code>org.javalite.activejdbc</code>


                All these superficial changes are required by Sonatype to publish to the Maven Central. We apologize for
                the
                temporary inconvenience, but this change is something we did not anticipate. However, with ActiveWeb
                following the suit, it too will be released under org.javalite group ID and package.
                The new repository we are publishing snapshots is hosted by Sonatype:
                <a href="https://oss.sonatype.org/content/repositories/snapshots/org/javalite/">https://oss.sonatype.org/content/repositories/snapshots/org/javalite/</a>

            </p>

            <p>
                <strong>July 20 2011</strong> - JavaDoc accessible: <a href="http://ipsolutionsdev.com/activejdbc/">http://ipsolutionsdev.com/activejdbc/</a>
            </p>

            <p>
                <strong>May 22 2011</strong> - <a href="http://jp.linkedin.com/in/philsuh">Phil Suh</a>  added support for H2 Database

            </p>

            <p>
                <strong>February 23 2011</strong> - Added a long awaited generation of JSON into classes Model and
                LazyList, for more
                information
                navigate to GenerationOfJson
            </p>

            <p>
                <strong>January 12 2011</strong> ActiveJDBC now has ability to load metadata on demand - when a database
                is first accessed.
                This means that in cases when a system has more than one database, their metadata is not loaded up all
                at once.
                This gives more flexibility because you do not need to have all connections available in places where
                you only
                need one.
            </p>

            <p>
                <strong>November 9 2010</strong> ActiveJDBC now has ability to generate stock XML from models and lists
                of models. Follow
                this link for more information: GenerationOfXml
            </p>

            <p>
                <strong>September 28 2010</strong> ActiveJDBC validations framework has been extended to take in dynamic
                parameters, and
                reflect internationalized messages. For more information, take a look at Validations
            </p>

            <p>
                <strong>September 7 2010</strong> All artifacts from this project are published to a new snapshot
                repository: <a href="http://ipsolutionsdev.com/snapshots/">http://ipsolutionsdev.com/snapshots/</a>
            </p>
        </div>
    </div>
</div>




