<?php namespace App\Controllers;

use Respect\Validation\Validator as v;

class PostController
{
    public function add()
    {
        $result = new \stdClass();
        $result->id=0;
        $result->message='';

        if (!v::stringType()->length(5, 1024)->validate($_POST['text'])) {
            $result->message='Текст должен быть от 5 до 1024 символов';
            return \App\Design::json($result);
        }
        if (!v::intVal()->validate($_POST['topic_id'])) {
            $result->message='Некорректный топик';
            return \App\Design::json($result);
        }

        try {
            $topic = \App\Model\TopicQuery::create()->findPK($_POST['topic_id']);
            if (!$topic) {
                $result->message="Тема с ID {$_POST['topic_id']} на форуме не найдена";
                return \App\Design::json($result);
            }

            $post = new \App\Model\Post();
            $post->setText($_POST['text']);
            $post->setUsername($_SERVER['REMOTE_ADDR']);
            $post->setTopicId($_POST['topic_id']);
            $post->save();
            $result->id=$post->getId();
        } catch (Exception $e) {
            $result->message=$e->getMessage();
        }
        return \App\Design::json($result);
    }
}
