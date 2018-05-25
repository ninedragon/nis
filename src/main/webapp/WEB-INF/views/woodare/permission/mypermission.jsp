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
		<link   rel="icon" href="<%=basePath%>/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
        <script  src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
        <script src="<%=basePath%>/woodare/js/menu.js"></script>
        <script  src="<%=basePath%>/js/common/layer/layer.js"></script>
        <script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script  src="<%=basePath%>/js/common/bootstrap/bootstrap-treeview.js"></script>
        <script  src="<%=basePath%>/js/shiro.demo.js"></script>
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
	<h4>我的权限</h4>
    
    <!--资料编辑开始-->
    <div  class="datum">
			<div class="more">
				<div id="getPermissionTree" >loding... ...</div>
			</div>
		</div>

		<script >
			$(function(){
				//加载 permission tree data
				var load = layer.load();
				$.post("<%=basePath%>/role/getPermissionTree.shtml",{},function(data){
					console.log(data);
					layer.close(load);
					if(data && !data.length){
						return $("#getPermissionTree").html('<code>您没有任何权限。只有默认的个人中心。</code>'),!1;
					}
					$('#getPermissionTree').treeview({
			          levels: 1,//层级
			          color: "#428bca",
			          nodeIcon: "glyphicon glyphicon-user",
			          showTags: true,//显示数量
			          data: data//数据
			        });
				},'json');
			});
		</script>
    <!--资料编辑结束/-->
</div>
<!--主体结束/-->
  </body>
</html>
