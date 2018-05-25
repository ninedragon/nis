<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <div class="edit">
            <lable>
                <span>昵称</span>
                <input id="nickname" name="nickname" type="text" value="${(empty it.nickname)? '' : it.nickname}">
            </lable>
            <lable>
                <span>Email</span>
                <input id="email" name="email" type="text" value="${(empty it.email)? '' : it.email}">
            </lable>
            <lable>
                <span>登录状态</span>
             	   <select id="status" name="status" >
	            	<option value="">请选择</option>
	            	<c:choose>
	            		<c:when test="${it.status== 0 }">
	            			<option  value="0"  selected="selected">禁止</option>
	            		</c:when>
	            		<c:otherwise>
	            			<option  value="0"  >禁止</option>
	            		</c:otherwise>
	            	</c:choose>
	            	<c:choose>
	            		<c:when test="${it.status== 1 }">
	            			<option  value="1" selected="selected" >有效</option>
	            		</c:when>
	            		<c:otherwise>
	            			<option  value="1" >有效</option>
	            		</c:otherwise>
	            	</c:choose>
	            </select>
            </lable>
            <lable>
                <span>创建时间</span>
                <input id="create_time" name="create_time" type="text" value="<fmt:formatDate value="${it.createTime}" pattern="yyyy-MM-dd HH:mm" />">
            </lable>
            <lable>
                <span>最后登录时间</span>
                <input id="last_login_time" name="last_login_time" type="text" value="<fmt:formatDate value="${it.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" />">
            </lable>
            <lable>
                <span>电表号</span>
                <input id="meter" name="meter" type="text" value="${(empty it.meter)? '' : it.meter}">
            </lable>
            <lable>
                <span>供电单位</span>
                <input id="supply" name="supply" type="text" value="${(empty it.supply)? '' : it.supply}">
            </lable>
            <lable>
                <span>家庭地址</span>
                <input id="location" name="location" type="text" value="${(empty it.location)? '' : it.location}">
            </lable>
            <lable>
                <span>门牌号</span>
                <input id="housenum" name="housenum" type="text" value="${(empty it.housenum)? '' : it.housenum}">
            </lable>
            <lable>
                <span>SIM卡号</span>
                <input id="sim" name="sim" type="text" value="${(empty it.sim)? '' : it.sim}">
            </lable>
            <lable>
                <span>绝对编号</span>
                <input id="absid" name="absid" type="text" value="${(empty it.absid)? '' : it.absid}">
            </lable>
            <lable>
                <span>设备版本号</span>
                <input id="version" name="version" type="text" value="${(empty it.version)? '' : it.version}">
            </lable>
            <div class="but-nav">
                <span class="but">保&nbsp;&nbsp;存</span>
                <span class="but miss close-js"  onclick="$('#saveDiv').hide();">取&nbsp;&nbsp;消</span>
            </div>
        </div>