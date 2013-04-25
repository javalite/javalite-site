
<h1>Create new page</h1>


<@form method="post">


<h3>Title</h3>
<input name="title"  style="width: 400px" value="${request.title!""}"> <span class="error">${(errors.title)!""}</span>

<h3>SEO ID</h3>
<input name="seo_id" style="width: 400px" value="${request.seo_id!""}"><span class="error">${(errors.seo_id)!""}</span>

<h3>Content</h3>
<span class="error">${(errors.content)!""}</span><br>
<textarea name="content" style="width: 700px; height: 400px">${request.content!""}</textarea>

<br>
<button type="submit">Submit</button>
</@form>
