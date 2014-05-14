<div "header_stripe">
<div id="page_container">
	<div id="toppanel">
		<div id="panel">
			<div id="panel_contents">
			<div id="login">
				<table align="center" style="background-image: url('http://userlogos.org/files/logos/Grawl/YMail.png');background-color: #c7b39b;">
				<tr>
				<td><b>Логин:*</b></td><td><input type="text" name="rlogin">@{domain}</td>
				</tr>
				<tr>
				<td><b>Пароль:*</b></td><td><input type="text" name="rpasswd"></td>
				</tr>
				<tr>
				<td><b>Инвайт:*</b></td><td><input type="text" name="rinv"></td>
				</tr>
				<tr>
				<td colspan="2"><center><label><input type="checkbox">Войти</label></center></td>
				</tr>
				<tr>
				<td colspan="2"><center><button type="button" onclick="">Зарегистрироваться</button></center></td>
				</tr>
				</table>
			</div>
			</div>
		</div>
		<div class="panel_button"><img src="./img/expand.png"><a href="#">SingUp</a></div>
		<div class="panel_button" style="display: none;" id="hide_button"><img src="./img/collapse.png"><a href="#">SingUp</a></div>
	</div>
</div>

</div>
<script>
$(document).ready(function() {
	$("div.panel_button").click(function(){
		$("div#panel").animate({
			height: "500px"
		})
		.animate({
			height: "400px"
		}, "fast");
		$("div.panel_button").toggle();
	
	});	
	
   $("div#hide_button").click(function(){
		$("div#panel").animate({
			height: "0px"
		}, "fast");
		
	
   });	
	
});
</script>
<style>
#header a.mozilla { 
	background: url("./img/title.png") 100% 0px no-repeat transparent;
	display: block;
	float: right;
	height: 49px;
	overflow: hidden;
	position: relative;
	text-indent: -200px;
	width: 118px;
}
div#login {
	width: 40%;
	height: 60%;
	//background: #46392f;
	margin: 0 auto;
	top: 10%; 
	position: absolute;
}
hr#header_stripe {
	height: 12px;
	position: relative;
	top: -7px;
	background-color: #191919;
	border: none;
	color: #191919;
}
#panel {
	width: 900px;
	position: relative;
	top: 1px;
	height: 0px;
	margin-left: auto;
	margin-right: auto;
	z-index: 10;
	overflow: hidden;
	text-align: left;
}
#panel_contents {
	background: url(./img/wrapper.png) top left;
	height: 100%;
	width: 904px;
	position: absolute;
	z-index: -1;
}
#toppanel {
	position: absolute;
	width: 900px;
	left: 0px;
	z-index: 25;
	text-align: center;
}
#page_container {
	position: relative;
	margin-left: auto;
	margin-right: auto;
	width: 904px;
	top:-1px;
}
.panel_button {
	margin-left: auto;
	margin-right: auto;
	position: relative;
	width: 173px;
	height: 54px;
	z-index: 20;
	filter:alpha(opacity=70);
	-moz-opacity:0.70;
	-khtml-opacity: 0.70;
	opacity: 0.70;
	cursor: pointer;
	background: url(./img/panel_button.png);
	top:1px;
}
.panel_button img {
	position: relative;
	top: 10px;
	border: none;
}
.panel_button a {
	text-decoration: none;
	color: #545454;
	font-size: 20px;
	font-weight: bold;
	position: relative;
	top: 5px;
	left: 10px;
	font-family: Arial, Helvetica, sans-serif;
}
.panel_button a:hover {
	color: #999999;
}
</style>
<div id="header">
<a class="mozilla" href="http://www.mozilla.org/ru/thunderbird/">mozilla</a>
</div>
<br><br>
<h1 align=center>{msg}</h1>
<table align="center" style="background: url(./img/wrapper.png) top left; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px;">
<td style="width:50%;">
<center>
<form align="center" method="post" action="https://passport.yandex.ru/for/{domain}?mode=auth"> 
<div><b>Логин:</b></div>
<input id="login" style="text-align:center" type="text" name="login" value="" tabindex="1"/>
<div><b>Пароль:</b></div>
<input type="hidden" name="retpath" value="http://mail.yandex.ru/for/{domain}">
<input style="text-align:center" type="password" name="passwd" value="" maxlength="100" tabindex="2"/> <br>
<label for="a"><input type="checkbox" name="twoweeks" id="a" value="yes" tabindex="4"/>запомнить меня</label>
<br><br><input style="width:30%;height:20%" type="submit" name="In" value="Войти" tabindex="5"/>
</form>
<a href='http://passport.yandex.ru/for/{domain}/passport?mode=remember'>Вспомнить пароль</a></center>
</td>
</table>
</body>
</html>