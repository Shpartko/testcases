
    <div class="panel panel-default">
      <div class="panel-body">
            <h1>{$topic->getTitle()|escape}</h1>
            <p class="text-primary">
                {$topic->getBody()|escape|nl2br}
            </p>
            <p>
                <span href="#">Создано <span class="badge">{$topic->getCreatedAt()|date_format}, {$topic->getUsername()}</span></span>
            </p>
      </div>
    </div>




    <div class="delimiter"></div>

    {if ($topic->getPosts()|count==0)}

        <div class="jumbotron">
          <h1>Печалька :(</h1>
          <p>К сожалению, в этой теме ещё нет ни одного ответа.</p>
        </div>
    {else}
        <h2 class="text-center">Ответы посетителей:</h2>
        <br>
        <table class="table table-striped table-bordered table-hover" id="posts">
            <tbody id="post_before">
            {foreach from=$topic->getPosts() item=post key=postKey name=postForeach}
            <tr {if $smarty.foreach.postForeach.index is even}class="even"{/if}>
                <td>
                    <br>
                    <span># <span class="badge">{$postKey+1}</span></span>
                    <span class="pull-right">Создано <span class="badge">{$post->getCreatedAt()|date_format}, {$post->getUsername()}</span></span>
                    <hr>
                    <p>
                        {$post->getText()|escape|nl2br}
                    </p>
                </td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    {/if}

    <div class="panel panel-default" id="new_post" style="display:none;">
      <div class="panel-body bg-success">

        <form class="new_post" id="new_post">
          <div class="form-group">
            <label for="new_post_body">Ваш ответ в этой теме: </label>
            <textarea name="text" id="new_post_body" class="form-control" placeholder="Введите текст своего ответа."></textarea>
          </div>
          <input type="hidden" name="topic_id" id="topic_id" value="{$topic->getId()}">
          <input type="button" class="btn" value="Отмена" onclick="$('#new_post').toggle();">
          <input type="submit" class="btn btn-default" value="Отправить">
        </form>

      </div>
    </div>

    <div style="text-center">
        <input class="btn btn-block btn-primary" type="button" value="Написать новый ответ" onclick="$('#new_post').toggle(); set_focus('new_post_body');">
    </div>
