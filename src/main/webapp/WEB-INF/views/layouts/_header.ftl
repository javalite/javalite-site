
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
                <li <#if id == "blog">class="active"</#if>><a href="/blog">Blog</a></li>
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