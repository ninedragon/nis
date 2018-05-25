<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>分项能耗曲线</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/js/layui/css/layui.css" rel="stylesheet"/>
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

		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>

		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
		<script language="javascript" type="text/javascript" src="${basePath}/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src='${basePath}/js/echarts.js'></script>
		<script type="text/javascript">
             $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
        </script> 
        <script type="text/javascript" src='${basePath}/js/layui/layui.js'></script>
           
	</head>
	<body data-target="#one" data-spy="scroll">
		<#--引入头部-->
		<@_top.top 4/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 100px;">
			<div class="row">
				<#--引入左侧菜单-->
				<@_left.edata 2/>
				<div class="col-md-10">
					<h2>分项能耗曲线</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">

					        <label>终端</label>
					        <select name="cDistrictbcdid" id="cDistrictbcdid" class="">
					        <#if dlist?exists>
					        <#list dlist as x>
                                <option value="${x.cDistrictbcdid}-${x.cAddressid}">${x.cDistrictbcdid}-${x.cAddressid}</option>
                            </#list>	
						    </#if>  
					        </select>
					        <label>通道</label>
					        <select name="cChannelid" id="cChannelid" class="">
					        <#list 1..12 as x>
                               <option value="${x}">${x}</option>
                            </#list>
					        		                   
					        </select>

					        <label>电器大类</label>
					        <select name="cEegrpid" id="cEegrpid" class="">
					        	<#if eglist?exists>
					            <#list eglist as x>
					               <#if x_index!=0>
					                  <option value="${x.cEegrpid?default('2')}">${x.cEegrpname}</option>
					               </#if>
					            </#list>   
						        </#if> 	
					        </select>
					        <label>日期</label>
					        <input id="d11" type="text" name="cRecorddatebcd" id="cRecorddatebcd" value="2017-12-14" onClick="WdatePicker()"/>
					        <#-- <label>开始时间段</label>
					        <select name="" id="" class="">
					         	<#list 0..96 as x>
                                 <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                            </select> -->
                            <#list 0..96 as x>
                                 <div id ="t${x}" hidden="true">${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}</div>
                            </#list>
					      <#--   <label>结束时间段</label>
					        <select>
					           	<#list 0..96 as x>
                                  <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                             </select> -->
					      </div>
					      <div class='result'>
					      </div>
					     <span class=""> <#--pull-right -->
				         	<button  type="button" class="btn btn-primary" onClick="drawChart()">查询分项电量</button>
				         	<button  type="button" class="btn btn-primary" onClick="drawOriTable()" >查询原始数据</button>
				         	<button  type="button" class="btn btn-primary" onClick="drawQitingTable()">查询启停数据</button>

				         </span>
				         <#if olist?exists && olist?size gt 0 >
				         <#list olist as x>
                                    ${x.cTkwh?string["00"]}
                         </#list>	
				         </#if>
				        </div>
				        <hr>
                              <div id="chart" style="width:1000px;height:400px;"></div>
                              <div id="datatable"></div>
                        <hr>		      
				         <table class="table table-bordered" id="v22">

					    </table>
					    <hr>
					    <table class="table table-bordered" id="v23">
						
					    </table>
					<hr>
					</form>
				</div>
			</div><#--/row-->
		</div>
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
					     $.post('${basePath}/edata/getPowerEE.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd},function(data){
					     	console.log(data);
					     	if(data[0]!=null){
					     	$("#datatable").html("峰值功率为"+(data[0].EEpeak)+"W");
					       };
					     });
					     var timeseg=new Array(97);
					     var tzong=new Array(97);
					     var tbianshi=new Array(97);        
					   $.post('${basePath}/edata/getFendataDraw.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd},function(data){
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
	    ,url:'${basePath}/edata/getFendataOriTable.shtml'
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
	    ,url:'${basePath}/edata/getQitingTable.shtml'
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