<div class="blog-data">
    <img src="https://media.licdn.com/media/p/8/000/1d2/391/13e9e58.jpg" alt="${post.authorName!""}">
    <h5>
        <a href="/blog/author/${post.authorId}">${post.authorName}</a>
    </h5>
    <p>
        Created
        ${post.published?string["MMM"]}
        ${post.published?string["dd"]}
        ${post.published?string["yyyy"]}
    </p>
</div>


<div class="content-styles">
    <h2>${post.title}</h2>
    <div class="blog-cnt">
        ${post.excerpt}
    </div>
    <a class="b-next" href="/blog/${post.year}/${post.month}/${post.day}/${post.slug}">Read more</a>
</div>
