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
<html lang="zh-cn">
  <head>
    <base href="<%=basePath%>">
    
    <title>V2-用电数据汇总</title>
		<title>v2-用电数据汇总</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="<%=basePath%>/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
		<link href="<%=basePath%>/js/layui/css/layui.css" rel="stylesheet"/>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/woodare/css/comm.css" />
		
		<script  src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>

		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script language="javascript" type="text/javascript" src="<%=basePath%>/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src='<%=basePath%>/js/echarts.js'></script>
		<script type="text/javascript">
             $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
        </script> 
        <script type="text/javascript" src='<%=basePath%>/js/layui/layui.js'></script>
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
	<h4>原始上传数据-阶跃</h4>	
    <!--搜索开始-->
     <form method="post" action="" id="formId" class="form-inline">
	<div class="search">
    	<lable>
        	<span>终端</span>
            <select  name="cDistrictbcdid" id="cDistrictbcdid">
                    <c:if test="${!empty dlist }">
                    	<c:forEach items="${dlist }" var="x">
                    		 <option value="${x.cDistrictbcdid}-${x.cAddressid}">${x.cDistrictbcdid}-${x.cAddressid}-${x.cChannelnum}</option>
                    	</c:forEach>
                    </c:if>
                </select>
    	</lable>
        <lable>
        	<span>通道</span>
             <select name="cChannelid" id="cChannelid" class="">
                      <c:forEach begin="1" end="12" var="x">
                     	 <option value="${x}">${x}</option>
                      </c:forEach>
			 </select>
    	</lable>
        <lable>
        	<span>日期</span>
            <input id="d11" type="text" name="cRecorddatebcd" id="cRecorddatebcd" value="2017-12-14" onClick="WdatePicker()"/>
    	</lable>
        <lable>
        	<span>大类</span>
            <select  name="cEegrpid" id="cEegrpid" onchange="changeProvince(this);">
        		<c:if test="${!empty listEE }">
	            	<c:forEach items="${listEE}" var="x">
	            		<option value="${x.v }">${x.n }</option>
	            	</c:forEach>
            	</c:if>
            </select>
    	</lable>
        <lable>
        	<span>小类</span>
             <select  name="cEehexid" id="cEehexid" >
            </select>
    	</lable>
         <lable>
        	<span>功率小值</span>
            <input type="text" name="minPower" id="minPower" value="0" >
    	</lable>
        <lable>
        	<span>功率大值</span>
            <input type="text" name="maxPower" id ="maxPower" value="100000" >
    	</lable>
        <lable>
        	<span>开始时间</span>
             <select name="minTime" id="minTime">
              <c:if test="${!empty timeList }">
                 	<c:forEach items="${timeList }" var="x">
                 		 <option value="${x.count}">${x.dateHm}</option>
                 	</c:forEach>
                 </c:if>
             </select>
    	</lable>
        <lable>
        	<span>结束时间</span>
             <select name="maxTime" id="maxTime" >
				<c:if test="${!empty timeList }">
                 	<c:forEach items="${timeList }" var="x">
                 		 <option value="${x.count}">${x.dateHm}</option>
                 	</c:forEach>
                 </c:if>
             </select>
    	</lable>
        <div class="but-nav">
            <span class="but" onClick="drawOriTable()">查询原始数据</span>
        </div>
            <c:if test="${!empty olist }">
              	<c:forEach items="${olist }" var="x">
              		  ${(empty x.cTkwh)? '00' : x.cTkwh}
              	</c:forEach>
              </c:if>
			<hr>
	</div>
    <!--搜索结束/-->
    	<!--表格开始-->
    	 <div id="v51msg"> </div>
		          <div class="table-box">
			   <table class="table table-bordered" id="v31">			
			    </table>
			    </div>
	<!--表格结束/-->
	</form>
  
</div>
<!--主体结束/-->
</body>

</script>	
<script src="http://cdn.staticfile.org/zepto/1.0/zepto.min.js"></script>
<script src="<%=basePath%>/js/cxselect/jquery.cxselect.js"></script>
<script>
// (function() {
//   var urlEE = '<%=basePath%>/edata/listEE.shtml';

//   $.cxSelect.defaults.url = urlEE;

//   // 默认
//   $('#city_china').cxSelect({
//     selects: ['province', 'city'],
//     jsonValue: 'v'
//   });

 
// })();
/**
*选择大类展示小类
**/
function changeProvince(obj){
 	var urlEE = '<%=basePath%>/edata/listEE.shtml';
	var province = $(obj).val();
	$.ajax({
       type: "POST",
       url: urlEE,
       success: function (data) {
       if(data){
       		$("#cEehexid").html("");
       		for(var i =0;i<data.length;i++){
       			var json = data[i];
       			var v = json["v"];
       			if(v == province){
       				var cityList = json["s"];
       				var htmls = new Array();
       				for(var j = 0 ;j < cityList.length;j++){
       					var tempJson= cityList[j];
       					htmls.push("<option value-=\"" + tempJson["v"] + "\">" + tempJson["n"] + "</option>");
       				}
       				$("#cEehexid").append(htmls.join(",",""));
       			}
       		}
       }
       }
   })
}
</script>
<script type="text/javascript">

//用来作电器的表格，目的：easy
function drawOriTable(){
  var cDistrictbcdid = $('#cDistrictbcdid').val(),
    cChannelid = $('#cChannelid').val(),
    cEegrpid = $('#cEegrpid').val(),
    cEehexid = $('#cEehexid').val(),
    minPower = $('#minPower').val(),
    maxPower = $('#maxPower').val(),
    minTime = $('#minTime').val(),
    maxTime = $('#maxTime').val(),
    cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
    date1=$('#d11').val()+"用电量分析";
    layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#v31'
	    ,url:'<%=basePath%>/edata/getYuanshiV41.shtml'
	    ,method:"post"
	    ,where:{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cEehexid:cEehexid,cRecorddatebcd:cRecorddatebcd,minPower:minPower,maxPower:maxPower,minTime:minTime,maxTime:maxTime}
	    ,cols: [[
	      {field:'C_TSegmentId', width:100, title: '时段号', sort: true}
	      ,{field:'C_TSegmentName', width:100, title: '时段',sort:true}
	      ,{field:'C_EEClassificationName', width:100, title: '电器名', sort: true}
	      ,{field:'C_EESequenceId', width:120, title: '内部编号',sort:true}
	      ,{field:'C_JumpSecond', title: '阶跃时刻/秒', width:100,sort:true}
	      ,{field:'C_KW', width:120, title: '阶跃功率/W', sort: true}
	      ,{field:'C_FrameCmdId', width:100, title: '帧序列域',sort:true}
	      ,{field:'C_ParaId', width:100, title: '参数', sort: true}
	    ]]
	    ,page: true
	  });
	});
}
</script>
<#-- 设置最后一个选项被选中 -->
<script>
	$(document).ready(function(){
		$('#maxTime option:last').attr('selected',true);
        //或者：$('#test option:last').attr('selected','selected');
    })
</script>

