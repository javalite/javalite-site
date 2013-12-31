
<@content for="title">${(page.title)!""}</@content>


<script type="text/javascript">
    function scrollTo(id){
          $('html,body').animate({scrollTop: $("#"+id).offset().top - 50}, 'slow');
    }
</script>

<@render partial="/common/highlighter_includes"/>


<#if (session.user)??>
<ul class="breadcrumb">
    <li><@link_to>Pages</@link_to> <span class="divider">|</span></li>
    <li><@link_to id="${page.seo_id}/edit_form">Edit</@link_to>  <span class="divider">|</span></li>
        <li><@link_to controller="logout">Logout</@link_to> </li>
</ul>
</#if>

${page.content}

<hr/>


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
<noscript>Please enable JavaScript to view comments.</a>
</noscript>



