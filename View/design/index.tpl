<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>{$meta_title}</title>
  <link rel="stylesheet" href="/assets/css/reset.css" type="text/css"/>
  <link rel="stylesheet" href="/assets/css/style.css" type="text/css"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="/assets/js/forum.js"></script>


  <!--[if lt IE 9]>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
  <![endif]-->
</head>

<body>
    {$debugbar->renderHead()}
    <div class="page">
        {$content}
    </div>
    {$debugbar->render()}
</body>
</html>














