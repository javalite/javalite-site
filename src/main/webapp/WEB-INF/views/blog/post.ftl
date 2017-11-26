<@content for="title">${post.title!""}</@content>
<@content for="body_class">blog-page</@>

<div class="container">
    <div class="blog blog-single">
        <div class="row">
            <div class="col-xs-12 col-sm-10 col-md-8 col-xs-offset-0 col-sm-offset-1 col-md-offset-2">
                <article>
                    <header>
                        <div class="clearfix">
                            <h5 class="pull-left">
                                ${post.published?string["MMM"]}
                                ${post.published?string["dd"]}
                                ${post.published?string["yyyy"]}
                            </h5>

                        </div>
                        <h1>${post.title!""}</h1>
                    </header>

                    <div class="blog-cnt">
                        ${post.content!""}
                    </div>
                    <div class="blog-autor-wr">
                        <div class="blog-autor">
                            <div class="blog-autor-txt">
                                <span>Posted By</span>
                                <a href="/blog/author/${post.authorId!""}">${post.authorName!""}</a>
                            </div>
                        </div>
                    </div>
                </article>
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
        </div>
    </div>

    <div class="blog">
        <@render partial="subscription"/>
    </div>

    <div class="blog">
        <div class="row">
            <div class="col-xs-12 col-sm-10 col-md-8 col-xs-offset-0 col-sm-offset-1 col-md-offset-2">
                <div id="disqus_thread"></div>

            </div>
        </div>
    </div>
</div>

<@render partial="disquss"/>