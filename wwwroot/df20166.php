<?php
error_reporting(0);
header("Content-type: text/html; charset=utf-8");
function sendScoketData($host,$port,$data,$timeout=10)
{
	$ret = false;
	//echo "<br>host = $host port = $port <br>";
	//print_r($data);
	
	$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
	if(false === $socket)
	{
		 //echo ("Could not create  socket reason: ".socket_strerror($socket)."\n");
		 return $ret; 
	}
	socket_set_option($socket,SOL_SOCKET,SO_RCVTIMEO,array("sec"=> 1, "usec"=> 0 ) );
	socket_set_option($socket,SOL_SOCKET,SO_SNDTIMEO,array("sec"=> 1, "usec"=> 0 ) );
	// 创建一个Socket    
	$connection = socket_connect($socket, $host, $port);
	if(false === $connection)
	{
		//echo ("Could not connet server reason: ".socket_strerror($socket)."\n");    
		return $ret;
	}
	//  连接  
	$ret = socket_write($socket, $data,strlen($data));
	if(0 === $ret) 
	{
		//echo ("Write failed reason: ".socket_strerror($socket)."\n");
		return $ret; 
	}
	$ret = true;
	// 数据传送 向服务器发送消息   
	//if ($buffer = socket_read($socket, 1024, PHP_NORMAL_READ)) 
	while($out = socket_read($socket, 1024))
	//echo "<br> buffer = $buffer <br>";
	//if (0 != $buffer) 
	{
		//echo("Data sent was: time\n<br>Response was:" . $out . "\n");   
	}
	/*else {
		echo " can not receive data \n<br> ";
	} */  
	//var_dump($out);
	
	socket_close($socket);
	
	return $ret;
}
$qu = intval($_POST[serverid]); ;
$submit=$_POST[submit];
$name = $_POST[name];
$SERVER_IP="127.0.0.1";
$SERVER_PORT="11111";
$gmcode=$_POST[gmcode];
if($gmcode=='df20166'){
	if($submit == '充值元宝'){
	$num = $_POST[cznum];
	mysql_connect("localhost","root","123456");
	mysql_select_db("dragongamedata2001");
	mysql_query("set names 'utf8'");
	$sql="select id from player_gamedata where name='$name'"; 
	$query=mysql_query($sql);
	$player=mysql_fetch_array($query);
	$sendData=array(
		'cmd'=>2001,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"1;df20166;1;JuBaoYun;".$player[id].";".$num,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
	if($submit == '发送邮件'){
	$num = intval($_POST[itemnum]);
	$item=intval($_POST['item']);
	mysql_connect("localhost","root","123456");
	mysql_select_db("dragongamedata2001");
	mysql_query("set names 'utf8'");
	$sql="select id from player_gamedata where name='$name'"; 
	$query=mysql_query($sql);
	$player=mysql_fetch_array($query);
	$sendData=array(
		'cmd'=>2015,
		'data'=>array(
			'server_id'=>$qu,
			'flag'=>0,
			'low_level'=>1,
			'high_level'=>0,
			'mailTitle'=>'系统邮件',
			'mailContent'=>'df20166制作!',
			'receiveName'=>$name,
			'receiveID'=>$player['id'],
			'itemList'=>array(
				array(
					'itemDataId'=>$item,
					'itemCnt'=>$num,
					'flag'=>0
				)
			)
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
	if($submit == '踢下线'){
	$sendData=array(
		'cmd'=>1005,
		'data'=>array(
			'server_id'=>$qu,
			'role_name'=>$name,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
	if($submit == '设置GM'){
	$sendData=array(
		'cmd'=>2008,
		'data'=>array(
			'server_id'=>$qu,
			'role_name'=>$name,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
	if($submit == '取消GM'){
	$sendData=array(
		'cmd'=>2009,
		'data'=>array(
			'server_id'=>$qu,
			'role_name'=>$name,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '发送公告'){
	$value=$_POST[notice];
	$sendData=array(
		'cmd'=>1007,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"0;".$value,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '发送元宝'){
				$ybnum=$_POST[ybnum];
	            mysql_connect("127.0.0.1","root","123456");   //连接数据库   
                mysql_select_db("dragongamedata2001");  //选择数据库  
                $sql = "update player_gamedata set treasure=treasure+'$ybnum' where name='$name'"; //SQL语句  
                $result = mysql_query($sql);    //执行SQL语句  
				if ($result) 
					echo "<script>alert('成功！')</script>";
				else 
					echo "<script>alert('失败!')</script>";
}
if($submit == '发送金币'){
				$jbnum=$_POST[jbnum];
	            mysql_connect("127.0.0.1","root","123456");   //连接数据库   
                mysql_select_db("dragongamedata2001");  //选择数据库  
                $sql = "update player_gamedata set coin=coin+'$jbnum' where name='$name'"; //SQL语句  
                $result = mysql_query($sql);    //执行SQL语句  
				if ($result) 
					echo "<script>alert('成功！')</script>";
				else 
					echo "<script>alert('失败!')</script>";
}
if($submit == '发送经验'){
	$expnum=$_POST[expnum];
	$sendData=array(
		'cmd'=>1006,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"0;0;".$name.";#addexpdf20166 ".$expnum.";1;0;0",
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '发送物品'){
	$itemfs=$_POST[itemfs];
	$itemnum=$_POST[itemnumfs];
	$starnumfs=$_POST[starnumfs];
	$lucknumfs=$_POST[lucknumfs];
	$bd=$_POST[bd];
	$sendData=array(
		'cmd'=>1006,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"0;0;".$name.";#additemdf20166 ".$itemfs." ".$itemnum." ".$bd." ".$starnumfs." ".$lucknumfs.";1;0;0",
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '开启活动'){
	$actid=$_POST['actid'];
	$sendData=array(
		'cmd'=>1006,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"0;0;".$name.";#startactdf20166 ".$actid.";1;0;0",
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '关闭活动'){
	$actid=$_POST['actid'];
	$sendData=array(
		'cmd'=>11039,
		'data'=>array(
			'userID'=>5395068415318016,
			'isVip'=>1,
			'first_role'=>0,
			'first_pay'=>0,
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}
if($submit == '发送命令'){
	$sendData=array(
		'cmd'=>1006,
		'data'=>array(
			'server_id'=>$qu,
			'op'=>"",
		)
	);
	$ret = sendScoketData($SERVER_IP, $SERVER_PORT,json_encode($sendData));
	if($ret){
		echo "<script>alert('成功！')</script>";
	}else{
		echo "<script>alert('失败！')</script>";
	}
}


}


?>
<html>
	<head>
	<title>蓝月传奇GM工具DF20166.COM</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	</head>
	<body>
	<form action="" method="POST">
	<div style="width:100%;text-align:center;border:1px solid #000">
	<h2>蓝月传奇GM工具DF20166.COM</h3>
	GM码:<input type="text" name="gmcode"><br>
	服务器:<select name="serverid"> 
	<option value="2001">一区</option></select><br>
	角色名:<input type="text" name="name" value="<?php echo $_POST[name]?>"><br>
	----------------------------------------------------------
	<h3>充值功能</h3><br>
	充值:<input type="text" name="cznum" value="df20166"><input type="submit" value="充值元宝" name="submit"><br>
	金币:<input type="text" name="jbnum" value=""><input type="submit" value="发送金币" name="submit"><br>
	元宝:<input type="text" name="ybnum" value=""><input type="submit" value="发送元宝" name="submit"><br>
	----------------------------------------------------------
	<h3>邮件</h3><br>
	物品ID:<input type ='text' name='item'><br>
	数量:<input type="number" placeholder="发送数量" name="itemnum"><br>
	<input type="submit" value="发送邮件" name="submit"><br>
	----------------------------------------------------------
	<h3>发送物品</h3><br>
	物品ID:<input type ='text' name='itemfs'><br>
	数量:<input type="number" placeholder="发送数量" name="itemnumfs"><br>
	星级:<input type="number" placeholder="星级" name="starnumfs"><br>
	幸运:<input type="number" placeholder="幸运" name="lucknumfs">
	<select name="bd"> 
	<option value="1">绑定</option>
	<option value="0">未绑定</option></select><br>
	<input type="submit" value="发送物品" name="submit"><br>
	----------------------------------------------------------
	<h3>系统管理</h3><br>
	活动管理<select name="actid"> 
	<option value="1">篝火晚宴</option>
	<option value="2">夺宝奇兵</option>
	<option value="3">领地战</option>
	<option value="4">重装使者</option>
	</select>
	<input type="submit" value="开启活动" name="submit"><input type="submit" value="关闭活动" name="submit"><br>
	----------------------------------------------------------
	<h3>角色管理</h3><br>
	<input type="submit" value="踢下线" name="submit" style="width:80px;height:40px">
	<input type="submit" value="设置GM" name="submit" style="width:80px;height:40px">
	<input type="submit" value="取消GM" name="submit" style="width:80px;height:40px"><br>
	经验:<input type="text" name="expnum" value=""><input type="submit" value="发送经验" name="submit"><br>
	----------------------------------------------------------
	<h3>公告功能</h3><br>
	公告内容:<input type="text" placeholder="内容" name="notice" style="width:150px;height:80px;"><br>
	<input type="submit" value="发送公告" name="submit" style="width:80px;height:40px"><br>
	----------------------------------------------------------
	<h3>GM功能</h3><br>
	<input type="submit" value="发送命令" name="submit"><br>
	</div>
	</form>
	</body>
</html>