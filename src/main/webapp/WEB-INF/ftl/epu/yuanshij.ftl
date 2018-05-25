<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>原始上传数据-阶跃</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/js/layui/css/layui.css" rel="stylesheet"/>

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
				<@_left.edata 6/>
				<div class="col-md-10">
					<h2>原始上传数据-阶跃</h2>
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

					        
					        <label>日期</label>
					        <input id="d11" type="text" name="cRecorddatebcd" id="cRecorddatebcd" value="2017-10-20" onClick="WdatePicker()"/>
					        <fieldset id="city_china">
<#-- 					          <legend>默认</legend>
	-->					        <label for="">大类&nbsp;</label><select class="province " name="cEegrpid" id="cEegrpid">
									<option>请选择</option>
									</select>
								<label for="">小类&nbsp;</label><select class="city"  name="cEehexid" id="cEehexid">
									<option>请选择</option>
									</select>
								
					        </fieldset>
					        <label>功率小值</label>
					        <input type="text" name="minPower" id="minPower" value="0" style="width:100px; height:20px;">
					        <label>功率大值</label>	
					        <input type="text" name="maxPower" id ="maxPower" value="100000" style="width:100px; height:20px;"><br/>
					       <#--  <label>开始时间段</label>
					        <select name="" id="" class="">
					         	<#list 0..96 as x>
                                 <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                            </select> -->
                            <#list 0..96 as x>
                                 <div id ="t${x}" hidden="true">${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}</div>
                            </#list>
					        <#-- <label>结束时间段</label>
					        <select>
					           	<#list 0..96 as x>
                                  <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                             </select> -->
					        <label>开始时间</label>
					        <select name="minTime" id="minTime" class="" style="width:100px; height:20px;">
					         	<#list 1..96 as x>
                                 <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                            </select>
                            <#list 1..96 as x>
                                 <div id ="t${x}" hidden="true">${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}</div>
                            </#list>
					        <label>结束时间</label>
					        <select name="maxTime" id="maxTime" class="" style="width:100px; height:20px;">
					           	<#list 1..96 as x>
                                  <option value="${x}">${x?string["00"]}-[${((x/4)?int)?string["00"]}:${((x%4)*(15))?string["00"]}]</option>
                                </#list>
                             </select>
                             <br>
					      
					     <span class=""> <#--pull-right -->
				         	<button  type="button" class="btn btn-primary" onClick="drawOriTable()" >查询原始数据</button>
				         </span>
				         <#if olist?exists && olist?size gt 0 >
				         <#list olist as x>
                                    ${x.cTkwh?string["00"]}
                         </#list>	
				         </#if>
				        </div>
				        
				       
					    <table class="table table-bordered" id="v31">
						
					    </table>
					<hr>
					</form>
				</div>
			</div><#--/row-->
		</div>
	</body>

</script>	
<script src="http://cdn.staticfile.org/zepto/1.0/zepto.min.js"></script>
<script src="${basePath}/js/cxselect/jquery.cxselect.js"></script>
<script>
(function() {
  var urlEE = '${basePath}/edata/listEE.shtml';

  $.cxSelect.defaults.url = urlEE;

  // 默认
  $('#city_china').cxSelect({
    selects: ['province', 'city'],
    jsonValue: 'v'
  });

 
})();
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
	    ,url:'${basePath}/edata/getYuanshiV41.shtml'
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
</html>