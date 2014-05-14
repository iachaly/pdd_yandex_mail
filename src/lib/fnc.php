<?
function createinvite()
{
	$invite = substr(md5(microtime(true)), 0, 8);
	$file = fopen($fpass,"a+");
	flock($file,LOCK_EX);
	fwrite($file,$invite."\r\n");
	flock($file,LOCK_UN);
	fclose($file);
	return $invite;
}
function replacevar($html)
{
	global $config;

	$html = str_replace('{domain}',$config['domain'],$html);
	$html = str_replace('{description}',$config['description'],$html);
	$html = str_replace('{keywords}',$config['keywords'],$html);
	$html = str_replace('{title}',$config['title'],$html);
	$html = str_replace('{msg}',$config['msg'],$html);
	$html = str_replace('{invites}',file_get_contents($config['invite']),$html);
	return $html;
}
?>