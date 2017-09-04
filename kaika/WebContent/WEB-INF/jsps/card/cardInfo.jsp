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
	<script>
		/*二级联动*/
	    $(function(){
	    	var url = "<%=basePath%>area/listArea.do";
	    	var data = {"pid":"0"};
	    	var id = $("#id").val();
	    	var region = $("#regionKey").val();
	        $.ajax({
	            url: url,
	            method: 'POST',
	            data: data,
				dataType: "json",
	            success: function(data){
	            	$.each(data.options, function(i, n){
	            		var value = data.options[i].id;
	            		var name = data.options[i].name;
	            		if(region==value){
	            			var option = "<option value="+ value +" selected='selected'>"+ name +"</option>";
	            			$('#region').append(option);
	            		}else{
	            			var option = "<option value="+ value +">"+ name +"</option>";
	            			$('#region').append(option);
	            		}
	            	});
	            	//新增 把二级菜单更新出来
	            	if(id!=""){
	    				var url = "<%=basePath%>area/listArea.do";
	    		    	var data = {"pid":region};
	    		    	var street = $("#streetKey").val();
	    		    	$.ajax({
	    		            url: url,
	    		            method: 'POST',
	    		            data: data,
	    					dataType: "json",
	    		            success: function(data){
	    		            	$.each(data.options, function(i, n){
	    		            		var value = data.options[i].id;
	    		            		var name = data.options[i].name;
	    		            		if(street==value){
	    		            			var option = "<option value="+value+" selected='selected'>"+name+"</option>";
		    		            		$('#street').append(option);
	    		            		}else{
	    		            			var option = "<option value="+value+">"+name+"</option>";
		    		            		$('#street').append(option);
	    		            		}
	    		            	});
	    		            }
	    		        });
	            	}
	            }
	        });
	        
	        $("#region").change(function(){
	        	$("#street").find("option").remove();
	        	var id = $('#region option:selected') .val();
				var url = "<%=basePath%>area/listArea.do";
		    	var data = {"pid":id};
		        $.ajax({
		            url: url,
		            method: 'POST',
		            data: data,
					dataType: "json",
		            success: function(data){
		            	$.each(data.options, function(i, n){
		            		var value = data.options[i].id;
		            		var name = data.options[i].name;
	            			var option = "<option value="+value+">"+name+"</option>";
		            		$('#street').append(option);
		            	});
		            }
		        });
	    	});
	    	
	    });
		
	</script>
	<div style="padding: 15px 50px 20px 50px">
		<form id="ff" class="easyui-form" data-options="novalidate:true" action="<%=basePath%>card/handleCardInfo.do" method="post">
			<input type="hidden" id="id" name="id" value="${card.id}">
			<input type="hidden" id="regionKey" value="${card.region }" >
			<input type="hidden" id="streetKey" value="${card.street }" >
			<input type="hidden" id="status" value="${card.status }" >
			
			<table cellpadding="5">
			
				<tr>
	    			<td>卡号:</td>
	    			<td>
	    				<input id="number" class="easyui-textbox" type="text" name="number" value="${card.number }"
	    					<c:if test="${card.id ne null }"> 
	    						readonly="readonly"
	    					</c:if>
	    					data-options="required:true">
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>密码:</td>
	    			<td><input id="password" class="easyui-textbox" type="text" name="password" value="${card.password }" 
	    					<c:if test="${card.id ne null }"> 
	    						readonly="readonly"
	    					</c:if>
	    					data-options="required:true"></td>
	    		</tr>
	    		
	    		<c:if test="${card.id ne null && card.status eq 1}">
	    		
	    		<tr>
	    			<td>名字:</td>
	    			<td><input id="name" class="easyui-textbox" type="text" name="name" value="${card.name }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>学校:</td>
	    			<td><input id="school" class="easyui-textbox" type="text" name="school" value="${card.school }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>手机:</td>
	    			<td><input id="mobile" class="easyui-textbox" type="text" name="mobile" value="${card.mobile }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>邮编:</td>
	    			<td><input id="zipcode" class="easyui-textbox" type="text" name="zipcode" value="${card.zipcode }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>区域:</td>
	    			<td>
	    			<select id="region" name="region" style="width:120px">
			            <option value="-1">请选择区域</option>
			        </select>
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>街道:</td>
	    			<td>
	    			<select id="street" name="street" style="width:120px">
			            <option value="-1">请选择街道</option>
			        </select>
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>地址:</td>
	    			<td><input id="road" class="easyui-textbox" type="text" name="road" value="${card.road }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>门牌号:</td>
	    			<td><input id="doorplate" class="easyui-textbox" type="text" name="doorplate" value="${card.doorplate }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>房间号:</td>
	    			<td><input id="room" class="easyui-textbox" type="text" name="room" value="${card.room }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>杂志:</td>
	    			<td><input id="jouranl" class="easyui-textbox" type="text" name="jouranl" value="${card.jouranl }" data-options="required:true"></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>备注:</td>
	    			<td><input id="remark" class="easyui-textbox" type="text" name="remark" value="${card.remark }" data-options="required:true"></td>
	    		</tr> 
	    		</c:if>
	    		
    		</table>
		</form>
	</div>
</body>
</html>