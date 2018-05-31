<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
 %> 
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/user.login.js"></script>
<div class="wapp-head">
	<span class="link"></span>
	<div class="info">消息</div>
    <div class="lay" style="left:auto;right:0px;">
        <ul>
            <li class="mrr">江苏省南京市雨花台区1号变箱</li>
            <li class="mrr">江苏省南京市雨花台区2号变箱</li>
            <li class="mrr">江苏省南京市雨花台区3号变箱</li>
        </ul>
    </div>
	<div class="user">
	<!-- 登录用户信息名称 -->
	${(empty token.nickname)? '' : token.nickname}
	<span class="caret"></span></div>
    <div class="lay">
            <%--已经登录（包括记住我的）--%>
            	<c:choose>
						<c:when test="${token.status eq '1'}">
							<span class="caret"></span></a>
							<ul userid="${(empty token.id)? '' : token.id}">
								<li><a href="<%=basePath%>/user/index.shtml">个人资料</a></li>
								<li><a href="<%=basePath%>/role/mypermission.shtml">我的权限</a></li>
								<li><a onclick="logout();">退出登录</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<%--没有登录(游客)--%>
							<ul userid="${(empty token.id)? '' : token.id}">
								<li><aonclick="logout();">登录</a></li>
							</ul>
						</c:otherwise>
					</c:choose>
			 
    </div>
</div>