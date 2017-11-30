<@content for="title">${post.title!""}</@content>
<@content for="body_class">blog-page</@>

<div class="container">
    <div class="blog blog-single">
        <div class="page-header">
            <h1>${post.title!""}</h1>
        </div>
        <div class="blog-data">
            <img src="https://media.licdn.com/media/p/8/000/1d2/391/13e9e58.jpg" alt="${post.authorName!""}">
            <h5>
                <a href="/blog/author/${post.authorId!""}">${post.authorName!""}</a>
            </h5>
            <p>
                Created
                ${post.published?string["MMM"]}
                ${post.published?string["dd"]}
                ${post.published?string["yyyy"]}
            </p>
        </div>
        <div class="content-styles">
            ${post.content!""}
        </div>

        <div class="row">
            <div class="all-posts col-xs-12 col-sm-12 col-md-8 col-md-offset-2" style="margin-top:0;">
                <#if next??>
                    <a href="/blog/${next.year}/${next.month}/${next.day}/${next.slug}">Previous</a>
                </#if>
                <#if prev?has_content && next?has_content>|</#if>
                <#if prev??>
                    <a href="/blog/${prev.year}/${prev.month}/${prev.day}/${prev.slug}">Next</a>
                </#if>
            </div>
        </div>
    </div>

    <div class="blog">
        <@render partial="subscription"/>
    </div>

    <div id="disqus_thread"></div>
</div>

<@render partial="disquss"/>