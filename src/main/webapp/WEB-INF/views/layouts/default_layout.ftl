<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>JavaLite - <@yield to="title"/></title>
    <link href="${context_path}/bootstrap.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>


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
                <li><a href="/documentation">Documentation</a></li>
                <li class="divider-vertical"></li>
                <li><a href="/javadoc">JavaDocs</a></li>
                <li><a href="/sources">Sources</a></li>
                <li><a href="/support">Support</a></li>
                <li><a href="/contributors">How to contribute</a></li>
                <li><a href="/blog">Blog</a></li>
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


<div class="subfooter">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2 class="block-h">JavaLite has been used by over 20K customers, including</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.amazon.com/">
                    <img src="/images/partners/logo-amazon.png" alt="Amazon">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.yahoo.com/">
                    <img src="/images/partners/logo-yahoo.png" alt="Yahoo">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.ebay.com/">
                    <img src="/images/partners/logo-ebay.png" alt="Ebay">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.edovo.com/">
                    <img src="/images/partners/logo-edovo.png" alt="Edovo">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.godaddy.com/">
                    <img src="/images/partners/logo-go-daddy.png" alt="Go Daddy">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="https://www.groupon.com/">
                    <img src="/images/partners/logo-groupon.png" alt="Groupon">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.realnetworks.com/">
                    <img src="/images/partners/logo-realnetworks.png" alt="Realnetworks">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.hp-enterprisesolutions.com/">
                    <img src="/images/partners/logo-hp.png" alt="Hewlett Packard Enterprise">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.barclays.co.uk/">
                    <img src="/images/partners/logo-barclays.png" alt="Barclays">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.navy.mil/">
                    <img src="/images/partners/logo-us-navy.png" alt="U.S. Navy">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="https://www.humana.com/">
                    <img src="/images/partners/logo-humana.png" alt="Humana">
                </a>
            </div>
            <div class="col-xxs-12 col-xs-4 col-md-2">
                <a href="http://www.flipkart.com/">
                    <img src="/images/partners/logo-flipkart.png" alt="Flipkart">
                </a>
            </div>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-6">
                <h2 class="block-h block-h-icon"><a href="#">Help us</a> to improve this page</h2>
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
                    © 2009 - ${year} Igor Polevoy.<br/>
                    All JavaLite projects are released under <a href="http://www.apache.org/licenses/LICENSE-2.0.html">Apache License, Version 2.0</a>
                </p>
            </div>
            <div class="col-xs-12 col-md-6 h-sm-40">
                <h2 class="block-h">We are supported by best tools companies</h2>
                <div class="row">
                    <div class="col-xxs-12 col-xs-6">
                        <a href="https://www.jetbrains.com/idea/">
                            <img src="/images/support/intellij-idea.png" alt="IntelliJ JDEA">
                        </a>
                    </div>
                    <div class="col-xxs-12 col-xs-6 h-xxs-20">
                        <a href="https://www.yourkit.com/">
                            <img src="/images/support/yourkit.png" alt="Yourkit">
                        </a>
                    </div>
                </div>
            </div>
        </div>
<#--        <span class="pull-right"><a href="#top">Back to top &#8593;</a></span>-->
    </div>
</footer>
</body>
</html>
