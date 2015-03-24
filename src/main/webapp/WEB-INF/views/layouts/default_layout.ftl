<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>JavaLite - <@yield to="title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="/css/bootswatch.css">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/jquery.ui.all.css">
    <link rel="stylesheet" href="/css/jquery.tocify.css">
    <link rel="stylesheet" href="/css/prettify.css">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="/js/html5shiv.js"></script>
    <script src="/js/respond.min.js"></script>
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

                <li><a href="/documentation">Documentation</a></li>


                <li class="divider-vertical"></li>

                <li><a href="/javadoc">JavaDocs</a></li>
                <li><a href="/sources">Sources</a></li>

                <li><a href="/support">Support</a></li>
                <li><a href="/contributors">How to contribute</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>

                    <div id="twitter" style="margin-top: 13px;">
                        <iframe id="twitter-widget-0" scrolling="no" frameborder="0" allowtransparency="true"
                                src="http://platform.twitter.com/widgets/tweet_button.2df3b13213b70e6d91180bf64c17db20.en.html#_=1413385541881&amp;count=horizontal&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=http%3A%2F%2Fjavalite.io%2F&amp;size=m&amp;text=JavaLite%3AJava, light as a feather...&amp;url=http%3A%2F%2Fjavalite.io&amp;via=ipolevoy"
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


                </li>

            </ul>
            <a href="https://github.com/javalite"><img style="position: absolute; top: 0; right: 0; border: 0;"
                                                  src="https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67"
                                                  alt="Fork me on GitHub"
                                                  data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png"></a>

        </div>
    </div>
</div>


<script src="/js/jquery-1.8.3.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootswatch.js"></script>
<script src="/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="/js/jquery.tocify.js"></script>
<script src="/js/prettify.js"></script>

<div class="container">
${page_content}
</div>

<div class="footer navbar-fixed-bottom">
    <div class="container">
        <span class="pull-left">
            © 2009 - ${year} Igor Polevoy. All JavaLite projects are released under <a
                href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache License, Version 2.0</a>


         </span>

        <span class="pull-left" style="margin-left: 20px">
                <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                    <input type="hidden" name="cmd" value="_donations">
                    <input type="hidden" name="business" value="igor@polevoy.org">
                    <input type="hidden" name="lc" value="US">
                    <input type="hidden" name="item_name" value="Igor Polevoy">
                    <input type="hidden" name="no_note" value="0">
                    <input type="hidden" name="currency_code" value="USD">
                    <input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_SM.gif:NonHostedGuest">
                    <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif"
                           border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                    <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1"
                         height="1">
                </form>
        </span>
        <span class="pull-right"><a href="#top">Back to top &#8593;</a></span>
    </div>
</div>
</body>
</html>
