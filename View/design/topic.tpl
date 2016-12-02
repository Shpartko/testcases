    <div class="title">
        <h1><a href="/">Форум</a> &rarr; {$topic->getTitle()|escape}</h1>
        <div class="topic_body">
            {$topic->getBody()|escape|nl2br}
        </div>
        <div class="creator">
            Создал {$topic->getUsername()|escape}, {$topic->getCreatedAt()|date_format}.
        </div>
        <input class="button blue" type="button" value="Написать новый ответ" onclick="$('#new_post').toggle(); set_focus('new_post_body');">
    </div>


    <form class="new_post" id="new_post">
        <input type="hidden" name="topic_id" id="topic_id" value="{$topic->getId()}">
        <label for="new_post_body">Ваш ответ в этой теме: </label>
        <textarea name="text" id="new_post_body"  placeholder="Введите текст своего ответа."></textarea>
        <div class="buttons">
            <input type="button" class="button" value="Отмена" onclick="$('#new_post').toggle();">
            <input type="submit" class="button red" value="Отправить">
        </div>
    </form>    
    

    <div class="delimiter"></div>

    {if ($topic->getPosts()|count==0)}      
        <div class="no_posts" id="no_posts">
        К сожалению, в этой теме ещё нет ни одного ответа.<br/><br/>
        <input class="button blue" type="button" value="Написать новый ответ" onclick="$('#new_post').toggle(); set_focus('new_post_body');">
        </div>
        <table class="posts" id="posts">
        <tbody id="post_before">
        </tbody>
        </table>
    {else}
        <table class="posts" id="posts">
            <tbody id="post_before">
            {foreach from=$topic->getPosts() item=post key=postKey name=postForeach}
            <tr {if $smarty.foreach.postForeach.index is even}class="even"{/if}>
                <td>
                    <p class="post_date">{$post->getCreatedAt()|date_format}, {$post->getUsername()}</p><br/>
                    <p class="post_key">#{$postKey+1}</p>
                    <p>
                    {$post->getText()|escape|nl2br}
                    </p>
                </td>
            </tr>        
            {/foreach}
            </tbody>
        </table>        
    {/if}
