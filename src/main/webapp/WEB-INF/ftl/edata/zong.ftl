<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>v2-用电数据汇总</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}f/avicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/js/layui/css/layui.css" rel="stylesheet"/>

		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<#-- <script  src="${basePath}/js/common/layer/layer.js"></script> -->
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
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 100px; width:98%">
			<div class="row">
				<#--引入左侧菜单-->
				<@_left.edata 1/>
				<div class="col-md-10">
					<h2>总体能耗数据</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					      <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
                            <#--    -->
					        <label style="float:left;height:35px; line-height:35px; margin:0px 10px 0px 0px">终端</label>

					        <select name="cDistrictbcdid" id="cDistrictbcdid" onchange="getChannelId()" class="" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px">
					        <#if dlist?exists>
					        <#list dlist as x>

                                <option value="${x.cDistrictbcdid}-${x.cAddressid}">${x.cDistrictbcdid}-${x.cAddressid}-${x.cChannelnum}</option>
                            </#list>	
						    </#if>  
						     <#--  <option value="0540-85">0540-85-1</option>
						      <option value="0540-85">0540-85-1</option> -->
					        </select></div>
					        <div style="display: inline-block;height:32px;margin:0px 0px 10px 0px">
					        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">通道</label>
					        <select name="cChannelid" id="cChannelid" class="" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px">
					        </select></div>

					        <#-- <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">电器</label>
					        <select name="cEegrpid" id="cEegrpid" class="">
					        	<#if eglist?exists>
					            <#list eglist as x>
                                    
					                  <option value="${x.cEegrpid?default('2')}">${x.cEegrpname}</option>
					              
                                </#list>	
						        </#if> 	
					        </select> -->
					        <div style="display: inline-block;height:32px;margin:0px 0px 10px 0px">
					        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">日期</label>
					        <input id="d11" type="text" name="cRecorddatebcd" id="cRecorddatebcd" value="2017-12-29" onClick="WdatePicker()"/ style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px;text-indent: 5px;"></div>
							<div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
					        <button  type="button" class="btn btn-primary" onClick="listRecorddate()" style="float:left; height:30px; line-height:30px; padding:0px 10px; margin:0px 20px 0px 0px;">查询存在的日期段</button>
					        </div>
					        <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
					        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">存在的时间段</label>
					        <select name="ExistRecorddatebcd" id="ExistRecorddatebcd" class="" onchange="writeDate()" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px">
                               <option value=""></option>
					        </select>
					        </div>
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
                             
					        <div style="display: inline-block;height:32px;margin:0px 0px 10px 0px">
                             <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">前面点数</label>
							        <input type="text" name="startPoint" id="startPoint" value="200" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px;text-indent: 5px;">
</div>
<div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
							        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">后面点数</label>
							        <input type="text" name="endPoint" id ="endPoint" value="500" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px;text-indent: 5px;">
							        
							        </div>
                             
<div style="display: inline-block;height:32px;margin:0px 0px 10px 0px">
<label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">数据来源文件路径</label>
                                   <select name="rootPath" id="rootPath" class="" value="E:\录波数据\苏州冬季" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px">
        					        <#if filelist?exists>
        					        <#list filelist as x>
                                        <option value="${x}">${x}</option>
                                    </#list>	
        						    </#if>
        					        </select></div>
        					        <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
							        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px;text-indent: 5px;">分析数据保存路径</label>
							        <input type="text" name="pathSave" id ="pathSave" value="E:\录波数据\苏州冬季" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px">
							        </div>
							        <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px">
							        <label style="float:left;height:32px; line-height:32px; margin:0px 10px 0px 0px">版本号</label>
							        <input type="text" name="C_OffLineVersion" id ="C_OffLineVersion" value="2" style="float:left;height:30px; width:120px;border: 1px solid #ddd;

