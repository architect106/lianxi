<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>My JSP 'index.jsp' starting page</title>
    <base href="<%=basePath%>">
  </head>
  <body>
		<%response.sendRedirect(basePath+"user/toLogin.do");%>
  </body>
</html>
