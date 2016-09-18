<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>JavaLite - <@yield to="title"/></title>
        <link href="${context_path}/bootstrap.css" rel="stylesheet">
        <link rel="shortcut icon" href="/images/favicons/favicon.ico">
        <link rel="icon" sizes="16x16 24x24 32x32 48x48 64x64" href="/images/favicons/favicon.ico">
        <link rel="apple-touch-icon" sizes="57x57" href="/images/favicons/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/images/favicons/apple-icon-60x60.png" >
        <link rel="apple-touch-icon" sizes="72x72" href="/images/favicons/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/images/favicons/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/images/favicons/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/images/favicons/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/images/favicons/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/images/favicons/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/images/favicons/apple-icon-180x180.png" >
        <link rel="apple-touch-icon-precomposed" sizes="192x192" href="/images/favicons/apple-icon-precomposed.png">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-16x16.png" sizes="16x16" />
        <link rel="icon" type="image/png" href="/images/favicons/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-48x48.png" sizes="48x48">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-36x36.png" sizes="36x36">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-64x64.png" sizes="64x64">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-160x160.png" sizes="160x160">
        <link rel="icon" type="image/png" href="/images/favicons/favicon-192x192.png" sizes="192x192">
        <link rel="manifest" href="/images/favicons/android-chrome-manifest.json">
        <meta name="application-name" content="JavaLite">
        <meta name="msapplication-TileColor" content="#ef5350">
        <meta name="msapplication-TileImage" content="/images/favicons/apple-icon-144x144.png">
        <meta name="msapplication-config" content="/browserconfig.xml">

        <link href='https://fonts.googleapis.com/css?family=Roboto:600,400,300' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Inconsolata:400,700&subset=latin-ext' rel='stylesheet' type='text/css'>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
<body class="<@yield to='body_class' />">

<@render partial="header"/>
${page_content}
<@render partial="header"/>

</body>
</html>

<script>
    $(document).ready(function(){
        $(window).scroll(function () {
            if ($(this).scrollTop() > 0) {
                $('#scroller').fadeIn();
            } else {
                $('#scroller').fadeOut();
            }
        });
        $('#scroller').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 400);
            return false;
        });
    });
</script>