<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>开卡订阅后端管理系统</title>
	<base href="<%=basePath%>">
	<%@ include file="/common/css.jsp"%>
	<%@ include file="/common/js.jsp"%>	 
	<style>
		#main {
			position: absolute;
			width:300px;height:200px;
			left:50%;top:50%;
			margin-left:-150px;margin-top:-200px;
		}
	</style>
	<script>
		function login(){
			var username = $('#username').val();
			var password = $('#password').val();
			if(username=="" || password==""){
				msg('用户名或密码不能为空');
			}else{
				$('#loginForm').submit();
			}
		}
		
		/*操作提示框2*/
		function msg(msg){
			$.messager.show({
				title:'提示',
				msg: msg,
				timeout:5000,
				showType:'slide'
			});
		}
	</script>
	<script> 
		if (window != top) 
		top.location.href = location.href; 
	</script>
</head>
<body>
	<div id="main">
		<form id="loginForm" action="<%=basePath%>user/login.do" method="post">
		<div style="margin-bottom:10px;text-align:center">
			<h2>开卡订阅系统</h2>
		</div>
		<div style="margin-bottom:10px">
			<input class="easyui-textbox" type="text" id="username" name="username"
				style="width:100%;height:40px;padding:12px" data-options="prompt:'用户名',iconCls:'icon-man',iconWidth:38" >
		</div>
		<div style="margin-bottom:20px">
			<input class="easyui-textbox" type="password" id="password" name="password"
				style="width:100%;height:40px;padding:12px" data-options="prompt:'密码',iconCls:'icon-lock',iconWidth:38">
		</div>
		<div>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="" style="padding:5px 0px;width:100%;"
				onclick="login();">
				<span style="font-size:14px;">登陆</span>
			</a>
		</div>
		</form>
	</div>
	</div>
</body>
</html>