




    <table class="table table-striped table-bordered table-hover" id="topiclist">
        <tr class="title">
            <td class="col2">Название темы</td>
            <td class="col3">Ответов</td>
            <td class="col4">Просмотров</td>
            <td class="col5">Создано</td>
            <td class="col6">Автор</td>
        </tr>

        {foreach from=$topics item=topic name=topicForeach}
        <tr>
            <td class="col2"><a href="/topic-{$topic->getId()}">{$topic->getTitle()|escape}</a></td>
            <td class="col3">{$topic->getCntPosts()}</td>
            <td class="col4">{$topic->getViews()}</td>
            <td class="col5">{$topic->getCreatedAt()|date_format}</td>
            <td class="col6">{$topic->getUsername()|escape}</td>
        </tr>
        {/foreach}
</table>


    {if $topics->haveToPaginate()}
    <div class="nav_pages">
        {$pagination}
    </div>
    {/if}



<div class="panel panel-default">
  <div class="panel-body">

    {if $topics->haveToPaginate()}
    <p  class="text-center">
        Страница {$topics->getPage()} из {$topics->getLastPage()}, показаны записи с {$topics->getFirstIndex()} по {$topics->getLastIndex()}, всего записей {$topics->getNbResults()}.
    </p>
    {/if}
    <p class="text-center">
        <a href='/faker' class="btn btn-success">Создать тестовые данные</a> или
        <a href='/clean' class="btn btn-danger">Удалить все данные</a>
    </p>

  </div>
</div>

