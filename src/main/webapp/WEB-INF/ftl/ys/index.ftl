<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>查询ys网站数据</title>
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
		<@_top.top 6/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 100px;">
			<div class="row">
				<#--引入左侧菜单-->
				<@_left.ys 1/>
				<div class="col-md-10">
					<h2>原始上传数据</h2>
					<hr>
                    <label>页数</label>
			        <input type="text" name="page" id ="page" value="1">
			        <label>size</label>
			        <input type="text" name="size" id ="size" value="100">
			        <label>type</label>
			        <input type="text" name="type" id ="type" value="0">
			        <label>q</label>
			        <input type="text" name="q" id ="q" value="">	
			        <button  type="button" class="btn btn-primary" onClick="drawOriTable()" >查询ys网站初始数据</button>
				    <table class="table table-bordered" id="v31"> </table>   
					<hr>	
				</div>
			</div>
		</div>
	</body>

</script>	
<script type="text/javascript">
//用来作电器的表格，目的：easy
function drawOriTable(){
  var type = $('#type').val(),
    size = $('#size').val(),
    type = $('#type').val(),
    q = $('#q').val()
    // ,date1=$('#d11').val()+"用电量分析"
    ;
    layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#v31'
	    ,url:'http://www.innonation.io/inno_il/search'
	    ,method:"get"
	    ,where:{type:type,size:size,type:type,q:q}
	    ,cols: [[
	      {field:'C_TSegmentId', width:100, title: '时段号', sort: true}
	      ,{field:'C_TSegmentName', width:100, title: '时段',sort:true}
	      ,{field:'C_EEClassificationName', width:100, title: '电器名', sort: true}
	      ,{field:'C_EESequenceId', width:120, title: '内部编号',sort:true}
	      ,{field:'C_EEKWh', title: '总电量', width:100,sort:true}
	      ,{field:'C_EEOpenMinute', width:120, title: '开始分钟数', sort: true}
	      ,{field:'C_EECloseMinute', width:100, title: '终止分钟数',sort:true}
	      ,{field:'C_EEOpenCloseTimes', width:100, title: '启停数', sort: true}
	      ,{field:'C_EEPeakW', width:120, title: '峰值功率为',sort:true}
	      ,{field:'C_FaultId', title: '错误码', width:100,sort:true}
	      ,{field:'C_FrameCmdId', width:120, title: '命令字', sort: true}
	     
	    ]]
	    , done: function(res, curr, count){
		    //如果是异步请求数据方式，res即为你接口返回的信息。
		    //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
		    console.log(res);
		    
		    //得到当前页码
		    console.log(curr); 
		    
		    //得到数据总量
		    console.log(count);
		  }
	    ,page: true
	  });
	});
}
</script>
</html>