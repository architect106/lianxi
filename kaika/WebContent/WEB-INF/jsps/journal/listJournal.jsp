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
				url: '<%=basePath%>journal/listJournal.do',
				fit: true,
				striped : true,
				singleSelect: true,
				columns:[[
					{field:'id',title:'编号',width:100},
					{field:'journal',title:'杂志名',width:100},
					{field:'press',title:'出版社',width:100},
					{field:'orderDate',title:'订期',width:120},
					{field:'content',title:'内容',width:100},
					{field:'deleted',title:'使用状态',width:100,formatter:getStatus}
				]]
			})
			
		})
		
		/*add*/
		function add() {
			$('#dd').dialog({
				title: '新增杂志信息',
				width: 500,
				top: 60,
				closed: false,
				cache: false,
				href: '<%=basePath%>journal/toHandleJournalInfo.do',
				modal: true,
				buttons:[
					{
						text:'提交',
						iconCls:'icon-ok',
						handler:function(){
							var journal = $('#journal').val();
							var press = $('#press').val();
							var orderDate = $('#orderDate').val();
							var content = $('#content').val();
							if(journal=='' ||press=='' ||orderDate=='' ||content==''){
								msg('请补全信息再提交');
							}else{
								/* jQuery-form提交数据 */
								var form = $("#ff");    
					            var options  = {      
					                url: '<%=basePath%>journal/handleJournalInfo.do',
					                type: 'post',   
					                dataType: "json",
					                success:function(data)      
					                {    
					                	if(data.success){
											message(data);
										}else{	
											message(data);
										}
					                	/* 关闭dd对话框 */
										$('#dd').dialog('close');
										/* 重新加载页面数据 */
										$("#dg").datagrid("load",{});
					                }      
					            };      
					            form.ajaxSubmit(options);   
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
            	var url = '<%=basePath%>journal/toHandleJournalInfo.do?id=' + rows[0].id;
            	$('#dd').dialog({
    				title: '修改杂志信息',
    				width: 500,
    				top: 60,
    				href: url,
    				modal: true,
    				buttons:[
    					{
    						text:'提交',
    						iconCls:'icon-ok',
    						handler:function(){
    							var journal = $('#journal').val();
    							var press = $('#press').val();
    							var orderDate = $('#orderDate').val();
    							var content = $('#content').val();
    							if(journal=='' ||press=='' ||orderDate=='' ||content==''){
    								msg('请补全信息再提交');
    							}else{
    								/* jQuery-form提交数据 */
        							var form = $("#ff");    
        				            var options  = {      
        				                url: '<%=basePath%>journal/handleJournalInfo.do',
        				                type: 'post',   
        				                dataType: "json",
        				                success:function(data)      
        				                {    
        				                	if(data.success){
        										message(data);
        									}else{	
        										message(data);
        									}
        				                	/* 关闭dd对话框 */
        									$('#dd').dialog('close');
        									/* 重新加载页面数据 */
        									$("#dg").datagrid("load",{});
        				                }      
        				            };      
        				            form.ajaxSubmit(options);  
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
        					url: '<%=basePath%>journal/updateJournalStatus.do',
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
		
		/*selected*/
		function selected(){
			var rows = $('#dg').datagrid('getSelections');  
            if (rows.length != "") {  
            	$.messager.confirm('使用', '确定执行使用操作吗?',function(r){
            		if(r){
            			var data = {"id":rows[0].id, "deleted":"2"};
        				$.ajax({
        					url: '<%=basePath%>journal/updateJournalStatus.do',
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
            			msg('已取消选定操作！');
            		}
           		}); 
            } else {  
            	msg('请选择一条记录！');
            }  
		}
		
		/* preview */
		function preview() {
			var rows = $('#dg').datagrid('getSelections'); 
            if (rows != "") {  
            	var url = '<%=basePath%>journal/toPreviewJournalInfo.do?id=' + rows[0].id;
				$('#dd').dialog({
					title: '预览杂志信息',
					width: 500,
					top: 60,
					closed: false,
					cache: false,
					href: url,
					modal: true
				});
            }else{
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
		
		/* 使用状态 */
		function getStatus(value){
			if(value == 2){
				return "在用";
			}else{
				return "未使用";
			}
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
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="selected();">使用</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="preview();">预览</a>
		</div>
</body>
</html>