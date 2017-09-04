<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>开卡订阅后端管理系统</title>
	<base href="<%=basePath%>">
	<%@ include file="/common/css.jsp"%>
	<%@ include file="/common/js.jsp"%>	 
</head>
<body>
	<div style="padding: 15px 40px 20px 40px">
		<form id="ff" class="easyui-form" action="" method="post" data-options="	">
			<input type="hidden" name="id" value="${user.id}">
			
			<table cellpadding="5">
			
				<tr>
	    			<td>名字:</td>
	    			<td>
	    				<input class="easyui-textbox" type="text" id="name" name="name" value="${user.name }" data-options="required:true">
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>登陆账号:</td>
	    			<td><input class="easyui-textbox" type="text" id="username" name="username" value="${user.username }" data-options="required:true"
	    					<c:if test="${user.username ne null }"> 
	    						readonly="readonly"
	    					</c:if>
	    			></td>
	    		</tr>
	    		
	    		
	    		<tr>
	    			<td>登陆密码:</td>
	    			<td><input class="easyui-textbox" type="text" id="password" name="password" value="${user.password }" data-options="required:true"></td>
	    		</tr>
	    		
    		</table>
		</form>
	</div>
</body>
</html>