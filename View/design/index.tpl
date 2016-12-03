<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$meta_title}</title>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/css/sticky-footer-navbar.css" rel="stylesheet">
  </head>
  <body>

    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container text-center">
        <div class="navbar-header">
          <a class="navbar-brand" href="/">Форум</a>
          <a class="navbar-brand" href="#">&rarr;</a>
          <a class="navbar-brand" href="#">{$meta_title}</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li>
		        <div class="form-group" style="padding-top:8px; margin-bottom: 0px;">
			        <div class="row">
			            <form action="/search" method="GET">
			        	<div class="col-sm-12">
				            <input class="form-control" type="text" name="query" id="search_query" placeholder="Что найти? + Enter" value="{$search_query}" >
			            </div>
			            </form>
			        </div>
		        </div>
            </li>
            <li><a href="#" onclick="$('#new_topic').toggle(); set_focus('new_topic_title');">Создать новую тему</a></li>
          </ul>
        </div><!--/.nav-collapse -->

      </div>
    </nav>

    <!-- Begin page content -->
    <div class="container">
    	<br>
	    <div class="panel panel-default" id="new_topic" style="display:none;">
	      <div class="panel-body bg-success">

	        <form class="new_topic" id="new_topic">
	          <div class="form-group">
	            <label for="new_topic_title">Заголовок новой темы: </label>
	            <input type="text" name="title" id="new_topic_title" class="form-control" placeholder="Введите заголовок для новой темы на этом форуме." maxlength="256">

	          </div>
	          <div class="form-group">
	            <label for="new_topic_title">Текст: </label>
	            <textarea name="body" id="new_topic_body" class="form-control"  placeholder="Введите текст для новой темы."></textarea>
	          </div>
	          <input type="button" class="btn" value="Отмена" onclick="$('#new_topic').toggle();">
	          <input type="submit" class="btn btn-default" value="Отправить">
	        </form>

	      </div>
	    </div>

      {$debugbar->renderHead()}
        {$content}
      {$debugbar->render()}
    </div>

    <footer class="footer">
      <div class="container">
        <p class="text-muted text-center"> <span class="glyphicon glyphicon-phone-alt" aria-hidden="true"></span> +з8.o95.33o.o1.o1</p>
      </div>
    </footer>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="/assets/js/forum.js"></script>
    <script src="/assets/js/bootstrap.min.js"></script>

  </body>
</html>