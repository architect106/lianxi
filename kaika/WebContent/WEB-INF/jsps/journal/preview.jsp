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
	<div style="padding: 15px 50px 20px 50px">
		<img src="${journal.image}" width="200px"><br>
		杂志名：${journal.journal}<br><br>
		出版社：${journal.press}<br><br>
		订期：${journal.orderDate}<br><br>
		内容：${journal.content}
	</div>
</body>
</html>