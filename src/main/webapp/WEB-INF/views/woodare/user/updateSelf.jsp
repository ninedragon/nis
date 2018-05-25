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
		<h4>资料修改</h4>
	    
	    <!--资料编辑开始-->
	   <div class="datum">
	   		<form id="formId" enctype="multipart/form-data" action="<%=basePath%>/user/updateSelf.shtml" method="post">
	       <table width="100%">
	       	  <input type="hidden" value="${token.id}" name="id"/>
	           <tr>
	               <td width="30%" align="center">昵称</td>
	               <td width="70%" align="center">
	               	<input  id="nickname"  name="nickname" type="text" value="${(empty token.nickname)? '' : token.nickname}">
	               </td>
	           </tr>
	           <tr>
	               <td align="center">Email账号</td>
	               <td align="center"><input name="email" id="email" type="text" value="${(empty token.email)? '' : token.email}" readonly><font class="tips">不准修改</font></td>
	           </tr>
	       </table>
	       <div class="but-nav">
	           <span class="but" onclick="$('#submitButton').submit()">保&nbsp;&nbsp;存</span>
			 	<button style="display: none;" type="submit" id="submitButton">确定修改</button>
	       </div>
	       </form>
	   </div>
	   <!--资料编辑结束/-->
	</div>
	<!--主体结束/-->
	<script src="<%=basePath%>/js/common/jquery/jquery.form-2.82.js"></script>
	<script>
			$(function(){
				var load;
				$("#formId").ajaxForm({
			    	success:function (result){
			    		layer.close(load);
			    		if(result && result.status == 300){
			    			layer.msg(result.message,function(){});
			    			return !1;
			    		}
			    		if(result && result.status == 500){
			    			layer.msg("操作失败！",function(){});
			    			return !1;
			    		}
			    		layer.msg('操作成功！');
			    	},
			    	beforeSubmit:function(){
			    		//判断参数
			    		if($.trim($("#nickname").val()) == ''){
				    		layer.msg('昵称不能为空！',function(){});
				    		$("#nickname").parent().removeClass('has-success').addClass('has-error');
				    		return !1;
			    		}else{
			    			$("#nickname").parent().removeClass('has-error').addClass('has-success');
			    		}
			    		load = layer.load();
			    	},
			    	dataType:"json",
			    	clearForm:false
				});
			
		});
		</script>
  </body>
</html>
