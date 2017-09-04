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
		<form id="ff" class="easyui-form" action="" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${journal.id}">
			
			<table cellpadding="5">
			
				<tr>
	    			<td>杂志名:</td>
	    			<td>
	    				<input class="easyui-textbox" type="text" id="journal" name="journal" value="${journal.journal }"
	    					<c:if test="${card.id ne null }"> 
	    						readonly="readonly"
	    					</c:if>
	    					data-options="required:true">
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>出版社:</td>
	    			<td><input class="easyui-textbox" type="text" id="press" name="press" value="${journal.press }" data-options="required:true"></td>
	    		</tr>
	    		
	    		
	    		<tr>
	    			<td>定期:</td>
	    			<td><input class="easyui-textbox" type="text" id="orderDate" name="orderDate" value="${journal.orderDate }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>内容:</td>
	    			<td><input class="easyui-textbox" type="text" id="content" name="content" value="${journal.content }" data-options="required:true,multiline:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>上传图片:</td>
	    			<td><input  id="upload" type="file" name="imageFile" data-options="buttonText:'选择文件'"></td>
	    		</tr>
	    		
    		</table>
		</form>
		<div id="imgPrev">
			<h2>缩略图</h2>
			<img id="img">
		</div>
	</div>
	<script>
		$("#upload").change(function(){
			var objUrl = getObjectURL(this.files[0]) ;
			$('#img').attr("src", objUrl);
			$('#img').attr("width", "160px");
		}) ;
		//建立一個可存取到該file的url
		function getObjectURL(file) {
			var url = null ; 
			if (window.createObjectURL!=undefined) { // basic
				url = window.createObjectURL(file) ;
			} else if (window.URL!=undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file) ;
			} else if (window.webkitURL!=undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file) ;
			}
			return url ;
		}
	</script>
</body>
</html>