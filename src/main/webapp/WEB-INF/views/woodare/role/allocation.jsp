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
		<link   rel="icon" href="<%=basePath%>/favicon.ico" type="image/x-icon" />
	<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
	<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
	<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/woodare/css/comm.css" />
	<script  src="http://open.itboy.net/common/jquery/jquery1.8.3.min.js"></script>
	<script src="<%=basePath%>/woodare/js/menu.js"></script>
	<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
	<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script >
		so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要清除的用户。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</shiro:hasPermission>
			});
			<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
			<!--根据ID数组清空用户的角色-->
			function deleteById(ids){
				var index = layer.confirm("确定清除这"+ ids.length +"个用户的角色？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/role/clearRoleByUserIds.shtml',{userIds:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.message);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			<shiro:hasPermission name="/role/addRole2User.shtml">
			<!--选择角色后保存-->
			function selectRole(){
				var checked = $("#allotRoleDiv  :checked");
				var ids=[],names=[];
				$.each(checked,function(){
					ids.push(this.id);
					names.push($.trim($(this).attr('name')));
				});
				var index = layer.confirm("确定操作？",function(){
					<!--loding-->
					var load = layer.load();
					$.post('<%=basePath%>/role/addRole2User.shtml',{ids:ids.join(','),userId:$('#selectUserId').val()},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!1;
						}
						$("#allotRoleDiv").hide();
						layer.msg('添加成功。');
						setTimeout(function(){
							$('#formId').submit();
						},1000);
					},'json');
				});
			}
			/*
			*根据角色ID选择权限，分配权限操作。
			*/
			function selectRoleById(id){
				var load = layer.load();
				$.post("<%=basePath%>/role/allotRole.shtml",{id:id},function(result){
					$('#selectUserId').val(id);
					layer.close(load);
					if(result && result.length){
						$("#allotRoleDiv").html(result);
						$("#allotRoleDiv").show();
					}
				});
			}
			</shiro:hasPermission>
		</script>
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
	<h4>角色分配</h4>	
		<form method="post" action="" id="formId" class="form-inline">
    <!--搜索开始-->
	<div class="search">
        <lable>
        	<span class="wd01">角色类型/名称</span>
            <input  value="${(empty findContent)? '' : findContent}" name="findContent" id="findContent" type="text" class="long" placeholder="输入角色类型/名称">
    	</lable>
        <div class="but-nav">
        	<button type="submit" class="btn btn-primary" style="background-color: #169274;">查询</button>
        </div>
	</div>
    <!--搜索结束/-->
    
    <!--其他操作开始-->
    <div class="other-nav">
    	<div class="but-nav">
    		<shiro:hasPermission name="/role/clearRoleByUserIds.shtml">
        		<span class="icon05"  id="deleteAll"  class="btn  btn-danger">清空用户角色</span>
        	</shiro:hasPermission>
        </div>
    </div>
    <!--其他操作结束/-->
    
    <!--表格开始-->
    <div class="table-box">
    	<input type="hidden" id="selectUserId">
        <table width="100%">
            <tr>
                <th><input type="checkbox" id="checkAll"/></th>
                <th>用户昵称</th>
                <th>Email/账号</th>
                <th>状态</th>
                <th>拥有的角色</th>
                <th>操作</th>
            </tr>
            <c:choose>
            	<c:when test="${!empty page }">
            		<c:choose>
            			<c:when test="${!empty page.list }">
            				<c:forEach var="it" items="${page.list }" >
		            			 <tr>
					               <td align="center"><input value="${it.id}" check='box' type="checkbox" /></td>
									<td align="center">${(empty it.nickname)? '' : it.nickname}</td>
									<td align="center">${(empty it.email)? '' : it.email}</td>
									<td align="center">${(it.status== 1)? '有效' : '禁止'}</td>
									<td align="center"  roleIds="${(empty it.roleIds)? '' : it.roleIds}">${(empty it.roleNames)? '-' : it.roleNames}</td>
									<td align="center">
										<shiro:hasPermission name="/role/addRole2User.shtml">
											<span class="icon07" onclick="javascript:selectRoleById('${it.id}');">选择角色</span>
										</shiro:hasPermission>
									</td>
					            </tr>
		            		</c:forEach>
            			</c:when>
            			<c:otherwise>
            				<tr>
								<td class="text-center danger" colspan="5">没有找到用户</td>
							</tr>
            			</c:otherwise>
            		</c:choose>
            	</c:when>
            	<c:otherwise>
            		<tr>
						<td class="text-center danger" colspan="5">没有找到用户</td>
					</tr>
            	</c:otherwise>
            </c:choose>
        </table>
         <!--弹层开始-->
<div class="wapp-layer" id="allotRoleDiv">
</div>
<!--弹层结束/-->
	<c:if test="${!empty page }">
        <c:if test="${!empty page.list }">
	   		 <div class="pagination pull-right">
				${page.pageHtml}
			 </div>
		</c:if>
	</c:if>
	<!--     分页结束  -->
	</form>
</div>    
	<!-- 表格结束 -->
	</html>
</body>


