<@content for="title">JavaLite Blog</@content>

<div class="container blog min-height">
    <div class="page-header">
        <h1>Blog</h1>
    </div>

    <@render partial="post" collection=posts spacer="spacer"/>
    <div class="row">
        <div class="all-posts col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
            <#if prev_page ??>
                <a href="?page=${prev_page}">Older posts</a>
            </#if>
            <#if prev_page?has_content && next_page?has_content>|</#if>
            <#if next_page ??>
                <a href="?page=${next_page}">Newer posts</a>
            </#if>
        </div>
    </div>

    <hr class="visible-xs" />
</div>


<@render partial="subscription"/>
