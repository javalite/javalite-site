
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