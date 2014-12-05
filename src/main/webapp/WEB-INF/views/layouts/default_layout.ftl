<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>JavaLite - <@yield to="title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${context_path}/css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="${context_path}/css/bootswatch.css">
    <link rel="stylesheet" href="${context_path}/css/main.css">
    <link rel="stylesheet" href="${context_path}/css/jquery.ui.all.css">
    <link rel="stylesheet" href="${context_path}/css/jquery.tocify.css">
    <link rel="stylesheet" href="${context_path}/css/prettify.css">

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
            <a href="/" class="navbar-brand">
                <div><strong>Java</strong>Lite
                    <img src="/images/javalite_feather.png" width="40px" height="40px" class="right">
                </div>
            </a>


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

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div id="twitter" style="margin-top: 13px;">
                        <iframe id="twitter-widget-0" scrolling="no" frameborder="0" allowtransparency="true"
                                src="http://platform.twitter.com/widgets/tweet_button.2df3b13213b70e6d91180bf64c17db20.en.html#_=1413385541881&amp;count=horizontal&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=http%3A%2F%2Fjavalite.io%2F&amp;size=m&amp;text=JavaLite%3A&amp;url=http%3A%2F%2Fjavalt.org&amp;via=ipolevoy"
                                class="twitter-share-button twitter-tweet-button twitter-share-button"
                                title="Twitter Tweet Button" data-twttr-rendered="true"
                                style="width: 108px; height: 20px;"></iframe>
                        <script>!function (d, s, id) {
                            var js, fjs = d.getElementsByTagName(s)[0];
                            if (!d.getElementById(id)) {
                                js = d.createElement(s);
                                js.id = id;
                                js.src = "//platform.twitter.com/widgets.js";
                                fjs.parentNode.insertBefore(js, fjs);
                            }
                        }(document, "script", "twitter-wjs");</script>
                    </div>
                </li>
                <li>
                    <div style="margin-top: 13px;">
                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                        <input type="hidden" name="cmd" value="_donations">
                        <input type="hidden" name="business" value="igor@polevoy.org">
                        <input type="hidden" name="lc" value="US">
                        <input type="hidden" name="item_name" value="Igor Polevoy">
                        <input type="hidden" name="no_note" value="0">
                        <input type="hidden" name="currency_code" value="USD">
                        <input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_SM.gif:NonHostedGuest">
                        <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                        <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                    </form>

                        </div>
                </li>

            </ul>

        </div>
    </div>
</div>


<script src="${context_path}/js/jquery-1.8.3.min.js"></script>
<script src="${context_path}/js/bootstrap.min.js"></script>
<script src="${context_path}/js/bootswatch.js"></script>
<script src="${context_path}/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${context_path}/js/jquery.tocify.js"></script>
<script src="${context_path}/js/prettify.js"></script>

<div class="container">
${page_content}
</div>

<div class="footer navbar-fixed-bottom">
    <div class="container">
        <span>
            © 2009 - 2014 Igor Polevoy. All JavaLite projects are released under <a
                href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache License, Version 2.0</a>
         </span>
        <span class="pull-right"><a href="#top">Back to top &#8593;</a></span>
    </div>
</div>
</body>
</html>
