<%@ page language="java"  pageEncoding="UTF-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
 %> 

<!DOCTYPE html>
<!-- <html> -->
  <head>
    <base href="<%=basePath%>">
    
    <title>V2-用电数据汇总</title>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/woodare/css/comm.css" />
	<script src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
	<script src="<%=basePath%>/woodare/js/menu.js"></script>
	<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
	<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  </head>
  
  <body>
   <!--页眉开始-->
	<%--引入头部<@_top.top 3/>--%>
	<jsp:include page="../common/top.jsp"></jsp:include>
	<!--页眉结束/-->

	<!--左侧导航开始-->
	<jsp:include page="../common/left.jsp"></jsp:include>
	<!--左侧导航结束/-->
	<!--主体开始-->
	<div class="wapp-main">
	<h4>密码修改</h4>
    
    <!--资料编辑开始-->
    <div class="datum">
    	<form id="formId" enctype="multipart/form-data" action="<%=basePath%>/user/updatePswd.shtml" method="post">
        <table width="100%">
            <tr>
                <td width="30%" align="center">原密码</td>
                <td width="70%" align="center"><input name=""  id="pswd" maxlength="20" name="pswd"  type="text" placeholder="请输入原密码"></td>
            </tr>
            <tr>
                <td align="center">新密码</td>
                <td align="center"><input id="newPswd" maxlength="20" name="newPswd"type="text" placeholder="请输入新密码"></td>
            </tr>
            <tr>
                <td align="center">再输一次</td>
                <td align="center"><input id="reNewPswd" maxlength="20" name="reNewPswd" type="text" placeholder="请再次输入新密码"></td>
            </tr>
        </table>
        <div class="but-nav">
            <span class="but" onclick="$('#submitButton').submit()">保&nbsp;&nbsp;存</span>
			 <button style="display: none;" type="submit" id="submitButton">确定修改</button>
        </div>
        </form>
    </div>
    <script src="<%=basePath%>/js/common/jquery/jquery.form-2.82.js"></script>
		<script>
			$(function(){
				var load;
				$("#formId").ajaxForm({
			    	success:function (result){
			    		layer.close(load);
			    		if(result && result.status != 200){
			    			return layer.msg(result.message,function(){}),!1;
			    		}else{
				    		layer.msg('操作成功！');
				    		$("form :password").val('');
			    		}
			    	},
			    	beforeSubmit:function(){
			    		//判断参数
			    		if($.trim($("#pswd").val()) == ''){
				    		layer.msg('请输入原密码',function(){});
				    		$("#pswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#pswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($.trim($("#newPswd").val()) == ''){
				    		layer.msg('请输入新密码',function(){});
				    		$("#newPswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#newPswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($.trim($("#reNewPswd").val()) == ''){
				    		layer.msg('请再次输入新密码',function(){});
				    		$("#reNewPswd").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#reNewPswd").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		if($("#reNewPswd").val() != $("#newPswd").val()){
			    			return layer.msg('2次新密码输入不一致。',function(){}),!1;
			    		}
			    		load = layer.load('正在提交！！！');
			    	},
			    	dataType:"json",
			    	clearForm:false
				});
			
		});
		</script>
    <!--资料编辑结束/-->
</div>
<!--主体结束/-->
  </body>
</html>
