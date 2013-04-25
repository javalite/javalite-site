<@render partial="/common/highlighter_includes"/>

<h1>Edit page</h1>


<@form method="put" id=page.seo_id>

<h3>Title</h3>
<input name="title"  style="width: 400px" value="${page.title!""}"> <span class="error">${(errors.title)!""}</span>

<h3>Content</h3>

<a id="expand" href="javascript:void(0);" onclick="$('#cheatsheet').show('fast'); $('#expand').hide(); $('#collapse').show();">Expand cheat sheet</a>
<a id="collapse" href="javascript:void(0);" onclick="$('#cheatsheet').hide('fast'); $('#collapse').hide(); $('#expand').show();" style="display:none">Collapse cheat sheet</a>


<div id="cheatsheet" class="well" style="display: none">


<h3>Breadcrumbs</h3>
<pre >
&lt;ul class=&quot;breadcrumb&quot;&gt;
    &lt;li&gt;&lt;a href=&quot;/&quot;&gt;Home&lt;/a&gt; &lt;span class=&quot;divider&quot;&gt;/&lt;/span&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;/p/activejdbc&quot;&gt;ActiveJDBC&lt;/a&gt; &lt;span class=&quot;divider&quot;&gt;/&lt;/span&gt;&lt;/li&gt;
    &lt;li class=&quot;active&quot;&gt;REPLACE&lt;/li&gt;
&lt;/ul&gt;
&lt;h1&gt;ActiveJDBC&lt;/h1&gt;
&lt;div id=&quot;generated-toc&quot;&gt;&lt;/div&gt;
&lt;h2&gt;Design principles&lt;/h2&gt;
</pre>
<h3>Code</h3>
<pre>
&lt;pre name=&quot;code&quot; class=&quot;brush:java;&quot;&gt;
    code here
&lt;/pre&gt;
</pre>

<h3>Info box</h3>

    <pre>
    &lt;div class=&quot;row&quot;&gt;
          &lt;div class=&quot;span12&quot;&gt;
              &lt;div class=&quot;alert alert-info&quot;&gt;
                &lt;strong&gt;Info&lt;/strong&gt;
                &lt;p&gt;
                          In both cases, the text format for date and timestamp needs to conform to
                        &lt;a     href=&quot;http://download.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html&quot;&gt;java.text.SimpleDateFormat&lt;/a&gt;
                    &lt;/p&gt;
              &lt;/div&gt;
          &lt;/div&gt;
      &lt;/div&gt;

        </pre>
</div>


    <span class="error">${(errors.content)!""}</span><br>
    <textarea id="content" name="content" style="width: 100%; height: 400px">${page.content!""}</textarea>


<br>
<button type="submit">Submit</button>
<button onclick="$('#preview').html(''); $('#preview').html($('#content').val()); SyntaxHighlighter.highlight();return false;">Preview</button>

<a href="javascript:void(0);" onclick="$('#preview').html('')">Clear</a>
</@form>

<div id="preview"></div>
