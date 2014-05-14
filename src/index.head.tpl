<!DOCTYPE HTML>
<html lang="ru">
<head>
<title>{title}</title>
<meta http-equiv="Content-Type" content="text/html;charset=windows-1251" />
<meta content="{description}" name="description">
<meta content="{keywords}" name="keywords">
<script type="text/javascript" src="./jquery.js"></script>
<style>
#popup {opacity:0.7;width:300px;position:absolute;right:20px;top:100px;display:none;background:#99FF33;border:1px solid #000000;padding:15px 10px;z-index:10000;color:Black;font-size:large;text-align:center;}
table.tableadmin1 td {
width: 33%;
min-width: 410px;
background: url(./img/wrapper.png) top left;
-moz-border-radius: 10px;
-webkit-border-radius: 10px;
border-radius: 10px;
vertical-align: top;
}
table.tableadmin2 td {
vertical-align: top;
background: transparent;
min-width: 200px;
}
a {
color:#FFFFFF;
text-decoration: underline;
font-weight: bold;
font-size: large;
}
a:active {
color:#FFFFFF;
text-decoration: underline;
font-weight: bold;
font-size: large;
}
a:visited {
color:#FFFFFF;
text-decoration: underline;
font-weight: bold;
font-size: large;
}
a:hover {
color:#FFFFFF;
text-decoration: underline;
font-weight: bold;
font-size: large;
}
body {
color:white;
}
</style>
</head>
<body onload="document.getElementById('login').focus()" style="color:FFFFFF; background-color:Black; background:black url(./img/bg_dyshoreal.jpg) no-repeat fixed top center; width: 85%; margin: 0 auto;">
<div id="popup">
<p id="msg"></p>
<script type="text/javascript">
var block_id = '#popup';
var top_offset = 10;
var text = document.getElementById("msg");

function blockPop() {
	$(block_id).hide("normal");
	$(window).unbind("scroll");
}
function showPop(msg,color) {
	$(block_id).css('background',color);
	text.innerHTML = msg;
	setTimeout(function() {
		var win_scrl = $(document).scrollTop();
		var top = parseInt(top_offset + win_scrl);
		$(block_id).css('top', top + 'px').slideDown("normal", function() {
			$(block_id).unbind("click").click(function() {
				blockPop();
			});
			$(window).scroll(function() {
				win_scrl = $(document).scrollTop();
				top = parseInt(top_offset + win_scrl);
				$(block_id).css('top', top + 'px');
			});
		});
	}, 100);
	setTimeout(blockPop,1000);
}
</script>
</div>