<?php namespace App\Controllers;

use Respect\Validation\Validator as v;

class TopicController
{
    public function list($page = 1)
    {
        \App\Design::$debugbar['time']->startMeasure('db-topics-list', 'Topics Query');
        //$topics = \App\Model\TopicQuery::create()->orderByCreatedAt('desc')->paginate($page, $maxPerPage = 10);
        $topics = \App\Model\TopicQuery::create()
            ->leftJoin('Post')
            ->withColumn('count(Post.ID)', 'cntPosts')
            ->groupBy('Topic.Id')
            ->orderByCreatedAt('desc')->paginate($page, $maxPerPage = 10);
        \App\Design::$debugbar['time']->stopMeasure('db-topics-list');
        if ($topics->haveToPaginate()) {
            \App\Design::assign('pagination', \App\Design::pagination($topics->getLastPage(), $topics->getPage(), true, '/'));
        }
        \App\Design::assign('topics', $topics);
        \App\Design::assign('page', $page);
        \App\Design::assign('meta_title', 'Темы');
        if ($topics->getPage()>1) {
            \App\Design::assign('meta_title', 'Темы &rarr; Страница №'.$topics->getPage());
        }
        return \App\Design::fetch('list.tpl');
    }

    public function topic($id, $page = 1)
    {
        \App\Design::$debugbar['time']->startMeasure('db-topics-list', 'Topics Query');
        $topic = \App\Model\TopicQuery::create()->findPK($id);
        \App\Design::$debugbar['time']->stopMeasure('db-topics-list');
        if (!$topic) {
            return \App\Design::fetch('404.tpl');
        }
        $topic->setViews($topic->getViews() + 1);
        $topic->save();

        \App\Design::assign('topic', $topic);
        \App\Design::assign('meta_title', $topic->getTitle());
        return \App\Design::fetch('topic.tpl');
    }

    public function add()
    {
        $result = new \stdClass();
        $result->id=0;
        $result->message='';

        if (!v::stringType()->length(5, 256)->validate($_POST['title'])) {
            $result->message='Заголовок должен быть от 5 до 256 символов';
            return \App\Design::json($result);
        }
        if (!v::stringType()->length(5, 1024)->validate($_POST['text'])) {
            $result->message='Текст должен быть от 5 до 1024 символов';
            return \App\Design::json($result);
        }

        try {
            $topic = new \App\Model\Topic();
            $topic->setTitle($_POST['title']);
            $topic->setBody($_POST['text']);
            $topic->setUsername($_SERVER['REMOTE_ADDR']);
            $topic->setViews(0);
            $topic->save();
            $result->id=$topic->getId();
        } catch (Exception $e) {
            $result->message=$e->getMessage();
        }
        return \App\Design::json($result);
    }

    public function faker()
    {
        $faker = \Faker\Factory::create();
        for ($i=0; $i < 15; $i++) {
            $topic = new \App\Model\Topic();
            $topic->setTitle($faker->realText($maxNbChars = rand(50, 200), $indexSize = 2) );
            $topic->setBody($faker->realText($maxNbChars = rand(200, 1024), $indexSize = 2) );
            $topic->setCreatedAt($faker->dateTimeThisYear);
            $topic->setUsername($faker->name);
            $topic->setViews($faker->randomDigitNotNull);
            $topic->save();

            for ($ii=0; $ii < rand(5, 50); $ii++) {
                $post = new \App\Model\Post();
                $post->setText($faker->realText($maxNbChars = rand(500, 1024), $indexSize = 2) );
                $post->setUsername($faker->name);
                $post->setTopic($topic);
                $post->save();
            }
        }
        header("Location: /");
        exit;
    }

    public function clean()
    {
        \App\Model\PostQuery::create()->deleteAll();
        \App\Model\TopicQuery::create()->deleteAll();
        header("Location: /");
        exit;
    }

    public function search()
    {
        \App\Design::assign('meta_title', 'Нет поиска :(');
        return \App\Design::fetch('search.tpl');
    }
}
