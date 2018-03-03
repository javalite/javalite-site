<article class="search-b">
    <h2>
        <#if document.type = "page">
            <a href="/${document.slug}">${document.title}</a>
        <#elseif document.type = "blog">
            <a href="/blog/${document.slug}">${document.title}</a>
        </#if>
    </h2>
    <p>
        ...${document.fragment}...
    </p>
</article>
