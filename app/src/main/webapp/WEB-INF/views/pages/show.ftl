<@content for="title">${title!}</@content>

<#if (page.breadCrumbs?size > 0) >
<div class="breadcrumbs">
    <div class="container">
        <ol>
            <#list page.breadCrumbs as bc>
                <li>
                    <a href="${bc.href}">${bc.text}</a>
                </li>
            </#list>
            <li>
                ${page.title}
            </li>
        </ol>
    </div>
</div>
</#if>


<div class="container content-wr">
    <div class="row" id="top">
        <div class="col-md-4" id="right-menu">
            <a href="#" class="right-menu-a">
                Page menu
                <span class="right-menu-lines">
                    <span>&nbsp;</span>
                    <span>&nbsp;</span>
                    <span>&nbsp;</span>
                </span>
            </a>
            <div class="right-menu" id="toc"></div>
        </div>
        <div class="col-md-8 content-styles" id="main-content">
            ${page.content}
            <hr class="hr"/>
            <div class="alert bs-alert-old-docs">
                <h4 class="block-h">How to comment</h4>
                <p>The comment section below is to discuss documentation on this page.</p>
                <p>If you <strong>have an issue, or discover bug</strong>, please follow instructions on the <a href="/support">Support page</a></p>
            </div>
            <div id="disquss"></div>
            <div id="disqus_thread"></div>
        </div>
    </div>
</div>


<script type="text/javascript">

    <#--See: http://gregfranko.com/jquery.tocify.js/-->
    $(document).ready(function () {
        $("#toc").tocify({
            hashGenerator: function (text, element) {
                return $(element).attr("id");
            },
            hideEffect: "none",
            scrollTo: 40,
            selectors: "h2,h3"
        });

        //add arrows to parent elements
        $("ul[class='tocify-subheader nav nav-list']").prev().children().each(function (index, el) {
            $(el).html($(el).html() + " &#43;");
        });

        //pandoc cannot do it!
        $("table").each(function (index, el) {
            $(el).addClass("table table-border")
        });
    });

    var disqus_shortname = 'javalite';

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function () {
        var dsq = document.createElement('script');
        dsq.type = 'text/javascript';
        dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        document.getElementById("disquss").appendChild(dsq);
    })();
</script>

<script type="text/javascript">
    (function(){
        var a = document.querySelector('#right-menu'), b = null, P = 60;
        window.addEventListener('scroll', Ascroll, false);
        document.body.addEventListener('scroll', Ascroll, false);
        function Ascroll() {
            if (b == null) {
                var Sa = getComputedStyle(a, ''), s = '';
                for (var i = 0; i < Sa.length; i++) {
                    if (Sa[i].indexOf('overflow') == 0 || Sa[i].indexOf('padding') == 0 || Sa[i].indexOf('border') == 0 || Sa[i].indexOf('outline') == 0 || Sa[i].indexOf('box-shadow') == 0 || Sa[i].indexOf('background') == 0) {
                        s += Sa[i] + ': ' +Sa.getPropertyValue(Sa[i]) + '; '
                    }
                }
                b = document.createElement('div');
                b.style.cssText = s + ' box-sizing: border-box; width: ' + a.offsetWidth + 'px;';
                a.insertBefore(b, a.firstChild);
                var l = a.childNodes.length;
                for (var i = 1; i < l; i++) {
                    b.appendChild(a.childNodes[1]);
                }
                a.style.height = b.getBoundingClientRect().height + 'px';
                a.style.padding = '0';
                a.style.border = '0';
            }
            var Ra = a.getBoundingClientRect(),
                    R = Math.round(Ra.top + b.getBoundingClientRect().height - document.querySelector('#main-content').getBoundingClientRect().bottom);  // селектор блока, при достижении нижнего края которого нужно открепить прилипающий элемент
            if ((Ra.top - P) <= 0) {
                if ((Ra.top - P) <= R) {
                    b.className = 'stop';
                    b.style.top = - R +'px';
                } else {
                    b.className = 'sticky';
                    b.style.top = P + 'px';
                }
            } else {
                b.className = '';
                b.style.top = '';
            }
            window.addEventListener('resize', function() {
                a.children[0].style.width = getComputedStyle(a, '').width
            }, false);
        }
    })()
</script>

<script type="text/javascript">
    $(document).ready(function(){
        $('.right-menu-a').click(function(){
            $(this).next('.right-menu').toggle('normal');
            return false;
        });

        if($("h2").size() == 0 && $("h2").size() == 0){
            $("#right-menu").hide();
        }
    });
</script>


<noscript>Please enable JavaScript to view comments</noscript>