border-radius: 5px; margin:0px 20px 0px 0px;text-indent: 5px;">


									
							        </div>
							        
							        <div style="display: inline-block;height:32px;">
							        <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px"> <button  type="button" class="btn btn-primary" onClick="drawChart()" style="float:left; height:30px; line-height:30px; padding:0px 10px; margin:0px 0px 0px 0px;">查询总电量</button></div>
				         	 <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px"><button  type="button" class="btn btn-primary" onClick="drawBChart()" style="float:left; height:30px; line-height:30px; padding:0px 10px; margin:0px 0px 0px 0px;">查询分项饼图</button></div>
				         	 <div style="display: inline-block;height:32px; margin:0px 0px 10px 0px"><button  type="button" class="btn btn-primary" onClick="drawDTable()"  style="float:left; height:30px; line-height:30px; padding:0px 10px; margin:0px 0px 0px 0px;">查询原始数据</button></div>
				         	 </div>
					      </div>
					      <!--<div class='result'>
					      </div>-->
					     <span class=""> <#--pull-right -->
				         	
				         </span>
				         <#if olist?exists && olist?size gt 0 >	
				         <#list olist as x>
                                    ${x.cTkwh?string["00"]}
                         </#list>	
				         </#if>
				        </div>
				        <div class="row">
                              <div id="chart" style="width:1000px;height:400px;" ></div>
                              <div id="detailChart" style="width:1000px;height:400px;"></div>
				        </div>
				        <hr>
				        <div class="layui-row">
						    <div class="layui-col-md6" style="width:100%">
						      <div id="bchart" style="width:400px;height:400px;"></div>
						    </div>
						    <div class="layui-col-md6" style="width:100%">
						      <table class="layui-table" lay-size="sm" id="test">
                              </table>
						    </div>
						</div>
						<hr>
						

					</form>
				</div>
			</div><#--/row-->
		</div>
	</body>
	<table>
         <tr></tr>
	</table>
