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
</head>
<body>
	<div class="easyui-panel" style="padding:25px 60px;" data-options="fit:true,border:false">
		<form id="import" action="<%=basePath%>card/importExcel.do" method="post" enctype="multipart/form-data">
			<div style="margin-bottom:20px">
				<span>请选择上传的文件</span> &nbsp;
				<input type="file" name="cardExcel">
			</div>
		</form>
	</div>
</body>
</html>