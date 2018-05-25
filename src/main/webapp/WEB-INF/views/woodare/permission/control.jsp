<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="box">
    	<h4>选择权限<span class="close-js"  onclick="$('#controlDiv').hide();">关闭</span></h4>
        <div class="edit">
            <lable>
                <input name="" type="checkbox" selectAllBox="" value="" class="checkbox"><span class="other">全选</span>
            </lable>
            <c:choose>
        		<c:when test="${!empty permissionBosList }">
        			<c:forEach items="${permissionBosList }" var="bos">
        				 <lable>
						    <c:choose>
						    	<c:when test="${bos.check }">
        				 		 	<input name="${bos.name }" id="${bos.id }" selectBox=''  checked="checked" type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:when>
	        				 	<c:otherwise>
	        				 		 <input name="${bos.name }" id="${bos.id }" selectBox='' type="checkbox" value="" class="checkbox"><span>${bos.name }</span>
	        				 	</c:otherwise>
						    </c:choose>	          
				         </lable>
				         </c:forEach>
        		</c:when>
        		<c:otherwise>
        			 <lable>没有获取到权限数据，请先添加权限数据。</lable>
        		</c:otherwise>
        	</c:choose>
        	 <div class="but-nav">
                <span class="but"  onclick="selectPermission();">保&nbsp;&nbsp;存</span>
                <span class="but miss close-js"  onclick="$('#controlDiv').hide();">取&nbsp;&nbsp;消</span>
            </div>
        </div>
    </div>