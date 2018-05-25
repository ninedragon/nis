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
        <link   rel="icon" href="<%=basePath%>f/avicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css?" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css?" rel="stylesheet"/>
		<link href="<%=basePath%>/js/layui/css/layui.css" rel="stylesheet"/>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/woodare/css/comm.css" />
		
		
		<script  src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
		<script src="<%=basePath%>/woodare/js/menu.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script language="javascript" type="text/javascript" src="<%=basePath%>/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src='<%=basePath%>/js/echarts.js'></script>
		<script type="text/javascript">
             $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
        </script> 
        <script type="text/javascript" src='<%=basePath%>/js/layui/layui.js'></script>
        
		<script type="text/javascript">
		$(function() {
			
			//搜索查询
			$(".wapp-main .search span.sec-js").click(function(){
				$(".more-js").show();
			});
		})
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
	<h4>总体能耗数据</h4>	
	<form method="post" action="" id="formId" class="form-inline">
    <!--搜索开始-->
	<div class="search">
    	<div style="float:left; width:100%">
            <lable>
                <span class="wd01">终端</span>
                <select  name="cDistrictbcdid" id="cDistrictbcdid" onchange="getChannelId()">
                    <option value="0001-0">0001-0-1</option>
                    <c:if test="${!empty dlist }">
                    	<c:forEach items="${dlist }" var="x">
                    		 <option value="${x.cDistrictbcdid}-${x.cAddressid}">${x.cDistrictbcdid}-${x.cAddressid}-${x.cChannelnum}</option>
                    	</c:forEach>
                    </c:if>
                </select>
            </lable>
            <lable>
                <span class="wd01">通道</span>
                <select name="cChannelid" id="cChannelid">
                </select>
            </lable>
            <lable>
                <span class="wd01">日期</span>
                   <input id="d11" type="text" name="cRecorddatebcd" value="2018-02-05" onClick="WdatePicker()"/>
            </lable>
            <div class="but-nav">
                <span class="but sec-js"  onClick="listRecorddate()">查询存在的时段</span>
            </div>
        </div>
        <div class="more-js" style="float:left; width:100%; display:none;">
        	
            <lable>
                <span class="wd01">存在的时段</span>
                <select name="ExistRecorddatebcd" id="ExistRecorddatebcd" class="" onchange="writeDate()">
                    <option>请选择</option>
                </select>
            </lable>
              <c:if test="${!empty timeList }">
                 	<c:forEach items="${timeList }" var="x">
                 		<div id ="t${x.count}" hidden="true">${x.dateHm}</div>
                 	</c:forEach>
                 </c:if>
            <lable>
                <span class="wd01">前面的点数</span>
                <input  name="startPoint" id="startPoint" value="200"   type="text" >
            </lable>
            <lable>
                <span class="wd01">后面的点数</span>
                <input  type="text"  name="endPoint" id ="endPoint" value="500" >
            </lable>
            <lable>
                <span class="wd01">数据来源文件路径</span>
                <select name="rootPath" id="rootPath" class="" value="E:\录波数据\苏州冬季">
                     <c:if test="${!empty filelist }">
                    	<c:forEach items="${filelist }" var="x">
                    		   <option value="${x}">${x}</option>
                    	</c:forEach>
                    </c:if>
                </select>
            </lable>
            <lable>
                <span class="wd01">分析数据保存路径</span>
                <input type="text"  name="pathSave" id ="pathSave" value="E:\录波数据\苏州冬季">
            </lable>
            <lable>
                <span class="wd01">版本号</span>
                <input type="text" name="C_OffLineVersion" id ="C_OffLineVersion" value="2">
            </lable>
            <div class="but-nav">
                <span class="but"  onClick="drawBChart()">查询分项饼图</span>
                <span class="but"  onClick="drawDTable()"  >查询原始数据</span>
                <span class="but"  onClick="drawChart()">查询总电量</span>
            </div>
        </div>
	</div>
	         <c:if test="${!empty olist }">
              	<c:forEach items="${olist }" var="x">
              		  ${(empty x.cTkwh)? '00' : x.cTkwh}
              	</c:forEach>
              </c:if>
    <!--搜索结束/-->
    <!--调用外部图表开始-->
     <div class="row">
           <div id="chart" style="width:1000px;height:400px;" ></div>
           <div id="detailChart" style="width:1000px;height:400px;"></div>
    </div>
          <hr>
     <div class="layui-row">
	    <div class="layui-col-md6">
	      <div id="bchart" style="width:400px;height:400px;"></div>
	    </div>
	    <div class="layui-col-md6 table-box">
	      <table class="layui-table" lay-size="sm" id="test">
	                        </table>
	    </div>
	</div>
		<hr>
