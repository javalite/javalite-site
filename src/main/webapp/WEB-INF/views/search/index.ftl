<@content for="title">Search results</@content>
<@content for="body_class">search</@>


<style>
    .highlighted{
        font-weight: bold;
    }
</style>

<div class="container">
    <div class="solutions">
        <div class="solutions-head">
            <h1>Search Results</h1>
        </div>
        <@form controller="search" class="search-mobile" role="search">
            <div class="fg-line cmp-search">
                <input type="text" id="search_box" class="form-control input-lg b-search" placeholder="Search..." value="${request.query!''}" name="query">

            </div>
        </@form>
    </div>
    <div class="search-wr">
        <@render partial="document" collection=documents spacer="spacer" />
        <div class="row">
            <div class="col-xs-12">
                <hr />
                <#if documents?has_content>
                    <p>Displaying top 20 results. Please refine your search if this is not what you are looking for.</p>
                <#else>
                    <p>Sorry, nothing found. Please, refine your search criteria.</p>
                </#if>
            </div>
        </div>
    </div>
</div>
