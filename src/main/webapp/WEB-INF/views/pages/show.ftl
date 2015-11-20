<@content for="title">${title!}</@content>


<div class="row" id="top">

    <div class="col-md-9">

    ${page}

        <hr>
        <div class="alert alert-danger bs-alert-old-docs">
            <strong>How to comment:</strong> <br>
            The comment section below is to discuss documentation on this page. <strong>If you have an issue, or
            discover bug </strong>, please follow instructions on the <a href="/support">Support page</a>
        </div>

        <div id="disquss"></div>
        <div id="disqus_thread"></div>
    </div>
    <div class="col-md-3">
        <div id="toc"></div>
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
            $(el).html($(el).html() + " &#8594;");
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
<noscript>Please enable JavaScript to view comments</noscript>



