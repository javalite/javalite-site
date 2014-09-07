<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>JavaLite - <@yield to="title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${context_path}/css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="${context_path}/css/bootswatch.css">
    <link rel="stylesheet" href="${context_path}/css/main.css">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="${context_path}/js/html5shiv.js"></script>
    <script src="${context_path}/js/respond.min.js"></script>
    <![endif]-->
    <script>

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-23019901-1']);
        _gaq.push(['_setDomainName', "bootswatch.com"]);
        _gaq.push(['_setAllowLinker', true]);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();

    </script>
</head>
<body>
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="../" class="navbar-brand">JavaLite</a>
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">

                <li><a href="/activejdbc">ActiveJDBC</a></li>

                <li><a href="/activeweb">ActiveWeb</a></li>
                <li><a href="/jspec">JSpec</a></li>

                <li><a href="/http">Http</a></li>


                <li class="divider-vertical"></li>

                <li><a href="/documentation">Documentation</a></li>
            <#--<li class="dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">JavaDoc<b-->
            <#--class="caret"></b></a>-->
            <#--<ul class="dropdown-menu">-->
            <#--<li><a href="http://ipsolutionsdev.com/activejdbc/">ActiveJDBC</a></li>-->
            <#--<li><a href="http://ipsolutionsdev.com/activejdbc/">ActiveWeb</a></li>-->
            <#--<li><a href="http://ipsolutionsdev.com/activejdbc/org/javalite/test/jspec/Expectation.html">JSpec</a></li>-->
            <#--<li><a href="http://ipsolutionsdev.com/activejdbc/org/javalite/http/package-summary.html">Http</a></li>-->

            <#--</ul>-->
            <#--</li>-->

                <li><a href="/sources">Sources</a></li>

            <#--<li class="dropdown"><a href="#" data-toggle="dropdown" class="dropdown-toggle">Sources<b-->
            <#--class="caret"></b></a>-->
            <#--<ul class="dropdown-menu">-->
            <#--<li><a href="http://github/activejdbc/">ActiveJDBC</a></li>-->
            <#--<li><a href="http://github/activeweb/">ActiveWeb</a></li>-->
            <#--<li><a href="http://github/activeweb/jspec">JSpec</a></li>-->
            <#--<li><a href="http://github/activeweb/http">Http</a></li>-->
            <#--</ul>-->
            <#--</li>-->

                <li><a href="/support">Support</a></li>
            </ul>


        </div>
    </div>
</div>


<div class="container">

    ${page_content}


</div>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${context_path}/js/bootstrap.min.js"></script>
<script src="${context_path}/js/bootswatch.js"></script>
</body>
</html>
