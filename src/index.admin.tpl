<script>

var userselected;
var username;

function disable (arg)
{
$('#login').attr('disabled', arg);
$('#passwd').attr('disabled', arg);
$('#createuser').attr('disabled', arg);
$('#bnsave').attr('disabled', arg);
$('#invite').attr('disabled', arg);
$('#email').attr('disabled', arg);
$('#sendemail').attr('disabled', arg);
}

function getuserinfo(selected)
{
username = selected;
$('#slogin').text(selected);
$('#loginuser').attr('href','./userOauthToken?login=' + selected);
$('#userinfo').attr('hidden',true);
$('#loading').attr('hidden',false);

$.post("/getuserinfo",{login: username},
 function(data) {
 	if(data!='NO')
 	{
		var arr = jQuery.parseJSON(data);

		$('#snickname').text(arr['nickname'][0]);
		$('#sfname').val(arr['fname'][0]);
		$('#siname').val(arr['iname'][0]);
		$('#sbirth_date').text(arr['birth_date'][0]);
		$('#sex' + arr['sex'][0]).attr('checked',true);
		$('#shintq').val(arr['hintq'][0]);
		$('#shinta').val(arr['hinta'][0]);
		$('#spasswd').val('');
		$('#userinfo').attr('hidden',false);
 	} else {
 		showPop('Ошибка!','DarkRed');
 	}
	$('#loading').attr('hidden',true);
 },"text");
}

function setinfo(arg)
{
$.post("/setuserinfo",arg,
 function(data) {
 	if(data=='OK')
 	{
		showPop('Изменено!','Lime');
 	} else {
 		showPop('Ошибка!','DarkRed');
 	}
 },"text");
}

function deleteuser()
{
var uselect = userselected;

$('.save').attr('hidden',true);
$('.save1').attr('readonly',true);
$.post("/deleteuser",{login: document.getElementById('userlist').options[uselect].text},
 function(data) {
 	if(data=='OK')
 	{
		document.getElementById('userlist').remove(uselect);
		$('#userinfo').attr('hidden',true);
 		showPop('Пользователь удалён!','Lime');
 	} else {
 		showPop('Ошибка!','DarkRed');
 	}
	$('.save1').attr('readonly',false);
	$('.save').attr('hidden',false);
 },"text");
}

function createuser()
{
disable(true);
if($('#passwd').val().length<6)
{
	showPop('Пароль должен быть не менее пяти символов!','DarkRed');
	disable(false);
	return;
}
$.post("/createuser",{login: $('#login').val(),passwd: $('#passwd').val()},
 function(data) {
 	if(data=='OK')
 	{
		$("#userlist").append("<option value=\"" + $('#login').val() + "\">" + $('#login').val() + "</option>");
 		showPop('Пользователь создан!','Lime');
	} else if(data=='EXISTS') {
		showPop('Пользователь уже существует!','DarkRed');
 	} else {
 		showPop('Ошибка!','DarkRed');
 	}
	disable(false);
 },"text");
}

function saveinv(arg)
{
disable(true);
if(arg==0)
{
	$.post("/invsave",{inv: $('#invite').val()},
	 function(data) {
	 	if(data=='OK')
		{
 			showPop('Инвайты сохранены!','Lime');
 		} else {
 			showPop('Ошибка!','DarkRed');
 		}
		disable(false);
 	 },"text");
} else {
	if($('#email').val().length<5)
	{
		showPop('Необходимо ввести e-mail!','DarkRed')
		disable(false);
		return;
	}
	$.post("/invsave",{email: $('#email').val()},
	 function(data) {
	 	if(data!='NO')
		{	
			$('#invite').val($.trim($('#invite').val() + "\r" + data));
			showPop('Инвайт отправлен!','Lime');
 		} else {
			showPop('Ошибка!','DarkRed');
		}
		disable(false);
 	 },"text");
}
}
</script>
<style>
input[type=text],textarea {
background: url('./img/back.png') repeat;
}
</style>
<h1 align="center">Nuclear Zone</h1>
<br><br>
<table class="tableadmin1" align="center">
<td>
{left}
</td>
<td>
<center>
<h4>Инфо пользователя</h4>
<HR>
</center>
<div hidden id="userinfo">
<table class="tableadmin2" align="center">
<tr><td><b>Логин:</b></td><td><span id="slogin"></span></td></tr>
<tr><td><b>Псевдоним:</b></td><td><span id="snickname"></span></td></tr>
<tr><td><b>Фамилия:</b></td><td><input type="text" class="save1" id="sfname" value=""><input class="save" type="image" src="./img/pen.png" OnClick="setinfo({fname:$('#sfname').val(),login:username})"></td></tr>
<tr><td><b>Имя:</b></td><td><input type="text" class="save1" id="siname" value=""><input class="save" type="image" src="./img/pen.png" OnClick="setinfo({iname:$('#siname').val(),login:username})"></td></tr>
<tr><td><b>Дата роджения:</b></td><td><span id="sbirth_date"></span></td></tr>
<tr><td><b>Пол:</b></td><td><label><input type="radio" id="sex0" name="sex" class="save1" value="0" OnClick="setinfo({sex:'0',login:username})">Не указан</label><label><input type="radio" id="sex1" name="sex" class="save1" value="1" OnClick="setinfo({sex:'1',login:username})">Муж</label><label><input type="radio" id="sex2" name="sex" class="save1" value="2" OnClick="setinfo({sex:'2',login:username})">Жен<label></td></tr>
<tr><td><b>Секретный вопрос:</b></td><td><input type="text" class="save1" id="shintq" value=""><input class="save" type="image" src="./img/pen.png" OnClick="setinfo({hintq:$('#shintq').val(),login:username})"></td></tr>
<tr><td><b>Ответ:</b></td><td><input type="text" class="save1" id="shinta" value=""><input class="save" type="image" src="./img/pen.png" OnClick="setinfo({hinta:$('#shinta').val(),login:username})"></td></tr>
<tr><td><b>Пароль:</b></td><td><input type="text" class="save1" id="spasswd" value=""><input class="save" type="image" src="./img/pen.png" OnClick="setinfo({passwd:$('#spasswd').val(),login:username})"></td></tr>
</table>
<center>
<p><a target="_blank" id="loginuser" href="">Войти под этим пользователем</a></p>
<p><input type="submit" value="Удалить пользователя" OnClick="deleteuser()"></p>
</center>
</div>
<div hidden id="loading" align="center">
<img src="./img/loading.gif">
<div>
</td>
<td>
<center>
<h4>Создать пользователя</h4>
<div>
<div><b>Логин:</b></div>
<input id="login" style="text-align:center" type="text" name="login"/>
<div><b>Пароль:</b></div>
<input id="passwd" style="text-align:center" type="text" name="passwd" maxlength="100"/><br>
<br><input id="createuser" type="submit" value="Создать" onclick="createuser()"/>
</div>
<HR>
<h4>Инвайты</h4>
<textarea id="invite" style="width:80%;min-height:70px">{invites}</textarea>
<p><input id="bnsave" type="submit" value="Сохранить" onclick="saveinv(0)"/></p>
Отправить на e-mail:<br>
<input id="email" style="text-align:center" type="text" name="email"/>
<p><input id="sendemail" type="submit" value="Отправить" onclick="saveinv(1)"/></p>
</center>
<br>
</td>
</table>
</body>
</html>