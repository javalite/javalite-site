<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le styles -->
    <link href="/css/bootswatch/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/bootswatch/bootstrap-responsive.css" rel="stylesheet"/>
    <link href="/css/bootswatch/docs.css" rel="stylesheet"/>

    <link href="/css/main.css" rel="stylesheet"/>
    <script src="/js/bootswatch/jquery.js"></script>
    <script src="/js/bootswatch/bootstrap-dropdown.js"></script>
    <script src="/js/bootswatch/bootstrap-scrollspy.js"></script>
    <script src="/js/bootswatch/bootstrap-collapse.js"></script>
    <script src="/js/bootswatch/bootstrap-tooltip.js"></script>
    <script src="/js/aw.js" type="text/javascript"></script>

    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-23019901-1']);
        _gaq.push(['_setDomainName', "bootswatch.com"]);
        _gaq.push(['_setAllowLinker', true]);
        _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();
        function igor() {
            $("#igor").css("display", "block");
        }
    </script>

    <title>JavaLite: <@yield to="title"/></title>
</head>

<body data-spy="scroll" data-target=".subnav" data-offset="50">

<#include "header.ftl" >
<div class="container">
${page_content}
    <#include "footer.ftl" >
</div>


</body>
</html>
