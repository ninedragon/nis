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
	<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/user.login.js"></script>
	<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
	<script src="<%=basePath%>/woodare/js/menu.js"></script>
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
	<h4>个人资料</h4>
    
    <!--资料编辑开始-->
    <div class="datum">
        <table width="100%">
            <tr>
                <td width="35%" align="center">昵称</td>
                <td width="65%" align="center">${(empty token.nickname)? '' : token.nickname}</td>
            </tr>
            <tr>
                <td align="center">Email账号</td>
                <td align="center">${(empty token.email)? '' : token.email}</td>
            </tr>
            <tr>
                <td align="center">创建时间</td>
                <td align="center">
                	<fmt:formatDate value="${token.createTime}" pattern="yyyy-MM-dd HH:mm" />
                </td>
            </tr>
            <tr>
                <td align="center">最后登录时间</td>
                <td align="center"><fmt:formatDate value="${token.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" /></td>
            </tr>
        </table>
    </div>
    <!--资料编辑结束/-->
</div>
<!--主体结束/-->
  </body>
</html>
