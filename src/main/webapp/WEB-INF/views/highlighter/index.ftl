<@render partial="/common/highlighter_includes"/>


<h1>Includes</h1>
<pre class="brush: xml;">
    &lt;@render partial=&quot;/common/highlighter_includes&quot;/&gt;
</pre>



<h1>JavaScript:</h1>
<pre>
    &lt;pre class=&quot;brush: js;&quot;&gt;
        function helloSyntaxHighlighter()
        {
            return &quot;hi!&quot;;
        }
    &lt;/pre&gt;
</pre>
<pre class="brush: js;">
function helloSyntaxHighlighter()
{
	return "hi!";
}
</pre>


<h1>JSON:</h1>
<pre>
    &lt;pre class=&quot;brush: js;&quot;&gt;
        {
            &quot;message&quot; : &quot;hi!&quot;
        }
    &lt;/pre&gt;
</pre>
<pre class="brush: js;">
{
	"message" : "hi!"
}
</pre>


<h1>Java:</h1>

<pre>
    &lt;pre class=&quot;brush: java;&quot;&gt;
        public class Mail{
            public static void main(String[] args){
                System.out.println(&quot;Hello&quot;);
            }
        }
    &lt;/pre&gt;
</pre>

<pre class="brush: java;">
    public class Mail{
        public static void main(String[] args){
            System.out.println("Hello");
        }
    }
</pre>


<h1>XML:</h1>

<pre>
    &lt;pre class=&quot;brush: xml;&quot;&gt;
        &lt;message&gt;
            this is a message
        &lt;/message&gt;
    &lt;/pre&gt;
</pre>

<pre class="brush: xml;">
    <message>
        this is a message
    </message>
</pre>


<h1>HTML:</h1>
<pre>&lt;pre name=&quot;code&quot; class=&quot;brush: html;&quot;&gt;
    &lt;div class=&quot;hello&quot;&gt;this is a message&lt;/div&gt;;
&lt;/pre&gt;
</pre>
<pre name="code" class="brush: xml;">
    <div class="hello">this is a message</div>
</pre>

<h1>SQL:</h1>

<pre>
    &lt;pre name=&quot;code&quot; class=&quot;brush:sql;&quot;&gt;
      CREATE TABLE people (
      id  int(11) NOT NULL auto_increment PRIMARY KEY,
      name VARCHAR(56) NOT NULL,
      last_name VARCHAR(56),
      dob DATE,
      graduation_date DATE,
      created_at DATETIME,
      updated_at DATETIME
      );
    &lt;/pre&gt;
</pre>
<pre name="code" class="brush:sql;">
  CREATE TABLE people (
  id  int(11) NOT NULL auto_increment PRIMARY KEY,
  name VARCHAR(56) NOT NULL,
  last_name VARCHAR(56),
  dob DATE,
  graduation_date DATE,
  created_at DATETIME,
  updated_at DATETIME
  );
</pre>

<h1>Bash:</h1>
<pre>
    &lt;pre class=&quot;brush: bash;&quot;&gt;
        echo &quot;hello&quot;
    &lt;/pre&gt;
</pre>
<pre class="brush: bash;">
    echo "hello"
</pre>

