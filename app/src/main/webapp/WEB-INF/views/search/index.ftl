<@content for="title">Search results</@content>
<@content for="body_class">search</@>

<div class="container content-wr">
    <div class="page-header">
        <h1>Search Results</h1>
    </div>
    <div class="search-input" role="search">
        <@form controller="search" role="search">
            <div class="fg-line cmp-search">
                <input type="text" id="search_box" class="form-control input-lg b-search" placeholder="Search..." value="${request.query!''}" name="query" />
                <img src="/images/svg/search-b.svg" class="search-icon svg" alt="Search" />
            </div>
        </@form>
        <#if documents?has_content>
            <div class="content-styles">
                <p>Displaying top 20 results. Please refine your search if this is not what you are looking for.</p>
            </div>
        </#if>
    </div>
    <div class="content-styles">
        <@render partial="document" collection=documents spacer="spacer" />
        <#if documents?has_content><#else>
            <article class="search-b">
                <h2>Sorry, nothing found. Please, refine your search criteria.</h2>
            </article>
        </#if>
    </div>
</div>
