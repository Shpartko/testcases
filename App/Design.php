<?php namespace App;

class Design
{
    protected static $smarty;
    protected static $_instance = null;
    public static $debugbar;

    public static function getInstance()
    {
        if (static::$_instance != null) {
            return static::$_instance;
        }
        static::$debugbar = new \DebugBar\StandardDebugBar();
        static::$smarty = new \Smarty();
        static::$smarty->debugging = false;
        static::$smarty->caching = false;
        //static::$smarty->error_reporting = E_ALL & ~E_NOTICE;
        static::$smarty->error_reporting = false;
        static::$smarty->template_dir ='View/design/';
        static::$smarty->cache_dir = 'View/cache/';
        static::$smarty->compile_dir  ='View/compiled/';
        static::$_instance = new static();
        return static::$_instance;
    }

    public static function assign($var, $value)
    {
        return static::$smarty->assign($var, $value);
    }

    public static function fetch($template)
    {
        static::assign('debugbar', static::$debugbar->getJavascriptRenderer());
        static::assign('content', static::$smarty->fetch($template));
        $wrapper = static::$smarty->getTemplateVars('wrapper');
        if (empty($wrapper)) {
            $wrapper = 'index.tpl';
        }
        return static::$smarty->fetch($wrapper);
    }

    public static function json($data = array())
    {
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
    public static function jsonp($data = array())
    {
        header('Content-Type: application/json');
        if (!isset($_GET['callback'])) {
            $this->error_json('This is not jsonp query. Get query callback required.');
        }
        echo $_GET['callback']."([".json_encode($data)."])";
        exit;
    }
 
    public static function pagination($pages, $page, $curr_class = false, $url_prefix = "/", $url_sufix = "", $center = 3, $without_paging = 15)
    {
        $result='';


        if ($page>$pages) {
            $page=$pages;
        }
        
        if ($pages<($without_paging+1)) {
            for ($i = 1; $i <= $pages; $i++) {
                    $incl="";
                if (($i==$page) and ($curr_class==true)) {
                    $incl=" class='selected' ";
                }
                    $result .= " <a $incl href='$url_prefix$i$url_sufix'>".$i.'</a> ';
            }
        } else {
            $begin=$page-$center;
            if ($begin<=0) {
                $begin=1;
            }
            $end=$begin+($center*2);
            if ($end>$pages) {
                $begin=$begin-($end-$pages);
                $end=$pages;
            }
            
            if ($begin>1) {
                $end2=3;
                if ($page>$end2) {
                    $end2=$begin-1;
                }
                if ($end2>3) {
                    $end2=3;
                }
                for ($i = 1; $i <= $end2; $i++) {
                    $incl="";
                    if (($i==$page) and ($curr_class==true)) {
                        $incl=" class='selected' ";
                    }
                    $result .=  " <a $incl href='$url_prefix$i$url_sufix'>".$i.'</a> ';
                }
                $result .=  '&#183;&#183;&#183;';
            }
            
            
            for ($i = $begin; $i <= $end; $i++) {
                $incl="";
                if (($i==$page) and ($curr_class==true)) {
                    $incl=" class='selected' ";
                }
                $result .=  " <a $incl href='$url_prefix$i$url_sufix'>".$i.'</a> ';
            }
            
            if ($pages>$page) {
                $begin2=$pages-2;
                if ($i>$begin2) {
                    $begin2=$i;
                }
                if ($pages>=$begin2) {
                    $result .=  '&#183;&#183;&#183;';
                    for ($i = $begin2; $i <= $pages; $i++) {
                        $incl="";
                        if (($i==$page) and ($curr_class==true)) {
                            $incl=" class='selected' ";
                        }
                        $result .=  " <a $incl href='$url_prefix$i$url_sufix'>".$i.'</a> ';
                    }
                }
            }
        }

        return $result;
    }
} Design::getInstance();
