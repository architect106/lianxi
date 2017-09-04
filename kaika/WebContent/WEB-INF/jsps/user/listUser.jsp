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
	<script>
		/*list*/
		$(function(){
			$('#dg').datagrid({
				toolbar: '#tb',
				pagination : true,//分页
				url: '<%=basePath%>user/listUser.do',
				fit: true,
				striped : true,
				singleSelect: true,
				columns:[[
					{field:'id',title:'编号',width:100},
					{field:'name',title:'用户名',width:100},
					{field:'username',title:'登陆账号',width:100},
					{field:'password',title:'登录密码',width:100}
				]]
			})
			
		})
		
		/*add*/
		function add() {
			$('#dd').dialog({
				title: '新增用户信息',
				width: 350,
				top: $(window).height()/2 - 200,
				closed: false,
				cache: false,
				href: '<%=basePath%>user/toHandleUserInfo.do',
				modal: true,
				buttons:[
					{
						text:'提交',
						iconCls:'icon-ok',
						handler:function(){
							var name = $('#name').val();
							var username = $('#username').val();
							var password = $('#password').val();
							if(name=='' ||username=='' ||password==''){
								msg('请补全信息');
							}else{
								/* ajax提交表单数据 */
								$.ajax({
									url: '<%=basePath%>user/handleUserInfo.do',
									method: 'POST',
									data:$('#ff').serialize(),
									dataType: "json",
									success: function(data){
						                if(data.success){
											message(data);
										}else{	
											message(data);
										}
									}
								});
								/* 关闭dd对话框 */
								$('#dd').dialog('close');
								/* 重新加载页面数据 */
								$("#dg").datagrid("load",{});
							}
						}
					},
					{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							$('#dd').dialog('close');
						}
					}
				]
			});
		}

		/*edit*/
		function edit() {
			var rows = $('#dg').datagrid('getSelections'); 
            if (rows != "") {  
            	var url = '<%=basePath%>user/toHandleUserInfo.do?id=' + rows[0].id;
            	$('#dd').dialog({
    				title: '修改用户信息',
    				width: 350,
    				top: 15,
    				href: url,
    				modal: true,
    				buttons:[
    					{
    						text:'提交',
    						iconCls:'icon-ok',
    						handler:function(){
    							var name = $('#name').val();
    							var username = $('#username').val();
    							var password = $('#password').val();
    							if(name=='' ||username=='' ||password==''){
    								msg('请补全信息');
    							}else{
    								/* ajax提交表单数据 */
        							$.ajax({
        								url: '<%=basePath%>user/handleUserInfo.do',
        								method: 'POST',
        								data:$('#ff').serialize(),
        								dataType: "json",
        								success: function(data){
        					                if(data.success){
												message(data);
											}else{	
												message(data);
											}
        								}
        							});
        							/* 关闭dd对话框 */
        							$('#dd').dialog('close');
        							/* 重新加载页面数据 */
        							$("#dg").datagrid("reload",{});
    							}
    						}
    					},
    					{
    						text:'关闭',
    						iconCls:'icon-cancel',
    						handler:function(){
    							$('#dd').dialog('close');
    						}
    					}
    				]
    			});
            } else {  
            	msg('请选择一条记录！');
            }  
		}

		/*remove*/
		function remove(){
			var rows = $('#dg').datagrid('getSelections');  
            if (rows.length != "") {  
            	$.messager.confirm('删除', '确定执行删除操作吗?',function(r){
            		if(r){
            			var data = {"id":rows[0].id, "deleted":"0"};
        				$.ajax({
        					url: '<%=basePath%>user/handleUserInfo.do',
        					method: 'POST',
        					data: data,
        					dataType: "json",
        					success: function(data){
        		                if(data.success){
									message(data);
								}else{	
									message(data);
								}
        					}
        				});
        				/* 重新加载页面数据 */
        				$("#dg").datagrid("load",{});
            		}else{
            			msg('已取消删除操作！');
            		}
           		}); 
            } else { 
            	msg('请选择一条记录！');
            }  
		}
		
		/*操作提示框1*/
		function message(data){
			$.messager.show({
				title:'提示',
				msg: data.message,
				timeout:5000,
				showType:'slide'
			});
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
</head>
<body class="easyui-layout">

		<!--表格-->
		<table id="dg"></table>

		<!--模态框-->
		<div id="dd"></div>

		<!--表格工具栏-->
		<div id="tb">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="edit();">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="remove();">删除</a>
		</div>
</body>
</html>