

<h2>All pages</h2>

<@link_to action="new_form">New page</@link_to> | <@link_to controller="login">login</@link_to>

<hr>

<ul>
<#list pages as page>
    <li><@link_to id=page.seo_id>${page.seo_id}</@link_to>  | <@link_to id="${page.seo_id}/edit_form">Edit</@link_to></li>
</#list>
</ul>

