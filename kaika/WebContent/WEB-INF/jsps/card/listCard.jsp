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
				url: '<%=basePath%>card/listCard.do',
				fit: true,
				striped : true,
				singleSelect: true,
				columns:[[
					{field:'id',title:'编号',width:100},
					{field:'number',title:'卡号',width:100},
					{field:'password',title:'密码',width:100},
					{field:'status',title:'状态',width:100,formatter:getStatus},
					{field:'orderDate',title:'订期',width:120},
					{field:'name',title:'名字',width:100},
					{field:'school',title:'学校',width:100},
					{field:'mobile',title:'手机号',width:100},
					{field:'zipcode',title:'邮编',width:100},
					{field:'regionName',title:'区域',width:100},
					{field:'streetName',title:'街道',width:100},
					{field:'road',title:'地址',width:100},
					{field:'doorplate',title:'门牌号',width:100},
					{field:'room',title:'房间号',width:100},
					{field:'activationTime',title:'激活时间',width:120,formatter:getTime},
					{field:'jouranl',title:'杂志名称',width:100},
					{field:'createTime',title:'创建时间',width:120,formatter:getTime},
					{field:'editTime',title:'编辑时间',width:120,formatter:getTime},
					{field:'remark',title:'备注',width:100}
				]]
			})
			
		})
		
		/* doSearch */
		function doSearch(){
			//数据验证 只提示开始日期和结束日期两个必须同时填
			var startTime = $('#startTimeTb').val();
			var endTime = $('#endTimeTb').val();
			var number = $('#numberTb').val();
			var mobile = $('#mobileTb').val();
			var status = $('#statusTb').val();
			if(startTime!="" || endTime!=""){
				if(startTime!="" && endTime!=""){
					$('#dg').datagrid('load',{
						startTime : startTime,
						endTime : endTime,
						number : number,
						mobile : mobile,
						status : status
					});
				}else{
					msg('开始日期和结束日期两个必须同时填写');
				}
			}else{
				$('#dg').datagrid('load',{
					startTime : startTime,
					endTime : endTime,
					number : number,
					mobile : mobile,
					status : status
				});
			}
		}
		
		/*add*/
		function add() {
			$('#dd').dialog({
				title: '新增卡片信息',
				width: 350,
				top: $(window).height()/2 - 200,
				closed: false,
				cache: false,
				href: '<%=basePath%>card/toHandleCardInfo.do',
				modal: true,
				buttons:[
					{
						text:'提交',
						iconCls:'icon-ok',
						handler:function(){
							//数据验证
							var number = $('#number').val();
							var password = $('#password').val();
							if(number=='' || password==''){
								msg('卡号密码不能为空');
							}else{
								/* ajax提交表单数据 */
								$.ajax({
									url: '<%=basePath%>card/handleCardInfo.do',
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
            	var url = '<%=basePath%>card/toHandleCardInfo.do?id=' + rows[0].id;
            	$('#dd').dialog({
    				title: '修改卡片信息',
    				width: 350,
    				top: 15,
    				href: url,
    				modal: true,
    				buttons:[
    					{
    						text:'提交',
    						iconCls:'icon-ok',
    						handler:function(){
    							//数据验证
    							var number = $('#number').val();
    							var password = $('#password').val();
    							var status = $('#status').val();
    							var name = $('#name').val();
    							var school = $('#school').val();
    							var mobile = $('#mobile').val();
    							var zipcode = $('#zipcode').val();
    							var region = $('#region').val();
    							var street = $('#street').val();
    							var road = $('#road').val();
    							var jouranl = $('#jouranl').val();
    							var remark = $('#remark').val();
    							if(status==0){
    								if(number=='' || password==''){
    									msg('密码不能为空');
    								}else{
    									/* ajax提交表单数据 */
            							$.ajax({
            								url: '<%=basePath%>card/handleCardInfo.do',
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
    							}else if(status==1){
    								if(number=='' || password=='' || name=='' || school=='' || mobile=='' || zipcode=='' ||
        									region=='' || street=='' || road=='' || jouranl=='' || remark==''){
        								msg('请保证信息完整再提交');
        							}else{
        								/* ajax提交表单数据 */
            							$.ajax({
            								url: '<%=basePath%>card/handleCardInfo.do',
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
    							}else{
    								msg('数据提交出错');
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
        					url: '<%=basePath%>card/handleCardInfo.do',
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
		
		/* importExcel */
		function importExcel(){
			$('#dd').dialog({
				title: '批量导入',
				width: 400,
				height: 500,
				closed: false,
				cache: false,
				href: '<%=basePath%>card/toImportExcel.do',
				modal: true,
				buttons:[
					{
						text:'提交',
						iconCls:'icon-ok',
						handler:function(){
							/* 提交表单数据 */
							$('#import').form('submit', {
								onSubmit: function(){
									$.messager.progress({ 
								    	title: '提示', 
								        msg: '文件上传中，请稍候……', 
								        text: '' 
								    });
								},
								success: function(){
									$.messager.progress('close');
									/* 关闭上传页面 */
									$('#dd').dialog('close');
									/* 重新加载页面数据 */
	    							$("#dg").datagrid("reload",{});
								}
							});
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
		
		/* exportExcel */
		function exportExcel(){
			var startTime = $('#startTimeTb').val();
			var endTime = $('#endTimeTb').val();
			var number = $('#numberTb').val();
			var mobile = $('#mobileTb').val();
			var status = $('#statusTb').val();
			var condition = "startTime="+startTime+"&endTime="+endTime+"&number="+number+"&mobile="+mobile+"&status="+status;
			location.href="<%=basePath%>card/exportExcel.do?"+condition;
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
		
		/* datagrid数据格式 */
		/* 激活状态 */
		function getStatus(value){
			if(value == 0){
				return "未激活";
			}
			if(value == 1){
				return "激活";
			}
		}
		
		/* 格式化日期 */
		function getTime(value){
			if(value!=null){
				var date = new Date(value);
	            var y = date.getFullYear();
	            var m = date.getMonth() + 1;
	            var d = date.getDate();
	            var h = date.getHours();
	            var mi = date.getMinutes();
	            var s = date.getSeconds();
	            function formatNumber(value){  
	         	   return (value < 10 ? '0' : '') + value;  
	         	}  
	            return y + '/' +m + '/' + d + ' ' + formatNumber(h) + ':' + formatNumber(mi) + ':' + formatNumber(s);
			}
            return ""; 	
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
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" onclick="importExcel();">Excel批量导入</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="edit();">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="remove();">删除</a><br>
			<!--时间 卡号 手机 激活状态-->
			开始时间:<input id="startTimeTb" class="easyui-datebox" type="text"> &nbsp;
			结束时间:<input id="endTimeTb" class="easyui-datebox" type="text"> &nbsp;
			卡号:<input id="numberTb" class="easyui-textbox" type="text"> &nbsp;
			手机:<input id="mobileTb" class="easyui-textbox" type="text"> &nbsp;
			激活状态:
			<select id="statusTb" class="easyui-combobox"> 
				<option value="">全部</option>
				<option value="1">激活</option>
				<option value="0">未激活</option>
			</select> &nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" onclick="exportExcel();">Excel导出</a>
		</div>
</body>
</html>