<!--     <div class="all-img"><img src="image/img01.png"></div> -->
<!--     <div class="all-img"><img src="image/img02.png"></div> -->
    <!--调用外部图表结束/-->
    </form>
<!--     表格开始 -->
<!--     <div class="table-box"> -->
<!--         <table width="100%"> -->
<!--             <tr> -->
<!--                 <th>区域号</th> -->
<!--                 <th>终端号</th> -->
<!--                 <th>通道号</th> -->
<!--                 <th>日期</th> -->
<!--                 <th>时段号</th> -->
<!--                 <th>总电量</th> -->
<!--                 <th>辨识总电量</th> -->
<!--                 <th>比率</th> -->
<!--                 <th>版本号</th> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td align="center">888</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">180205</td> -->
<!--                 <td align="center">70</td> -->
<!--                 <td align="center">0.000011</td> -->
<!--                 <td align="center">0.0000</td> -->
<!--                 <td align="center">0.0000%</td> -->
<!--                 <td align="center">2</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td align="center">888</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">180205</td> -->
<!--                 <td align="center">70</td> -->
<!--                 <td align="center">0.000011</td> -->
<!--                 <td align="center">0.0000</td> -->
<!--                 <td align="center">0.0000%</td> -->
<!--                 <td align="center">2</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td align="center">888</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">180205</td> -->
<!--                 <td align="center">70</td> -->
<!--                 <td align="center">0.000011</td> -->
<!--                 <td align="center">0.0000</td> -->
<!--                 <td align="center">0.0000%</td> -->
<!--                 <td align="center">2</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td align="center">888</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">180205</td> -->
<!--                 <td align="center">70</td> -->
<!--                 <td align="center">0.000011</td> -->
<!--                 <td align="center">0.0000</td> -->
<!--                 <td align="center">0.0000%</td> -->
<!--                 <td align="center">2</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td align="center">888</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">1</td> -->
<!--                 <td align="center">180205</td> -->
<!--                 <td align="center">70</td> -->
<!--                 <td align="center">0.000011</td> -->
<!--                 <td align="center">0.0000</td> -->
<!--                 <td align="center">0.0000%</td> -->
<!--                 <td align="center">2</td> -->
<!--             </tr> -->
<!--         </table> -->
<!--     </div> -->
<!-- 	<!--表格结束/--> -->
    
<!--     分页开始 -->
<!--     <div class="paging"> -->
<!-- 		<div class="input-box"><span>第</span><div class="input"><input name="" type="text"></div><span>页</span><span class="gob"><a href="javascript:void(0);"></a></span><span>1</span>/15</div> -->
<!-- 		<div class="box"> -->
<!-- 			<a href="javascript:void(0);" class="ps">首页</a> -->
<!-- 			<a href="javascript:void(0);" class="pl"></a> -->
<!-- 			<a href="javascript:void(0);" class="on">1</a> -->
<!-- 			<a href="javascript:void(0);" class="pr"></a> -->
<!-- 			<a href="javascript:void(0);" class="ps">尾页</a> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!--     分页结束/ -->
</div>
<!--主体结束/-->
</body>

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
					     // $.post('<%=basePath%>/edata/getPower.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cEegrpid:cEegrpid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
					     // 	console.log(data);
					     // 	if(!data[0]){
					     // 	$("#datatable").html("峰值功率为"+(data[0].power)*1000+"W");
					     // };
					     // });
					     var timeseg=new Array(97);
					     var tzong=new Array(97);
					     var tbianshi=new Array(97);        
					   $.post('<%=basePath%>/edata/getZongdata.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
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
					   $.post('<%=basePath%>/edata/getFendata.shtml',{cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid,cRecorddatebcd:cRecorddatebcd,C_OffLineVersion:C_OffLineVersion},function(data){
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
	    ,url:'<%=basePath%>/edata/getGriddata.shtml'
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
    $.post('<%=basePath%>/edata/listRecorddate.shtml', {cDistrictbcdid:cDistrictbcdid,cChannelid:cChannelid}, function(data, textStatus, xhr) {
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

