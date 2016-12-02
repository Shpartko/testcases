<?php namespace App;

include 'vendor/autoload.php';

$serviceContainer = \Propel\Runtime\Propel::getServiceContainer();
$connection = $serviceContainer->getWriteConnection("forum");
$pdo = new \DebugBar\DataCollector\PDO\TraceablePDO($connection->getWrappedConnection());
\App\Design::$debugbar->addCollector(new \DebugBar\DataCollector\PDO\PDOCollector($pdo));

$router = new \Phroute\Phroute\RouteCollector();
$router->get('/topic-{id:i}/{page:i}?', ['\App\Controllers\TopicController','topic']);
$router->get('/{page:i}?', ['\App\Controllers\TopicController','list']);
$router->post('/addTopic/', ['\App\Controllers\TopicController','add']);
$router->post('/addPost/', ['\App\Controllers\PostController','add']);
$router->get('/faker/', ['\App\Controllers\TopicController','faker']);
$router->get('/clean/', ['\App\Controllers\TopicController','clean']);
$router->get('/search/', ['\App\Controllers\TopicController','search']);

try {
    $dispatcher = new \Phroute\Phroute\Dispatcher($router->getData());
    $response = $dispatcher->dispatch($_SERVER['REQUEST_METHOD'], parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
    echo $response;
} catch (\Phroute\Phroute\Exception\HttpRouteNotFoundException $e) {
    echo "Boot error: route not found: ". $e->getMessage();
} catch (\Phroute\Phroute\Exception\HttpMethodNotAllowedException $e) {
    echo "Boot error: method not found: ". $e->getMessage();
}
