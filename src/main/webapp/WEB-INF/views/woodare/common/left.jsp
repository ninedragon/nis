<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
 %> 
<ul class="left-nav">
	<h4>末端电网感知系统</h4>
	 <%--  <li class="<c:if test="${leftMenuview eq 5 }">  on </c:if> big-js"  >实时监控</li>	
    <ul class="side-nav" <c:if test="${leftMenuview eq 5 }">  style="display:block" </c:if>>
    <li onClick="location.href='<%=basePath%>/epu/allShowList.shtml'">信息展现</li>
    </ul> --%>
    
   <%--   <li class="<c:if test="${leftMenuview eq 5 }">  on </c:if> big-js"  >实时监控</li> --%>	
    <ul class="<c:if test="${leftMenuview eq 5 }">  on </c:if> big-js" <c:if test="${leftMenuview eq 5 }">  style="display:block" </c:if>>
    <li onClick="location.href='<%=basePath%>/epu/allShowList.shtml'">实时监控</li>
    </ul>
	  <li class="<c:if test="${leftMenuview eq 3 }">  on </c:if> big-js">用电曲线数据</li>
    <ul class="side-nav"  <c:if test="${leftMenuview eq 3 }">  style="display:block" </c:if>>
    	<li onClick="location.href='<%=basePath%>/edata/zong.shtml'">总体能耗数据</li>
        <li onClick="location.href='<%=basePath%>/edata/fenxiang.shtml'">分项能耗数据</li>
        <li onClick="location.href='<%=basePath%>/edata/yuanshi.shtml'">原始上传数据</li>
        <li onClick="location.href='<%=basePath%>/edata/yuanshij.shtml'">原始上传数据-阶跃</li>
    </ul>
    <li class="<c:if test="${leftMenuview eq 4 }">  on </c:if> big-js">设备管理</li>	
    <ul class="side-nav" <c:if test="${leftMenuview eq 4 }">  style="display:block" </c:if>>
    <li onClick="location.href='<%=basePath%>/epu/showSubstainList.shtml'">箱变信息列表</li>
    <li onClick="location.href='<%=basePath%>/epu/showOutgoingcabinetList.shtml'">出线柜信息列表</li>
    <li onClick="location.href='<%=basePath%>/epu/showBranchboxList.shtml'">分支箱信息列表</li>
    <li onClick="location.href='<%=basePath%>/epu/showMeterboxList.shtml'">表箱信息列表</li>
    <li onClick="location.href='<%=basePath%>/ammeter/showAmList.shtml'">电表信息列表</li>
    </ul>
     <li class="<c:if test="${leftMenuview eq 1 }">  on </c:if>  big-js">用户中心</li>
    <ul class="side-nav" <c:if test="${leftMenuview eq 1 }">  style="display:block" </c:if>>
    	  <li onClick="location.href='<%=basePath%>/member/list.shtml'">管理列表</li>
    	 <li onClick="location.href='<%=basePath%>/member/online.shtml'">在线用户</li>
    	 <li  onClick="location.href='<%=basePath%>/member/list2.shtml'">居民列表</li> 
			
    </ul>    
     <li class="<c:if test="${leftMenuview eq 2 }">  on </c:if> big-js">权限管理</li>
    <ul class="side-nav" <c:if test="${leftMenuview eq 2 }">  style="display:block" </c:if>>
    	<li onClick="location.href='<%=basePath%>/role/index.shtml'">角色列表</li>
        <li onClick="location.href='<%=basePath%>/role/allocation.shtml'">角色分配</li>
        <li onClick="location.href='<%=basePath%>/permission/index.shtml'">权限列表</li>
        <li onClick="location.href='<%=basePath%>/permission/allocation.shtml'">权限分配-阶跃</li>
    </ul>
	<li class="<c:if test="${leftMenuview eq 0  or empty leftMenuview}">  on </c:if> big-js">个人中心</li>
    <ul class="side-nav" <c:if test="${leftMenuview eq 0 or empty leftMenuview}">  style="display:block" </c:if>>
        <li onClick="location.href='<%=basePath%>/user/index.shtml'">个人资料</li>
        <li onClick="location.href='<%=basePath%>/user/updateSelf.shtml'">资料修改</li>
        <li onClick="location.href='<%=basePath%>/user/updatePswd.shtml'">密码修改</li>
        <li onClick="location.href='<%=basePath%>/role/mypermission.shtml'">我的权限</li>
    </ul>
   
   
  
    
    
  
</ul>