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
	<script src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
	<script src="<%=basePath%>/woodare/js/menu.js"></script>
	<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
	<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script  src="<%=basePath%>/js/shiro.demo.js"></script>
	<script >
		var obj = {
			status : null,//状态值
			id : null,//记录主键
			ids : null,//多个记录主键
			operate : null //何种动作操作 forbid ：禁止或激活  del：删除
		};
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/member/deleteUserById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return _delete(array);
				});
				</shiro:hasPermission>
			});
			<shiro:hasPermission name="/member/deleteUserById.shtml">
			//根据ID数组，删除
			function _delete(ids){
				obj.ids =ids;
				obj.operate="del";
				$("#statusSpan").html("确定删除这"+ ids.length +"个用户？");
				$(".wapp-layer").show();
			}
			</shiro:hasPermission>
			<shiro:hasPermission name="/member/forbidUserById.shtml">
			/*
			*激活 | 禁止用户登录
			*/
			function forbidUserById(status,id){
				obj.status = status;
				obj.id = id;
				obj.operate = "forbid";
				var text = status?'激活':'禁止';
				$("#statusSpan").html("确定"+text+"这个用户？");
				$(".wapp-layer").show();
			}
			</shiro:hasPermission>
			/**执行激活 | 禁止用户登录更新状态操作**/
			function updatestatus(){
				if(obj.operate == "forbid"){//激活/禁止
					var text = obj.status?'激活':'禁止';
					var load = layer.load();
					$.post('<%=basePath%>/member/forbidUserById.shtml',{status:obj.status,id:obj.id},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							$(".wapp-layer").hide();
							layer.msg(text +'成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
				}else if(obj.operate == "del"){//删除
					var load = layer.load();
					$.post('<%=basePath%>/member/deleteUserById.shtml',{ids:obj.ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							$(".wapp-layer").hide();
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
				}
			}
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
	<form method="post" action="" id="formId" class="form-inline">
	<h4>管理列表</h4>	
    <!--搜索开始-->
	<div class="search">
        <lable>
        	<span class="wd01">输入昵称/账号</span>
            <input name="findContent" id="findContent"   value="${(empty findContent)? '' : findContent}"  type="text" class="long" placeholder="输入昵称/账号">
    	</lable>
        <div class="but-nav">
<!--         	<span class="but">查&nbsp;&nbsp;询</span> -->
				<button type="submit" class="btn btn-primary" style="background-color: #169274;">查询</button>
        </div>
	</div>
    <!--搜索结束/-->
    
    <!--其他操作开始-->
    <div class="other-nav">
    	<div class="but-nav">
    		<shiro:hasPermission name="/member/deleteUserById.shtml">
           	 <span class="icon03"  id="deleteAll" >删除</span>
            </shiro:hasPermission>
        </div>
    </div>
    <!--其他操作结束/-->
    
    <!--表格开始-->
    <div class="table-box">
        <table width="100%">
            <tr>
                <th><input  type="checkbox" id="checkAll"></th>
                <th>昵称</th>
                <th>Email账号</th>
                <th>登录状态</th>
                <th>创建时间</th>
                <th>最后登录时间</th>
                <th>操作</th>
            </tr>
            <c:choose>
            	<c:when test="${!empty page }">
            		<c:choose>
            			<c:when test="${!empty page.list }">
            				<c:forEach var="it" items="${page.list }" >
		            			 <tr>
					                <td align="center"><input value="${it.id}" check='box' type="checkbox" ></td>
					                <td align="center">${(empty it.nickname)? '' : it.nickname}</td>
					                <td align="center">${(empty it.email)? '' : it.email}</td>
					                <td align="center">${(it.status== 1)? '有效' : '禁止'}</td>
					                <td align="center"><fmt:formatDate value="${it.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					                <td align="center"><fmt:formatDate value="${it.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					                <td align="center">
					               		 <shiro:hasPermission name="/member/forbidUserById.shtml">
												${(it.status==1)?'<i class="glyphicon glyphicon-eye-close"></i>&nbsp;':'<i class="glyphicon glyphicon-eye-open"></i>&nbsp;'}
												<a href="javascript:forbidUserById(${(it.status==1)?0:1},${it.id})">
													${(it.status==1)?'禁止登录':'激活登录'}
												</a>
												</shiro:hasPermission>
												<shiro:hasPermission name="/mem er/deleteUserById.shtml">
												<a href="javascript:_delete([${it.id}]);">删除</a>
												</shiro:hasPermission>
					                
					                </td>
					            </tr>
		            		</c:forEach>
            			</c:when>
            			<c:otherwise>
            				<tr>
								<td class="text-center danger" colspan="6">没有找到用户</td>
							</tr>
            			</c:otherwise>
            		</c:choose>
            	</c:when>
            	<c:otherwise>
            		<tr>
						<td class="text-center danger" colspan="6">没有找到用户</td>
					</tr>
            	</c:otherwise>
            </c:choose>
        </table>
    </div>
	<!--表格结束/-->
<!--     分页开始 -->
	<c:if test="${!empty page }">
        <c:if test="${!empty page.list }">
	   		 <div class="pagination pull-right">
				${page.pageHtml}
			 </div>
		</c:if>
	</c:if>
<!--     分页结束/ -->
    </form>
</div>
<!--主体结束/-->
</body>
</html>
<!--弹层开始-->
<div class="wapp-layer">
	<div class="box tips">
    	<h4>提示信息<span class="close-js" onclick="$('.wapp-layer').hide();">关闭</span></h4>
        <div class="edit">
            <p><sapn id="statusSpan"></sapn></p>
            <div class="but-nav">
                <span class="but" onclick="updatestatus();">确&nbsp;&nbsp;定</span>
                <span class="but miss close-js" onclick="$('.wapp-layer').hide();">取&nbsp;&nbsp;消</span>
            </div>
        </div>
    </div>
</div>
<!--弹层结束/-->
  </body>
</html>
