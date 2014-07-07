<#--<@content for="title">${(page.title)!""}</@content>-->

<#--Library from: http://www.webdevelopers.eu/shop/10/doc/index-->
<script type="text/javascript">
    $(function() {
        $("#toc").toc("h2, h3, h4", "simple:nohilite", 50);
    });
</script>



<@content for="title">${title!}</@content>


<#if breadcrumbs ??>
<ul class="breadcrumb">
    <li><a href="/">Home</a> <span class="divider">/</span></li>
    <#list breadcrumbs as br>
        <#if br_has_next >
            <li>${br}<span class="divider">/</span></li>
        <#else>
            <li>${br}</li>
        </#if>
    </#list>
</ul>
</#if>


${page}




<div style="height: 20px"></div>

<div id="disqus_thread"></div>
<script type="text/javascript">

    var disqus_shortname = 'javalite';

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function () {
        var dsq = document.createElement('script');
        dsq.type = 'text/javascript';
        dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view comments</noscript>



