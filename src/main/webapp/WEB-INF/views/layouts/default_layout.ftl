<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>JavaLite - <@yield to="title"/></title>
        <link href="${context_path}/bootstrap.css" rel="stylesheet">
        <link rel="shortcut icon" href="/images/favicons/favicon.ico">
        <link rel="icon" sizes="16x16 24x24 32x32 48x48 64x64" href="/images/favicons/favicon.ico">
        <link rel="apple-touch-icon" sizes="57x57" href="/images/favicons/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/images/favicons/apple-icon-60x60.png" >
        <link rel="apple-touch-icon" sizes="72x72" href="/images/favicons/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/images/favicons/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/images/favicons/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/images/favicons/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/images/favicons/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/images/favicons/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/images/favicons/apple-icon-180x180.png" >
        <link rel="apple-touch-icon-precomposed" sizes="192x192" href="/images/favicons/apple-icon-precomposed.png">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-16x16.png" sizes="16x16" />
        <link rel="icon" type="image/png" href="/images/favicons/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-48x48.png" sizes="48x48">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-36x36.png" sizes="36x36">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-64x64.png" sizes="64x64">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-160x160.png" sizes="160x160">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-192x192.png" sizes="192x192">
        <link rel="manifest" href="/images/favicons/android-chrome-manifest.json">
        <meta name="application-name" content="JavaLite">
        <meta name="msapplication-TileColor" content="#ef5350">
        <meta name="msapplication-TileImage" content="/images/favicons/apple-icon-144x144.png">
        <meta name="msapplication-config" content="/browserconfig.xml">

        <link href='https://fonts.googleapis.com/css?family=Roboto:600,400,300' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Inconsolata:400,700&subset=latin-ext' rel='stylesheet' type='text/css'>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
<body class="<@yield to='body_class' />">

<header class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header pull-left clearfix">
            <a href="/" class="navbar-brand">
                <span>
                    <img src="/images/svg/logo-img.svg" class="svg">
                </span>
                <img src="/images/svg/logo-txt.svg" class="svg">
            </a>
        </div>
        <button class="navbar-toggle pull-right" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">
                <li <#if id == "documentation">class="active"</#if>><a href="/documentation">Documentation</a></li>
                <li class="divider-vertical"></li>
                <li <#if id == "javadoc">class="active"</#if>><a href="/javadoc">JavaDocs</a></li>
                <li <#if id == "sources">class="active"</#if>><a href="/sources">Sources</a></li>
                <li <#if id == "support">class="active"</#if>><a href="/support">Support</a></li>
                <li <#if id == "contributors">class="active"</#if>><a href="/contributors">How to contribute</a></li>
                <#--<li><a href="/blog">Blog</a></li>-->
            </ul>
            <a class="github" href="https://github.com/javalite">
                <img style="position: absolute; top: 0; right: 0; border: 0;" src="/images/github.png" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png">
            </a>
        </div>
    </div>
</header>

<script src="/js/jquery-1.8.3.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootswatch.js"></script>
<script src="/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="/js/jquery.tocify.js"></script>
<script src="/js/prettify.js"></script>
<script src="/js/svg_convert.js"></script>

${page_content}

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-6">
                <h4 class="block-h">We are supported by best tools companies</h4>
                <div class="row">
                    <div class="col-xxs-12 col-xs-6 support-idea">
                        <a href="https://www.jetbrains.com/idea/">
                            <img src="/images/support/intellij-idea.svg" alt="IntelliJ JDEA">
                        </a>
                    </div>
                    <div class="col-xxs-12 col-xs-6 h-xxs-20 support-yourkit">
                        <a href="https://www.yourkit.com/">
                            <img src="/images/support/yourkit.svg" alt="Yourkit">
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 h-sm-40">
                <h4 class="block-h block-h-icon"><a href="#">Help us</a> to improve this page</h4>
                <span class="footer-donate">
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
                </span>
                <p>
                    &#169; 2009 - ${year} Igor Polevoy.<br/>
                    All JavaLite projects are released under <a href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache License, Version 2.0</a>
                </p>
            </div>
        </div>
    </div>
    <div class="to-top" id="scroller">&#9650;</div>
</footer>
</body>
</html>

<script>
    $(document).ready(function(){
        $(window).scroll(function () {
            if ($(this).scrollTop() > 0) {
                $('#scroller').fadeIn();
            } else {
                $('#scroller').fadeOut();
            }
        });
        $('#scroller').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 400);
            return false;
        });
    });
</script>