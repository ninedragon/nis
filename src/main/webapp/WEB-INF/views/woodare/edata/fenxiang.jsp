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
		        <style type="text/css">  
            .dropdown-submenu {  
                position: relative;  
            }  
            .dropdown-submenu > .dropdown-menu {  
                top: 0;  
                left: 100%;  
                margin-top: -6px;  
                margin-left: -1px;  
                -webkit-border-radius: 0 6px 6px 6px;  
                -moz-border-radius: 0 6px 6px;  
                border-radius: 0 6px 6px 6px;  
            }  
            .dropdown-submenu:hover > .dropdown-menu {  
                display: block;  
            }  
            .dropdown-submenu > a:after {  
                display: block;  
                content: " ";  
                float: right;  
                width: 0;  
                height: 0;  
                border-color: transparent;  
                border-style: solid;  
                border-width: 5px 0 5px 5px;  
                border-left-color: #ccc;  
                margin-top: 5px;  
                margin-right: -10px;  
            }  
            .dropdown-submenu:hover > a:after {  
                border-left-color: #fff;  
            }  
            .dropdown-submenu.pull-left {  
                float: none;  
            }  
            .dropdown-submenu.pull-left > .dropdown-menu {  
                left: -100%;  
                margin-left: 10px;  
                -webkit-border-radius: 6px 0 6px 6px;  
                -moz-border-radius: 6px 0 6px 6px;  
                border-radius: 6px 0 6px 6px;  
            }  
        </style>
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
	<h4>分项能耗曲线</h4>	
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
        	<span>电器大类</span>
              <select name="cEegrpid" id="cEegrpid" class="">
						         <c:if test="${!empty eglist }">
                    	<c:forEach items="${eglist }" var="x"  varStatus="p">
                    		<c:if test="${p.index != 0 }">
                    			<option value="${(empty x.cEegrpid)? '2' : x.cEegrpid}">${x.cEegrpname}</option>
                    		</c:if>
                    	</c:forEach>
                    </c:if>
			 </select>
    	</lable>
        <lable>
        	<span>日期</span>
             <input id="d11" type="text" name="cRecorddatebcd" id="cRecorddatebcd" value="2017-12-14" onClick="WdatePicker()"/>
    	</lable>
		 <c:if test="${!empty timeList }">
                 	<c:forEach items="${timeList }" var="x">
                 		<div id ="t${x.count}" hidden="true">${x.dateHm}</div>
                 	</c:forEach>
                 </c:if>
                    <div class='result'>
					      </div>
        <div class="but-nav">
            <span class="but"  onClick="drawChart()">查询分项电量</span>
            <span class="but" onClick="drawOriTable()">查询原始数据</span>
        	<span class="but" onClick="drawQitingTable()">查询启停数据</span>
        </div>
          <c:if test="${!empty olist }">
              	<c:forEach items="${olist }" var="x">
              		  ${(empty x.cTkwh)? '00' : x.cTkwh}
              	</c:forEach>
              </c:if>
              <hr>
                              <div id="chart" style="width:1000px;height:400px;"></div>
                              <div id="datatable"></div>
                        <hr>	
                        <div class="table-box">	      
				         <table class="table table-bordered" id="v22">

					    </table>
					    </div>
					    <hr>
					    <div class="table-box">
					    <table class="table table-bordered" id="v23">
						
					    </table>
					    </div>
					<hr>
	</div>
	</form>
    <!--搜索结束/-->
    
