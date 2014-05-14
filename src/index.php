<?php
error_reporting(0);

include('lib/Base.php');
include('lib/UserApi.php');
include('lib/RegistrarApi.php');
include('lib/config.php');
include('lib/fnc.php');

if($_SERVER['REQUEST_URI']=='/register') {
	$html = file_get_contents('index.head.tpl');
	$html .= file_get_contents('index.register.tpl');
	$html = replacevar($html);
	echo $html;
} elseif ($_SERVER['REQUEST_URI']=='/createuser') {
	$result = 'NO';
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		if(strlen($_POST['login'])<=31 and strlen($_POST['passwd'])<=20 and preg_match('/^[a-z0-9_-]{1,31}$/is',$_POST['login']))
		{
			$api = new Yandex_Mail_UserApi($config['token']);
			if(strcasecmp($api->checkUser($_POST['login'])->children(),'nouser')==false) 
			{
				$api->createUser($_POST['login'],$_POST['passwd']);
				$result = 'OK';
			} else {
				$result = 'EXISTS';
			}
		}
	}
	echo $result;
	unset ($result);
} elseif ($_SERVER['REQUEST_URI']=='/invsave') {
	$result = 'NO';
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		if(isset($_POST['email']))
		{
			if(preg_match('|([a-z0-9_\.\-]{1,20})@([a-z0-9\.\-]{1,20})\.([a-z]{2,4})|is',$_POST['email']))
			{
				$result = createinvite();
				if(mail($_POST['email'],'Инвайт mail.'.$config['domain'],'Ваш инвайт '.$result))
				{
					$f = fopen($config['invite'],'a+');
					if($f)
					{
						if (flock($f,LOCK_EX))
						{
							if(!fwrite($f,$result."\r\n"))
							{
								$result = 'NO';
							}
							flock($f,LOCK_UN);
						}
						fclose($f);		
					}
					unset ($f);
				}
			}
		} else {
			$f = fopen($config['invite'],'w');
			if($f)
			{
				if (flock($f,LOCK_EX))
				{
					if(fwrite($f,$_POST['inv']))
					{
						$result = 'OK';
					}
					flock($f,LOCK_UN);
				}
				fclose($f);		
			}
			unset ($f);
		}
	}
	echo $result;
	unset ($result);
} elseif ($_SERVER['REQUEST_URI']==$config['admin_url']) {
	$html = file_get_contents('index.head.tpl');
	if($config['admin_login']!=$_SERVER['PHP_AUTH_USER'] || $config['admin_password']!=$_SERVER['PHP_AUTH_PW'])
	{
		header('WWW-Authenticate: Basic realm="Nuclear Zone"');
    		header('HTTP/1.0 401 Unauthorized');
		$html .= file_get_contents('index.message.tpl');
		$html = str_replace('{message}',$config['msg_errlogin'],$html);
	} else {
		$html .= file_get_contents('index.admin.tpl');
		$api = new Yandex_Mail_UserApi($config['token']);

		$result = $api->getUsersList(1,1000)->children();
		$count = (int)$result[0]->domain->emails->found;

		$users = '<center><h4>Пользователи</h4><small>Всего: '.$count.'</small><select id="userlist" OnKeyUP="if(event.keyCode==46){deleteuser();}" onchange="userselected=this.selectedIndex;getuserinfo(this.options[userselected].text);" style="width:90%;height:90%;" name="menu" size="17">';

		preg_match_all("#<name>(.*?)</name>#is",$result[0]->domain->emails->asXML(),$match);
		for($i=0; $i<$count; $i++)
		{
			$users .= '<option value="'.$match[1][$i].'">'.$match[1][$i].'</option>';
		}
		$users .= '</select></center>';
		$html = str_replace('{left}',$users,$html);
	}
	$html = replacevar($html);
	echo $html;
} elseif ($_SERVER['REQUEST_URI']=='/deleteuser') {
	$result = 'NO';
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		$api = new Yandex_Mail_UserApi($config['token']);
		if(strcasecmp($api->checkUser($_POST['login'])->children(),'nouser')!=false) 
		{
			if(strpos($api->deleteUser($_POST['login'])->asXML(),'<ok/>')!=false)
			{
				$result = 'OK';
			}
		}
	}
	echo $result;
	unset ($result);
} elseif ($_SERVER['REQUEST_URI']=='/getuserinfo') {
	$result = 'NO';
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		$api = new Yandex_Mail_UserApi($config['token']);
		if(strcasecmp($api->checkUser($_POST['login'])->children(),'nouser')!=false) 
		{
			$result = $api->getUserInfo($_POST['login'])->children();
			$result = Array("nickname"=>$result[0]->user->nickname,
					"fname"=>$result[0]->user->fname,
					"iname"=>$result[0]->user->iname,
					"birth_date"=>$result[0]->user->birth_date,
					"sex"=>$result[0]->user->sex,
					"hintq"=>$result[0]->user->hintq,
					"hinta"=>$result[0]->user->hinta);
			$result = json_encode($result);
		}
	}
	echo $result;
	unset ($result);
} elseif ($_SERVER['REQUEST_URI']=='/setuserinfo') {
	$result = 'NO';
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		$api = new Yandex_Mail_UserApi($config['token']);
		if(strcasecmp($api->checkUser($_POST['login'])->children(),'nouser')!=false) 
		{
			if(isset($_POST['passwd']))
				$passwd = $_POST['passwd'];
			if(isset($_POST['hinta']))
				$hinta = $_POST['hinta'];
			if(isset($_POST['hintq']))
				$hintq = $_POST['hintq'];
			if(isset($_POST['sex']))
				$sex = $_POST['sex'];
			if(isset($_POST['iname']))
				$iname = $_POST['iname'];
			if(isset($_POST['fname']))
				$fname = $_POST['fname'];

			$api->editUserDetails($_POST['login'],$passwd,$iname,$fname,$sex,$hintq,$hinta);
			$result = 'OK';
		}
	}
	echo $result;
	unset ($result);
} elseif (preg_match('/^\/userOauthToken\?(.*)/isU',$_SERVER['REQUEST_URI'])) {
	if($config['admin_login']==$_SERVER['PHP_AUTH_USER'] and $config['admin_password']==$_SERVER['PHP_AUTH_PW'])
	{
		$api = new Yandex_Mail_UserApi($config['token']);
		if(strcasecmp($api->checkUser($_GET['login'])->children(),'nouser')!=false) 
		{

			$pos = strpos($_GET['login'],'@');
			if ($pos==false)
			{
				$login = $_GET['login'];
			} else {
				$login = substr($_GET['login'],0,$pos);
			}


			$result = $api->userOauthToken($config['domain'],$login)->asXML();//->children()

			if(preg_match_all("#<oauth-token.*>(.*?)</oauth-token>#is",$result,$match))
			{
				echo '<html><head><meta http-equiv="Refresh" content="0; url=http://passport.yandex.ru/passport?mode=oauth&type=trusted-pdd-partner&access_token='.$match[1][0].'" /></head></html>';
   			}
		}
	}
} else {
	$html = file_get_contents('index.head.tpl');
	$html .= file_get_contents('index.login.tpl');
	$html = replacevar($html);
	echo $html;
}
?>