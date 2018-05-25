<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="box ">
    	<h4>选择角色<span class="close-js" onclick="$('#allotRoleDiv').hide();">关闭</span></h4>
        <div class="edit">
        	<c:choose>
        		<c:when test="${!empty bosList }">
        			<c:forEach items="${bosList }" var="bos">
        				 <lable>
						    <c:choose>
						    	<c:when test="${bos.check }">
        				 		 	<input name="${bos.name }" id="${bos.id }"  checked="checked" type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:when>
	        				 	<c:otherwise>
	        				 		 <input name="${bos.name }" id="${bos.id }" type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:otherwise>
						    </c:choose>	          
				         </lable>
				         </c:forEach>
        		</c:when>
        		<c:otherwise>
        			 <lable>没有获取到用户数据，请先注册数据。</lable>
        		</c:otherwise>
        	</c:choose>
        	 <div class="but-nav">
                <span class="but" onclick="selectRole();">保&nbsp;&nbsp;存</span>
                <span class="but miss close-js"  onclick="$('#allotRoleDiv').hide();">取&nbsp;&nbsp;消</span>
            </div>
<div class="box checkbox">
    	<h4>选择角色<span class="close-js" onclick="$('#allotRoleDiv').hide();">关闭</span></h4>
        <div class="edit">
            <div class="but-nav">
                <span class="but" onclick="selectRole();">保&nbsp;&nbsp;存</span>
                <span class="but miss close-js"  onclick="$('#allotRoleDiv').hide();">取&nbsp;&nbsp;消</span>
            </div>
        	<c:choose>
        		<c:when test="${!empty bosList }">
        			<c:forEach items="${bosList }" var="bos">
        				 <lable>
						    <c:choose>
						    	<c:when test="${bos.check }">
        				 		 	<input name="${bos.name }" id="${bos.id }"  checked="checked" type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:when>
	        				 	<c:otherwise>
	        				 		 <input name="${bos.name }" id="${bos.id }" type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:otherwise>
						    </c:choose>	          
				         </lable>
				         </c:forEach>
        		</c:when>
        		<c:otherwise>
        			 <lable>没有获取到用户数据，请先注册数据。</lable>
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>