<script type="text/javascript">
var detailChart = echarts.init(document.getElementById('detailChart'));
function drawChart(){
				        var myChart = echarts.init(document.getElementById('chart'));
					    var cDistrictbcdid = $('#cDistrictbcdid').val(),
					           cChannelid = $('#cChannelid').val(),
					           cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
					           C_OffLineVersion = $('input[name="C_OffLineVersion"]').val(),
					           date1=$('#d11').val()+"用电量分析"
					           ;
     
					     myChart.showLoading(); 
					     // $.post('${basePath}/edata/getPower.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
					     // 	console.log(data);
					     // 	if(!data[0]){
					     // 	$("#datatable").html("峰值功率为"+(data[0].power)*1000+"W");
					     // };
					     // });
					     var timeseg=new Array(97);
					     var tzong=new Array(97);
					     var tbianshi=new Array(97);        
					   $.post('${basePath}/edata/getZongdata.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
					   	var a = data.length;
					   	if(a!=0)
					   	{
		                    for(var i=0, j=0;i<97;i++){
		                    	if(j<data.length)
		                    	{
                                 if(parseInt(data[j].C_TSegmentId)==i)
                                 {tzong[i]=data[j].tzong;  
                                 tbianshi[i]=data[j].tbianshi; 
                                  j++;  
                                }
                                else
                                {
                                 tzong[i]=0;  
                                 tbianshi[i]=0;
                                   
                                }
                               }	
		                       //挨个取出时间并填入时间数组
                                 timeseg[i]=$("#t"+i).html();
		                     }
		                     timeseg[0]="00:00";
		                     var dataArray =new Array(97);
		                     for (var i = 0; i < 97; i++) {
		                     	var item ={name:1,value:1};
		                     	item.value=timeseg[i];
                                 dataArray[i]=item;
		                     }
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
					            data:['总电量','辨识电量'],
					            x:'left'
					        },
					        xAxis: {
                                name:"时间",
					            data: dataArray
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
					                },
								    {
								        name: '总电量',
								        type: 'line',
								        smooth: true,
								        data: tzong
								    }]           

					    }; 
		                    myChart.setOption(options);//作出图
		                    myChart.on('click', function (params) {
		                    	 //dis,add,record,chan,shiduan
		                    	 //【1】写一个方法
		                        console.log(params);
		                    	drawDetailChart(params);
							});                      //添加点击事件
					   	}
					   	else
					   	{
					   		myChart.hideLoading(); 
					   		alert("当天无数据");
					   	}
				});
			};
  function drawDetailChart(data) {
  // 	detailChart.clear();
  // 	detailChart = echarts.init(document.getElementById('detailChart'));
 	// detailChart.showLoading();
 	// var disAddress= $('#cDistrictbcdid').val()+"";
 	detailChart.showLoading(); 
 	var cDistrictbcdid =$('#cDistrictbcdid').val().substring(0,4),
 		cChannelid = $('#cChannelid').val(),
 		cAddressid =$('#cDistrictbcdid').val().substring(5),
 		startPoint = $("#startPoint").val(),
        endPoint = $("#endPoint").val(),
        rootPath = $("#rootPath").val(),
        pathSave = $("#pathSave").val(),
        jump=data.dataIndex*9000;
 		// cAddressid= disAddress.substring(5,8),
                           
 		var cRecorddatebcd = $('input[name="cRecorddatebcd"]').val();
 		console.log(cRecorddatebcd);
 	    console.log(data.name);
 		console.log("string ok");
 	date1 =data.name+ "用电量分析";
 	console.log("before");
 	$.post('getV52.shtml',  {
 				cDistrictbcdid: cDistrictbcdid,
 				cChannelid: cChannelid,
 				cAddressid: cAddressid,
 				cRecorddatebcd: cRecorddatebcd,
 				jump: jump,//怎么改
 				cParaid: 0,
 				startPoint: startPoint,
 				endPoint: endPoint,
 				rootPath: rootPath,
 				pathSave: pathSave
 			}, function(data) {
 				 console.log("ok");

 			if (data != false) {

 				

 					detailChart.hideLoading(); //隐藏加载动画
 					var options = {
 						title: {
 							text: date1,
 							x: 'center'
 						},
 						tooltip: {
 							trigger: 'axis'
 						},
 						legend: {
 							data: ['有功功率', '无功功率', '二次谐波', '三次谐波'],
 							x: 'left'
 						},
 						xAxis: {
 							name: "时间",
 							data: data.se
 						},
 						yAxis: {
 							splitLine: {
 								show: false
 							},
 							name: "功率/W"

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
 						//可能用的到的线条的功能
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
 						series: [{
 							name: "有功功率",
 							type: 'line',
 							smooth: true,
 							data: data.power
 						}, {
 							name: "无功功率",
 							type: 'line',
 							smooth: true,
 							data: data.wugong
 						}, {
 							name: "二次谐波",
 							type: 'line',
 							smooth: true,
 							data: data.erci
 						}, {
 							name: "三次谐波",
 							type: 'line',
 							smooth: true,
 							data: data.sanci
 						}]

 					};
 					// echartsInstance.clear();
 					detailChart.clear();
 					detailChart.setOption(options);
 				    detailChart.hideLoading(); 

 				}
 			else {
 				detailChart.hideLoading();
 				alert("当天无数据");
 			}
 			console.log("success");
 	});
   console.log("after");
}

 

</script>
<script type="text/javascript">
function drawBChart(){
				        var myChart = echarts.init(document.getElementById('bchart'));
					    var cDistrictbcdid = $('#cDistrictbcdid').val(),
					           cChannelid = $('#cChannelid').val(),
					           cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
					           date1=$('#d11').val()+"用电量分析",
					            C_OffLineVersion = $('input[name="C_OffLineVersion"]').val()
					           ;
     
					     myChart.showLoading(); 
					     var tfen=[];
					     var C_EEGrpName=[];
					   $.post('${basePath}/edata/getFendata.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
					   	var a = data.length;
					   	if(a!=0)
					   	{
		                    for(var i=0;i<data.length;i++){
                             var tfen2=data[i].tfen;
                             var C_EEGrpName2=data[i].C_EEGrpName;
                             C_EEGrpName.push(C_EEGrpName2); 
                             var map =new Object();
                             map.value=tfen2;
                             map.name=C_EEGrpName2;
                             tfen[i]=map;
                             console.log(map);
                         }
		                    console.log(tfen);
		                    console.log(C_EEGrpName); 		                
		                    myChart.hideLoading();    //隐藏加载动画
                           	var option = {
                           		 title: {
					            text: date1,
					            x:'center'
					        },
						    tooltip: {
						        trigger: 'item',
						        formatter: "{a} <br/><span id='fen'>{b}</span>: {c} 度({d}%)"
						    },
						    legend: {
						        orient: 'vertical',
						        x: 'left',
						        data:C_EEGrpName
						    },
						    series: [
						        {
						            name:'用电量分析',
						            type:'pie',
						            radius: ['50%', '70%'],
						            avoidLabelOverlap: false,
						            label: {
						                normal: {
						                    show: false,
						                    position: 'center'
						                },
						                emphasis: {
						                    show: true,
						                    textStyle: {
						                        fontSize: '30',
						                        fontWeight: 'bold'
						                    }
						                }
						            },
						            labelLine: {
						                normal: {
						                    show: false
						                }
						            },
						            data:tfen
						        }
						    ]
						};

		                    myChart.setOption(option);
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
function drawDTable(){
  var cDistrictbcdid = $('#cDistrictbcdid').val(),
    cChannelid = $('#cChannelid').val(),
    cRecorddatebcd = $('input[name="cRecorddatebcd"]').val(),
    C_OffLineVersion = $('input[name="C_OffLineVersion"]').val(),
    date1=$('#d11').val()+"用电量分析";
    layui.use('table', function(){
	  var table = layui.table;
	  table.render({
	    elem: '#test'
	    ,url:'${basePath}/edata/getGriddata.shtml'
	    ,method:"post"
	    ,where:{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion}
	    ,cols: [[
	      {field:'cDistrictbcdid', width:100, title: '区域号', sort: true}
	      ,{field:'cAddressid', width:100, title: '终端号',sort:true}
	      ,{field:'cChannelid', width:100, title: '通道号', sort: true}
	      ,{field:'cRecorddatebcd', width:120, title: '日期',sort:true}
	      ,{field:'ts', title: '时段号', width:100,sort:true}
	      ,{field:'tzong', width:120, title: '总电量', sort: true}
	      ,{field:'tbianshi', width:120, title: '辨识总电量', sort: true}
	      ,{field:'ratio', width:100, title: '比率',sort:true}
	      ,{field:'C_OffLineVersion', width:100, title: '版本号',sort:true}
	    ]]
	    ,page: true
	  });
	});
}
function getChannelId(){
	var 
        options=$("#cDistrictbcdid option:selected"),    
        selectItem = $("#cDistrictbcdid").text(),
	    dlist =  $("#dlist").val(),
	     // dlist='<%=request.getAttribute("dlist")%>',
        ChannelidItem=$("#cChannelid");
    //0.处理得到的数据
    var  channelnum=options.text();
    channelnum=channelnum.split('-')[2];//获取通道号数据
    //1.清空选项
     ChannelidItem.html("");  
    //2.输入参数添加数据 append(id);
    for (var i = 1; i <= channelnum; i++) {
    	ChannelidItem.append('<option value="'+i+'">'+i+'</option>')
    }
}
function listRecorddate(){
	console.log("ok");
	var cDistrictbcdid = $('#cDistrictbcdid').val(),
	    cChannelid=$("#cChannelid").val();
    ExistRecorddatebcd=$("#ExistRecorddatebcd");
    $.post('${basePath}/edata/listRecorddate.shtml', {cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid}, function(data, textStatus, xhr) {
    	console.log(data);
    	ExistRecorddatebcd.html("");
    	for (var i = 0; i < data.length; i++) {
    		  var record=data[i];
    		  console.log(record.C_RecordDateBCD);
    	ExistRecorddatebcd.append('<option value="'+record.C_RecordDateBCD+'">'+record.C_RecordDateBCD+'</option>');
    	};
    	//保证只有一个数据时，不执行onchangge事件时，会载入一个默认值到时间框
    	var 
        options=$("#ExistRecorddatebcd option:selected"),    
	     // dlist='<%=request.getAttribute("dlist")%>',
        d11=$("#d11");
	    var oriDate= options.text();
	    if(oriDate){
	    var endDate="20"+oriDate.substring(0,2)+"-"+oriDate.substring(2,4)+"-"+oriDate.substring(4,6);  
	    console.log(endDate); 
	    $("#d11").val(endDate);}
    });

}	
function writeDate(){
	var 
        options=$("#ExistRecorddatebcd option:selected"),    
	     // dlist='<%=request.getAttribute("dlist")%>',
        d11=$("#d11");
    var oriDate= options.text();
    var endDate="20"+oriDate.substring(0,2)+"-"+oriDate.substring(2,4)+"-"+oriDate.substring(4,6);  
    console.log(endDate); 
    $("#d11").val(endDate);    
}
</script>
<script type="text/	">
    $(function(){
        var div_b=$('#bchart div:last-child');
        console.log(div_b);
        $('#bchart').on("click", function(){
        	console.log($('#fen').html());
        	$()
		});
    })
	
</script>
</html>