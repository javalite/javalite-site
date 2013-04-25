<h2>Generate hash for password:</h2>
<@form action="generate" method="post">
<input name="password" type="password"> <span style="font-size: large">= <@flash name="hash"/> </span>
</@form>