</div>
<!--主体结束/-->
</body>
<script type="text/javascript">
  function drawChart(){
				        var myChart = echarts.init(document.getElementById('chart'));
					    var cDistrictbcdid = $('#cDistrictbcdid').val(),
					           cChannelid = $('#cChannelid').val(),
					           cEegrpid = $('#cEegrpid').val(),
					           cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
					           date1=$('#d11').val()+"用电量分析"
					           ;
     
					     myChart.showLoading(); 
					     $.post('<%=basePath%>/edata/getPowerEE.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd},function(data){
					     	console.log(data);
					     	if(data[0]!=null){
					     	$("#datatable").html("峰值功率为"+(data[0].EEpeak)+"W");
					       };
					     });
					     var timeseg=new Array(97);
					     var tzong=new Array(97);
					     var tbianshi=new Array(97);        
					   $.post('<%=basePath%>/edata/getFendataDraw.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd},function(data){
					   	var a = data.length;
					   	if(a!=0)
					   	{
		                    for(var i=0, j=0;i<97;i++){
		                    	if(j<data.length)
		                    	{
                                 if(parseInt(data[j].C_TSegmentId)==i)
                                 {tbianshi[i]=data[j].tbianshi; 
                                  j++;  
                                }
                                else
                                {
                                 tbianshi[i]=0;
                                   
                                }
                               }	
		                       //挨个取出时间并填入时间数组
                                 timeseg[i]=$("#t"+i).html();
		                     }
		                     timeseg[0]="00:00";
		                    myChart.hideLoading();    //隐藏加载动画
                           					    var options = {
					        title: {
					            text: date1,
					            x:'center'
					        },
					        tooltip: {
					            trigger: 'axis'
					        },
					       legend: {
					            data:['辨识电量'],
					            x:'left'
					        },
					        xAxis: {
                                name:"时间",
					            data: timeseg
					        },
					        yAxis: {
					            splitLine: {
					                show: false
					            },
					            name:'电能/度',
					            min:0
					        },
					        toolbox: {
					            left: 'right',
					            feature: {
					                dataZoom: {
					                    yAxisIndex: 'none'
					                },
					                restore: {},
					                saveAsImage: {}
					            }
					        },
					        dataZoom: [{
					            startValue: '2014-06-01'
					        }, {
					            type: 'inside'
					        }],
					        // visualMap: {
					        //     top: 10,
					        //     right: 10,
					        //     pieces: [{
					        //         gt: 0,
					        //         lte: 50,
					        //         color: '#096'
					        //     }, {
					        //         gt: 50,
					        //         lte: 100,
					        //         color: '#ffde33'
					        //     }, {
					        //         gt: 100,
					        //         lte: 150,
					        //         color: '#ff9933'
					        //     }, {
					        //         gt: 150,
					        //         lte: 200,
					        //         color: '#cc0033'
					        //     }, {
					        //         gt: 200,
					        //         lte: 300,
					        //         color: '#660099'
					        //     }, {
					        //         gt: 300,
					        //         color: '#7e0023'
					        //     }],
					        //     outOfRange: {
					        //         color: '#999'
					        //     }
					        // },
					        series:[{
					                 name: '辨识电量',
					                 type: 'line',
					                 smooth: true,
					                 data: tbianshi 
					                }]           

					    }; 
		                    myChart.setOption(options);
					   	}
					   	else
					   	{
					   		myChart.hideLoading(); 
					   		alert("当天无数据");
					   	}
				});
			}
</script>	
<script type="text/javascript">
//用来作电器的表格，目的：easy
function drawOriTable(){
  var cDistrictbcdid = $('#cDistrictbcdid').val(),
    cChannelid = $('#cChannelid').val(),
    cEegrpid = $('#cEegrpid').val(),
    cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
    date1=$('#d11').val()+"用电量分析";
    layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#v22'
	    ,url:'<%=basePath%>/edata/getFendataOriTable.shtml'
	    ,method:"post"
	    ,where:{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd}
	    ,cols: [[
	      {field:'cDistrictbcdid', width:100, title: '区域号', sort: true}
	      ,{field:'cAddressid', width:100, title: '终端号',sort:true}
	      ,{field:'cChannelid', width:100, title: '通道号', sort: true}
	      ,{field:'cRecorddatebcd', width:120, title: '日期',sort:true}
	      ,{field:'ts', title: '时段号', width:100,sort:true}
	      ,{field:'tbianshi', width:120, title: '辨识总电量', sort: true}
	    ]]
	    ,page: true
	  });
	});
}
</script>
<script type="text/javascript">
	//用来启停的table，目的：easy
function drawQitingTable(){
  var cDistrictbcdid = $('#cDistrictbcdid').val(),
    cChannelid = $('#cChannelid').val(),
    cEegrpid = $('#cEegrpid').val(),
    cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
    date1=$('#d11').val()+"用电量分析";
    console.log('ok------');
    layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#v23'
	    ,url:'<%=basePath%>/edata/getQitingTable.shtml'
	    ,method:"post"
	    ,limit:1000
	    ,limits:[]
	    ,where:{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd}
	    ,cols: [[
	      {field:'C_EESequenceId', width:100, title: '序号', sort: true}
	      ,{field:'starttime', width:100, title: '开始时间',sort:true}
	      ,{field:'endtime', width:100, title: '结束时间', sort: true}
	      ,{field:'power', title: '电量', width:100,sort:true}
	    ]]
	    ,page: true
	  });
	});
}
</script>
</html>

