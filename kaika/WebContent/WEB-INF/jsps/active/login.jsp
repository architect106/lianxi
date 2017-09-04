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
</head>
<body id="login">
	
    <div class="nr">
        <div class="images">
        	<img src="<%=tomcatPath%>${journal.image }" width="130px"/>
        </div>
        <div class="word">
         <span style="font-size:22px;font-weight:600;">${journal.journal }
         </span><br><br><b style="font-weight:600;">出版社 : </b> <br>
         <span style="font-weight: 100">${journal.press }</span>
            <!--<br><a href="#" class="read">+ 订阅</a>-->
        </div>
        <div class="passage">
            ${journal.content }
        </div>
    </div>
    <div class="input1">
        <input type="text" name="number" id="name" class="name" >
    </div>
    <div class="input2">
        <input type="text" name="password" id="phone">
    </div>
    <button class="button1" onclick="submit()"></button>
    <button class="button2" onclick="check()"></button>
    
	<script type="text/javascript">
	
		function check(){
			var name = $("#name").val().trim();
			var password = $("#phone").val().trim();
			if(name==null || name==void(0)||name=="" || password==null || password==void(0) || password==""){
				layer.open({
					content:"卡号或密码不能为空",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
					,anim: 'up'
				}); 
			}else{
				$.post("<%=basePath%>active/activeCheck.do", {number: name, password:password },
					function(data){
						layer.open({
							content:data.message,
							btn: '确定',
							time: 0,
							style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px'
							,anim: 'up'
						});
					},"json");
				}
		}
		
		function submit(){
			var name = $("#name").val().trim();
			var password = $("#phone").val().trim();
			if(name==null || name==void(0)||name=="" || password==null || password==void(0) || password==""){
				layer.open({
					content:"卡号或密码不能为空",
					btn: '确定',
					time: 0,
					style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px',
					anim: 'up'
				});
			}else{
				$.ajax({
					url: "<%=basePath%>active/activeLogin.do",
					method: 'POST',
					data: {number: name, password: password},
					dataType: "json",
					success: function(data){
		                if(data.success){
							window.location.href= "<%=basePath%>active/toActiveCard.do";
						}else{
							layer.open({
								content:data.message,
								btn: '确定',
								time: 0,
								style: 'background-color:#ff9900; color:#fff; border:none;font-size:20px',
								anim: 'up'
							});
						}
					}
				});
			}
		}
	</script>
</body>
</html>