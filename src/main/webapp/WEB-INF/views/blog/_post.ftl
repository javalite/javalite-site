<div class="row">

    <div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
        <h5>
            Posted by <a href="/blog/author/${post.authorId}"> <strong> ${post.authorName} </strong> </a> on
            ${post.published?string["MMM"]}
            ${post.published?string["dd"]}
            ${post.published?string["yyyy"]}
        </h5>
        <h2>${post.title}</h2>
        <div class="blog-cnt">
            ${post.excerpt}
        </div>
        <a class="b-next" href="/blog/${post.year}/${post.month}/${post.day}/${post.slug}">Read more </a>
    </div>
</div>