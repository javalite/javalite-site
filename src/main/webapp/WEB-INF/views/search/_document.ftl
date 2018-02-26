<div class="row">
    <article class="col-xs-12">
        <h3>

            <#if document.type = "page">

            <a href="/${document.slug}">${document.title}</a>

            <#elseif document.type = "blog">

                <a href="/blog/${document.slug}">${document.title}</a>
            </#if>


        </h3>
        <p>
            ...${document.fragment}...
        </p>
    </article>
</div>
