<@content for="title">JavaLite Blog</@content>

<div class="container blog min-height">
    <div class="page-header">
        <h1>Blog</h1>
    </div>

    <div class="row">
        <@render partial="post" collection=posts spacer="spacer"/>
    </div>

    <#if prev_page?has_content || next_page?has_content>
        <div class="blog-footer">
            <#if prev_page ??>
                <a href="?page=${prev_page}">Older posts</a>
            </#if>
            <#if prev_page?has_content && next_page?has_content><span>|</span></#if>
            <#if next_page ??>
                <a href="?page=${next_page}">Newer posts</a>
            </#if>
        </div>
    </#if>
</div>

<#--<@render partial="subscription"/>-->

<@render partial="script"/>