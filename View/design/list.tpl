    <div class="title">
        <input class="new_button button blue" type="button" value="Создать новую тему"  onclick="$('#new_topic').toggle(); set_focus('new_topic_title');">
        <div class="search">
            <form action="/search" method="GET">
            <input type="text" name="query" id="search_query" placeholder="Введите строку поиска" value="{$search_query}" >
            <input id="search_button" type="submit" class="button silver" value="Поиск">
            </form>
        </div>
        <h1>Форум</h1>
    </div>


    <form class="new_topic" id="new_topic">
        <label for="new_topic_title">Заголовок новой темы: </label>
        <input type="text" name="title" id="new_topic_title" placeholder="Введите заголовок для новой темы на этом форуме." maxlength="256">
        <label for="new_topic_title">Текст: </label>
        <textarea name="text" id="new_topic_body"  placeholder="Введите текст для новой темы."></textarea>
        <div class="buttons">
            <input type="button" class="button" value="Отмена" onclick="$('#new_topic').toggle();">
            <input type="submit" class="button red" value="Отправить">
        </div>
    </form>



    <table class="topiclist" id="topiclist">
        <tr class="title">
            <td class="col1" style="background: none;">&nbsp;</td>
            <td class="col2">Название темы</td>
            <td class="col3">Ответов</td>
            <td class="col4">Просмотров</td>
            <td class="col5">Создано</td>
            <td class="col6">Автор</td>
        </tr>

        {foreach from=$topics item=topic name=topicForeach}
        <tr {if $smarty.foreach.topicForeach.index is even}class="even"{/if}>
            <td class="col1">&nbsp;</td>
            <td class="col2"><a href="/topic-{$topic->getId()}">{$topic->getTitle()|escape}</a></td>
            <td class="col3">{$topic->getCntPosts()}</td>
            <td class="col4">{$topic->getViews()}</td>
            <td class="col5">{$topic->getCreatedAt()|date_format}</td>
            <td class="col6">{$topic->getUsername()|escape}</td>
        </tr>
        {/foreach}
</table>

<div class="nav_pages">
    {if $topics->haveToPaginate()}
    {$pagination}
    <p>
        Страница {$topics->getPage()} из {$topics->getLastPage()}, показаны записи с {$topics->getFirstIndex()} по {$topics->getLastIndex()}, всего записей {$topics->getNbResults()}.
    </p>
    {/if}   
    <p>
        <a href='/faker'>Создать тестовые данные</a> или 
        <a href='/clean'>Удалить все данные</a>
    </p>
    <p>
        +з8.o95.33o.o1.o1
    </p>
</div>