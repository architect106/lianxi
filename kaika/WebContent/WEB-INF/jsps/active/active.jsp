<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>开卡订阅系统</title>
	<base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=no"/>
    <%@ include file="/common/css.jsp"%>
	<%@ include file="/common/js.jsp"%>	 
    <script>
    /*二级联动*/
	    $(function(){
	    	var url = "<%=basePath%>area/listArea.do";
	    	var data = {"pid":"0"};
	        $.ajax({
	            url: url,
	            method: 'POST',
	            data: data,
				dataType: "json",
	            success: function(data){
	            	$.each(data.options, function(i, n){
	            		var option = "<option value="+data.options[i].id+">"+data.options[i].name+"</option>";
	            		$('#select1').append(option);
	            	});
	            },
	            error: function(){
	                alert('error');
	            }
	        });
	
	        $("#select1").change(function(){
	        	$("#select2").find("option").remove();
	        	var id = $('#select1 option:selected') .val();
				var url = "<%=basePath%>area/listArea.do";
		    	var data = {"pid":id};
		        $.ajax({
		            url: url,
		            method: 'POST',
		            data: data,
					dataType: "json",
		            success: function(data){
		            	$.each(data.options, function(i, n){
		            		var option = "<option value="+data.options[i].id+">"+data.options[i].name+"</option>";
		            		$('#select2').append(option);
		            	});
		            },
		            error: function(){
		                alert('error');
		            }
		        });
	        });
	        
	    });
    </script>
</head>
<body id="information">
<!--<div data-role="content" class="body">-->
    <form>
        <div data-role="fieldcontain" class="box">
            <label for="name"> 姓名 :</label>
            <input type="text" name="name" id="name" maxlength="8"><br>
            <div class="line"></div>
            <label for="school"> 学校 :</label>
            <input type="text" name="school" id="school" maxlength="18"><br>
            <div class="line"></div>
            <label for="mobile"> 手机 :</label>
            <input type="text" name="mobile" id="mobile" onkeyup="this.value=this.value.replace(/[^0-9]+/,'');" maxlength="11"><br>
            <div class="line"></div>
            <label for="zipcode"> 邮编 :</label>
            <input type="text" name="zipcode" id="zipcode" onkeyup="this.value=this.value.replace(/[^0-9]+/,'');" maxlength="6"><br>
            <div class="line"></div>
            <b style="font-size:22px"> 杂志邮寄地址</b><br>
            <div class="line"></div>
            <label for="region">上海市</label>
            <select id="select1" name="region">
            <option value="">请选择:</option>
            </select><br>
            <label for="street">街道：</label>
            <select id="select2" name="street">
            <option></option>
            </select><br>
            <div class="line"></div>
            <input name="road" id="road" maxlength="40" placeholder="必填:XXX地址 "></input><br>
            <input name="doorplate" id="doorplate" maxlength="10" placeholder="选填:XXX弄XXX号"></input>&nbsp;
            <input name="room" id="room" maxlength="10" placeholder="选填:XXX室"></input>
            <div class="line"></div>
        </div>
    </form>
<!--</div>-->
    <button id="btn" onclick="submit()"></button>
	<script type="text/javascript">
		function submit(){
			var name = $.trim($("#name").val());
			var school = $.trim($("#school").val());
			var mobile = $.trim($("#mobile").val());
			var zipcode = $.trim($("#zipcode").val());
			var region = $("#region option:selected").text();
			var street = $("#street option:selected").text();
			var road = $.trim($("#road").val());
			var regsionVal = $("#region").val();
			var streetVal = $("#street").val();
			//这个用于验证
			var re = /^[\u4e00-\u9fa5a-z]+$/gi;
			if(name=="" || school=="" || mobile=="" ||zipcode=="" || regsionVal==0 || streetVal==0 || road==""){
				layer.open({
					content:"请补全信息",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
					,anim: 'up'
				});
			} else if(!re.test(school)){
				layer.open({
					content:"学校名不合法！",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
					,anim: 'up'
				});
			}else if(isNaN(mobile) || mobile.length!=11 || mobile.charAt(0)!="1"){
				layer.open({
					content:"您输入的手机号不合法",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
					,anim: 'up'
				});
			}else if(isNaN(zipcode) || zipcode.length!=6){
				layer.open({
					content:"您输入的邮编不合法",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
					,anim: 'up'
				});
			}else{
				$.post("<%=basePath%>active/activeCard.do",
						$("form").serialize()
					,function(data){
					if(data.success){
						layer.open({
							content:'提交成功',
							btn: '确定',
							time: 0,
							style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
							,anim: 'up'
							,yes: function(index){
								   window.location.href= "<%=basePath%>active/activeLogout.do";
							}
						});
					}else{
						layer.open({
							content:data.message,
							btn: '确定',
							time: 0,
							style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
							,anim: 'up'
						});
					}
					
				}, "json");
			}
		}
	</script>
</body>
</html>