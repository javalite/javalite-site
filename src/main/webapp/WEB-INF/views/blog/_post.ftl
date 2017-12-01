<div class="col-xs-12">
    <div class="blog-data">
        <img src="https://media.licdn.com/media/p/8/000/1d2/391/13e9e58.jpg" alt="${post.authorName!""}">
        <h5>
            <a href="/blog/author/${post.authorId}">${post.authorName}</a>
        </h5>
        <p class="m-b-0">
            Created
        ${post.published?string["MMM"]}
        ${post.published?string["dd"]}
        ${post.published?string["yyyy"]}
        </p>
    </div>

    <div class="content-styles">
        <h2>
            <a class="link-black" href="/blog/${post.year}/${post.month}/${post.day}/${post.slug}">${post.title}</a>
        </h2>
        <div class="blog-cnt">
            ${post.excerpt}
        </div>
        <div class="m-t-15">
            <a href="/blog/${post.year}/${post.month}/${post.day}/${post.slug}">Read more</a>
        </div>
    </div>

    <hr class="hr" />
</div>