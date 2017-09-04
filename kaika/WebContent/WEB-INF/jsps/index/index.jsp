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
		.logo {
			width: 180px;
			height: 50px;
			line-height: 50px;
			text-align: center;
			font-weight: bold;
			font-size: 20px;
			float: left;
			color: #fff;
		}
		
		.logout {
			padding: 25px 15px 0 0;
			float: right;
			color: #fff;
		}
		
		li {
			margin-top: 5px;
		}
		
		a {
			text-decoration:none;
		}
		
		body{
			overflow：hidden
		}
	</style>
	<script>
		$(function(){
			$('#content').tabs('add',{
				title:"开卡管理",
				content:'<iframe scrolling="no" frameborder="0"  src="<%=basePath%>card/toListCard.do" style="width:100%;height:100%;"></iframe>',
				closable:true
			});
		});
		
		function addTab(title, url){
			if ($('#content').tabs('exists', title)){
				$('#content').tabs('select', title);
			} else {
				var content = '<iframe scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
				$('#content').tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			}
		}
	</script>
</head>
<body class="easyui-layout">

	<!--头部，系统名称-->
	<div data-options="region:'north',split:true,border:false" style="height:50px;overflow:hidden;background-image: url(images/bg_header.jpg); ">
		<div class="logo">
			开卡订阅后端管理系统
		</div>
		<div class="logout">
			你好，${sessionScope.loginUser.name} | <a href="<%=basePath%>user/logout">退出</a>
		</div>
	</div>

	<!--菜单栏区域-->
	<div data-options="region:'west',split:true,title:'导航菜单'" style="width:150px;">
		<div  class="easyui-accordion" data-options="fit:true,border:false" animate="false" >
			<div title="业务菜单" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:5px;line-height: 18px;">
				<ul class="easyui-tree">
					<li>
						<a href="javascript:void(0)" onclick="addTab('开卡管理','<%=basePath%>card/toListCard.do')">开卡管理</a>
				   </li>
				   <li>
						<a href="javascript:void(0)" onclick="addTab('杂志设置','<%=basePath%>journal/toListJournal.do')">杂志设置</a>
				   </li>
				   <li>
						<a href="javascript:void(0)" onclick="addTab('用户管理','<%=basePath%>user/toListUser.do')">用户管理</a>
				   </li>
				</ul>
			</div>
		</div>
	</div>

	<!--文本区域-->
	<div id="content" data-options="region:'center'" class="easyui-tabs"></div>

	<!--公司注册信息-->
	<div data-options="region:'south',split:true,border:false,collapsible:false" style="height:25px;background-color: #eaf2ff;text-align: center">
		©2017 上海旗继网络有限公司 All Rights Reserved
	</div>

</body>
</html>