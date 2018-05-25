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
	<h4>Session详情</h4>
    
    <!--资料编辑开始-->
    <div class="datum">
        <table width="100%">
            <tr>
                <td width="40%" align="center">SessionID</td>
                <td width="60%" align="center">${(empty bo.sessionId)? '-' : bo.sessionId}<</td>
            </tr>
            <tr>
                <td align="center">Session创建时间</td>
                <td align="center"><fmt:formatDate value="${bo.startTime}" pattern="yyyy年MM月dd日 HH:mm" /></td>
            </tr>
            <tr>
                <td align="center">Session最后交互时间</td>
                <td align="center"><fmt:formatDate value="${bo.lastAccess}" pattern="yyyy年MM月dd日 HH:mm" /></td>
            </tr>
            <tr>
                <td align="center">Session状态</td>
                <td align="center">${(!empty bo.sessionStatus)? '有效' : '已踢出'}</td>
            </tr>
            <tr>
                <td align="center">Session Host</td>
                <td align="center">${(empty bo.host)? '-' : bo.host}</td>
            </tr>
            <tr>
                <td align="center">Session timeout</td>
                <td align="center">${bo.timeout}&nbsp;(毫秒) = ${bo.timeout/1000}(秒) = ${bo.timeout/1000/60}(分钟)</td>
            </tr>
            <tr>
                <td align="center">昵称</td>
                <td align="center">${(empty bo.nickname)? '-' : bo.nickname}</td>
            </tr>
            <tr>
                <td align="center">Email/账号</td>
                <td align="center">${(empty bo.email)? '-' : bo.email}</td>
            </tr>
            <tr>
                <td align="center">创建时间</td>
                <td align="center"><fmt:formatDate value="${bo.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
            </tr>
            <tr>
                <td align="center">最后登录时间</td>
                <td align="center"><fmt:formatDate value="${bo.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" /></td>
            </tr>
        </table>
        <div class="but-nav">
            <span class="but miss" onClick="location.href='<%=basePath%>/member/online.shtml'">返&nbsp;&nbsp;回</span>
        </div>
    </div>
    <!--资料编辑结束/-->
</div>
<!--主体结束/-->
  </body>
</html>
