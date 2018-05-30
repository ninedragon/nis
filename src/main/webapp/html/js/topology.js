
d3.namespace("xmlns:cge","http://iec.ch/TC57/2005/SVG-schema#");

var lbss = [];
var svgSnap = d3.select("body").append("svg");
var svg_width = 10000;
svgSnap.attr("width", svg_width - 25)
   .attr("height", 3960)
   .attr("xmlns", "http://www.w3.org/2000/svg")
   .attr("xmlns:xlink", "http://www.w3.org/1999/xlink")
   .attr("xmlns:cge", "http://iec.ch/TC57/2005/SVG-schema#");

var grid = 64;
var currentSnapX = grid * 1;
var currentSnapY = grid * 1;

function createTextEl(layer, data, position) {
	position.rotate =position.rotate || 0;
	var g = layer.append("g").attr("id", data.id);
	var x = position.x;
	var y = position.y;
	var size = position.size || 14;
	var txtCls = position.txt || "fText";
	var anchor = position.anchor || "end";
	var tspan = data.tspan || false;
	if(tspan){
		var txt = g.append('text').attr("text-anchor", anchor).attr("font-size", size).attr("stroke", "rgb(255,0,0)").attr("fill","rgb(255,0,0)").html(data.title).attr("class", txtCls).attr("transform","scale(" + position.scale + ") translate(0 0) rotate(" + position.rotate + " " + x + " " + y + ")");
	}else{
		var txt = g.append('text').attr("text-anchor", anchor).attr("font-size", size).attr("stroke", "rgb(255,0,0)").attr("fill","rgb(255,0,0)").attr("x", x).attr("y", y).text(data.title).attr("class", txtCls).attr("transform","scale(" + position.scale + ") translate(0 0) rotate(" + position.rotate + " " + x + " " + y + ")");
	}
	
}
function createUseEl(layer, data, position) {
	position.rotate= position.rotate||0;
	data.id = data.id || "";
	var g = layer.append("g").attr("id", data.id);
	var symbol = getSymbolByType(data.type)
	var x = position.x;
	var y = position.y;
	var transX = 0;
	var transY = 0;
	var rotate = position.rotate
	var rotateX = x + grid / 2;
	var rotateY = y + grid / 2;
	var useage = g.append('use').attr("width", grid).attr("height", grid).attr("transform","scale(" + position.scale + ") translate(" + transX + " " + transY + ") rotate(" + position.rotate + " " + rotateX + " " + rotateY + ")").attr("xlink:href", "#" + symbol.id ).attr("x", x).attr("y", y).attr("class", data.cls);
	if (lbss && data.type == 'Disconnector') {
		var connect = g.append('use').attr("width", grid).attr("height", grid).attr("transform","scale(" + position.scale + ") translate(" + transX + " " + transY + ") rotate(" + position.rotate + " " + rotateX + " " + rotateY + ")").attr("xlink:href", "#Disconnector_PD_刀闸@1").attr("x", x).attr("y", y).attr("class", "hide");
		lbss.push([useage, connect ]);
	}
}

function createLineEl(layer, data, position) {
	data.id = data.id || "";
	var g = layer.append("g").attr("id", data.id);
	var x = position.x * position.scale;
	var y = position.y * position.scale;
	var x2 = position.x2 * position.scale;
	var y2 = position.y2 * position.scale;
	var path = g.append('path').attr("stroke-width", 2).attr("stroke", "rgb(0,0,0)").attr("fill","none").attr("d", "M " + x + "," + y + " L " + x2 + "," + y2 + "");
	
	if (data.dash) {
		path.attr("stroke-dasharray", "5 5").attr("stroke-width", 1);
	}
}

function getSymbolByType(type) {
	var data = {
		id: "",
		x: "",
		y: ""
	};
	var id = "";
	switch(type) {
	case 'Substation':
		data = {
			id: "Substation_PD_变电站",
			x: 8,
			y: 12,
			txt: 'bkkV110',
			size:28,
			r: [0, 0]
		};
		break;
	case 'Breaker':
		data = {
			id: "Breaker_PD_变电站出线开关@1",
			x: 8,
			y: 8,
			r: [0, 90]
		};
		break;
	case 'Terminal':
		data = {
			id: "Pole_PD_直线砼杆0000",
			x: 32,
			y: 32,
			r: [0, 0]
		};
		break;
		
	case 'NZQG':
		data = {
			id: "Pole_PD_耐张砼杆",//连接点圈
			x: 26,
			y: 26,
			r: [0, 0]
		};
		break;
		
	case 'PowerTransformer':
		data = {
			id: "Transformer_PD_综合变压器",
			x: 12,
			y: 12,
			r: [0, 90]
		};
		break;
	case 'EnergyConsumer':
		data = {
			id: "EnergyConsumer_PD_单电源用户",//箱变
			x: 8,
			y: 8,
			r: [0, 90]
		};
		break;
	case 'LoadBreakSwitch':
		data = {
			id: "Breaker_PD_断路器@0",
			x: 22,
			y: 22,
			r: [0, 90]
		};
		break;
	case 'LoadBreakSwitchRed'://红色
		data = {
			id: "Breaker_PD_断路器@1",
			x: 22,
			y: 22,
			r: [0, 90]
		};
		break;
	case 'LoadBreakSwitchBlue'://蓝色
		data = {
			id: "Breaker_PD_断路器@2",
			x: 22,
			y: 22,
			r: [0, 90]
		};
		break;
	case 'TableBox':
		data = {
			id: "TableBox_PD_表箱",
			x: 8,
			y: 12,
			txt: 'bkkV110',
			size:28,
			r: [0, 0]
		};
		break;
	case 'tableList':
		data = {
			id: "TableBox_PD_列表",
			x: 12,
			y: 12,
			r: [0, 90]
		};
		break;
	case 'tableList1':
		data = {
			id: "TableBox_PD_列表01",
			x: 12,
			y: 12,
			r: [0, 90]
		};
		break;
	default:
		break;
	}
	return data;
}
/**
 * 获取项目根
 * **/
function getRootPath_web() {
	 //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	 var curWwwPath = window.document.location.href;
	 //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	 var pathName = window.document.location.pathname;
	 var pos = curWwwPath.indexOf(pathName);
	 //获取主机地址，如： http://localhost:8083
	 var localhostPaht = curWwwPath.substring(0, pos);
	 //获取带"/"的项目名，如：/uimcardprj
	 var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	 return (localhostPaht + projectName);
}  

/**
 * 展示拓扑
 * **/
function showTop(rowId){
	var layerSnap = svgSnap.html("g").attr("id","topology_Layer");
//	 eupType ： 
//	 M0001 箱变
//	 M0002 出线柜
//	 M0003 分支箱
//	 M0004 表箱
	if(null != rowId && "" != rowId){
		 $.ajax({
	         type: "post",
	         url:  getRootPath_web()+"/epu/getEupInfosTree.shtml",
	         data: {
	        	 rootId: rowId
	         },
	         async:false,
	         dataType: "json",
	         cache: false,
	         error: function (a,b,c) {
	         },
	         success: function (data) {
	        	 if(data){
	        		 if(null != data && data.length > 0){
	        			 var rootList = getRootData("M0001",rowId,data);//箱变
	        			 if(null != rootList && rootList.length > 0){
	        				var gird = 100;
        				 	var ammeterX = 200;//表箱X绝对位置
        	     		    var ammeterY = 1000;//表箱Y绝对位置
        	     			var branchBoxX = ammeterX;//分支箱开关X绝对位置
         	        		var branchBoxY = ammeterY;//分支箱开关Y绝对位置   
        	     		         
         	        		var cabinetsX = branchBoxX;//出线柜开关X绝对位置
         	        		var cabinetsY = branchBoxY;//出现柜开关Y绝对位置
         	        		var cabinetsDifference = 200;//分支箱开关合并组与出线柜开关高度y值
         	        		
           	        		var rootSwitchX = cabinetsX;//箱变开关X绝对位置
         	        		var rootSwitchY = cabinetsY;//箱变开关Y绝对位置
         	        		var rootSwitchDifference = 200;//出线柜开关合并组与箱变开关高度y值
         	        		
         	        		var branchBoxDifference = 100;//分支箱开关与表箱高度y差值
         	        		
         	        		var rootX = rootSwitchX;//箱变X绝对位置
         	        		var rootY = rootSwitchY;//箱变Y绝对位置
         	        		var rootDifference = 200;//出线柜合并组与箱变高度y值
         	        		
         	        		
    						var cabinetsCount = 0;//统计箱变合并的出线柜的组中位数
	    					var tempRootX = 0;//获取到箱变合并的出线柜的下宽度
	          		        var tempRootY = 0;//获取到箱变合并的出线柜的下高
	          		        var tempRootLineX = 0;//获取到箱变合并的出线柜的上宽度
	          		        var tempRootLineY = 0;//获取到箱变合并的出线柜的上高
	          		        
	        				 //箱变循环- begin
	        				 for(var i= 0; i < rootList.length; i++){
        						var i_json = rootList[i];
	 	    					var i_epuParentId = i_json["rowId"];
	 	    					var cabinetsList  = new Array();//出线柜
	 	    					getNextData("M0002",i_epuParentId,data,cabinetsList);
	 	    					//出线柜循环 -begin
	 	    					if(null != cabinetsList && cabinetsList.length > 0){
	 	    						cabinetsCount = cabinetsList.length - 1 / 2;
	 	    						var branchBoxCount = 0;//统计出线柜开关的组中位数
 	    	    					var tempCabinetsX = 0;//获取到出线柜开关的下宽度
 	    	          		        var tempCabinetsY = 0;//获取到出线柜开关的下高
 	    	          		        var tempCabinetsLineX = 0;//获取到出线柜开关的上宽度
 	    	          		        var tempCabinetsLineY = 0;//获取到出线柜开关的上高
	 	    						
	 	    						var mergeRootXAll = null;//箱变下出线柜X合并
	 	    						
	 	    						for(var j= 0; j < cabinetsList.length; j++){
	 	    							var j_json = cabinetsList[j];
	 	    	    					var j_epuParentId = j_json["rowId"];
	 	    							var branchBoxList  = new Array();//分支箱
	 	    	    					getNextData("M0003",j_epuParentId,data,branchBoxList);
	 	    	          		        //分支箱循环-begin
	 	    	    					if(null != branchBoxList && branchBoxList.length > 0){
	 	    	    						branchBoxCount = branchBoxList.length - 1 / 2;
	 	    	    						
	 	    	    						var tableBoxCount = 0;//统计分线箱开关的组中位数
		 	    	    					var tempBranchBoxX = 0;//获取到分线箱开关的下宽度
		 	    	          		        var tempBranchBoxY = 0;//获取到分线箱开关的下高
		 	    	          		        var tempBranchBoxLineX = 0;//获取到分线箱开关的上宽度
		 	    	          		        var tempBranchBoxLineY = 0;//获取到分线箱开关的上高
		 	    	          		        
		 	    	          		        var groupBranchBoxXNum = 50;//每组分支箱开关的X间距
		 	    	          		        
		 	    	          		        var mergeBranchBoxXAll = null;//出线柜每组开关X合并
	 	    	    						for(var z = 0; z < branchBoxList.length; z++){
	 	    	    	    					var z_json = branchBoxList[z];
	 	    	    	    					var z_epuParentId = z_json["rowId"];
	 	    	    	    					 var z_epuStatus = z_json["epuStatus"];
	 	    	    	    					 var tableBoxList  = new Array();//表箱
	 	    	    	    					ammeterX = ammeterX + groupBranchBoxXNum;//每组分支箱开关X间距些距离(包含表箱也是)
	 	    	    	    					getNextData("M0004",z_epuParentId,data,tableBoxList);
	 	    	    	    					var mergeTableBoxXAll = null; //分支箱每组开关X合并
	 	    	    	    					//表箱循环-begin
//	 	    	    	    					alert(branchBoxList.length+"=="+tableBoxList.length+"==="+z_epuParentId+"==="+rowId)
	 	    	    	    					if(null != tableBoxList && tableBoxList.length > 0){//有表箱集合的
	 	    	    	    						tableBoxCount = tableBoxList.length - 1 / 2;
	 		    	    	    					for(var x= 0; x < tableBoxList.length; x ++){
	 		    	    	    						var x_json = tableBoxList[x];
	 		    	    	    						var x_rowId = x_json["rowId"];
	 		    	    	    						//展示表箱
	 		    		        			 			ammeterX = ammeterX + gird ;
//	 		    		        			 			var txtKey = (z_epuParentId +"_" + x_rowId);
//	 		    		 	    						setCreateUseEl(layerSnap,"ammeterId" + txtKey, "TableBox",ammeterX,ammeterY);
	 		    		 	    						var txtKey = (z_epuParentId +"_" + x_rowId);
	 		    		 	    						setCreateUseEl(layerSnap,"ammeterId" + txtKey, "TableBox",ammeterX,ammeterY);
		 		    		    		        		 splitRemarks(layerSnap,"idTitle" + txtKey,"表箱",ammeterX + 50,ammeterY + 37,"fText",16);//表箱标题
		 		    		    		        		 var x_epuName = x_json["epuName"] ||"";
		 		    		    		        		 var textNewlineArr =  textNewline(x_epuName,6,ammeterX + 60,ammeterY + 55,20);
		 		    		    		        		 splitRemarks(layerSnap,"idTxt" + txtKey,textNewlineArr[0],0 ,0,"fText",12,true);
		 		    		    		        		//给表箱绑定单击事件
		 		    		    		        		$("#idTitle" + txtKey + ",#idTxt" + txtKey+",#ammeterId" + txtKey).attr("epuName",x_json["epuName"]);
		 		    		    		        		$("#idTitle" + txtKey + ",#idTxt" + txtKey+",#ammeterId" + txtKey).bind("click",function(){
		 		    	    	    							  var txtID = $(this).attr("id");//展示的文字ID
		 		    	    	    							  txtID = txtID.replace("idTxt","");
		 		    	    	    							  txtID = txtID.split("_")[1];//获取表箱ID
		 		    	    	    							  parent.$("#tableBoxId").val(txtID.replace("idTxt",""));//当前表箱ID
		 		    	    	    							  var textValue = $(this).attr("epuName");//展示的文字内容
		 		    	    	    							  parent.$("#tableBoxName").text(textValue + "单线图");//TAB
		 		    	    	    							  
		 		    	    	    							  var rowId = parent.$("#rowId").val();//获取箱变根ID
		 		    	    	    				              var iframeID  = parent.$("#tab3Iframe")[0];//获取iframe的ID
		 		    	    	    				              var tableBoxId = parent.$("#tableBoxId").val();//获取箱变根ID
		 		    	    	    				              //只有电表TAB可以执行此动作
			    	    	    				            	  iframeID.contentWindow.showTop(rowId,tableBoxId);
			    	    	    				            	  parent.$("#messageAmmeter").show();
		 		    	    	    					});
	 		    	    	    						//表箱分割备注
	 		    	    		    		        	splitRemarks(layerSnap,"tableBoxID","表箱",45,(ammeterY + 40),"fText",20);
	 		    	    		    		        	//虚线
	 		    	    		    		        	createLineEl(layerSnap, {
		 						    		        			id :"idLine" + j_epuParentId,
		 						    		        			dash:"true"
		 						    		        		}, {
		 						    		        			x: svg_width,//下宽度
		 						    		        			y: ammeterY + 200,//下高
		 						    		        			x2: 0,//上宽度
		 						    		        			y2: ammeterY + 200,//上高
		 						    		        			scale: 1
		 						    		        	});
	 		    		 	    						 //引入表箱与分支箱开关线(一对一)
	 		    		    		        			 createLineEl(layerSnap, {
	 		    				    		        			id :"idLine" + x_rowId,
	 		    				    		        			type: "TableBox"
	 		    				    		        		}, {
	 		    				    		        			x: ammeterX + 33,//下宽度
	 		    				    		        			y: ammeterY + 13,//下高
	 		    				    		        			x2: ammeterX + 32,//上宽度
	 		    				    		        			y2: ammeterY - 58,//上高
	 		    				    		        			scale: 1
	 		    				    		        		});
//	 		    		    		        			 //展示一个分支箱一个开关图形（正常）
	 		    		 	    						 branchBoxX = ammeterX;
	 		    		 	    		        		 branchBoxY = ammeterY- branchBoxDifference;
	 		    		 	    		        		 setCreateUseEl(layerSnap,"branchBoxid" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	 		    		 	    		        		  //分支箱分割备注
	 		    		 	    		        		 splitRemarks(layerSnap,"branchBoxID","分支箱",65,(branchBoxY + 40),"fText",20);
	 		    		 	    		        		 createLineEl(layerSnap, {
		 						    		        			id :"idLine" + z_epuParentId,
		 						    		        			dash:"true"
		 						    		        		}, {
		 						    		        			x: svg_width,//下宽度
		 						    		        			y: branchBoxY +70,//下高
		 						    		        			x2: 0,//上宽度
		 						    		        			y2: branchBoxY+70,//上高
		 						    		        			scale: 1
		 						    		        		});
	 		    		 	    		        		 //将一个分支箱下的所有开关合并
	 		    		 		    		        	var branchBoxLineX = branchBoxX + 32;//下宽度
	 		    		 		    		        	var branchBoxLineY = branchBoxY + 22;//下高
	 		    		 		    		        	var branchBoxLineX2 = branchBoxX + 32;//上宽度
	 		    		 		    		        	var branchBoxLineY2 = branchBoxY - 50;//上高
	 		    		 		    		        	 if (!mergeTableBoxXAll) {
	 		    		 		    		       			 mergeTableBoxXAll = branchBoxLineX + (tableBoxList.length -1) * gird / 2;
	 		    		     		        			 }
	 		    		     		        			 pos={
	 		    		  		    		        			x: mergeTableBoxXAll,//下宽度
	 		    		  		    		        			y: branchBoxLineY2,//下高
	 		    		  		    		        			x2: branchBoxLineX,//上宽度
	 		    		  		    		        			y2: branchBoxLineY,//上高
	 		    		  		    		        			scale: 1
	 		    		  		    		        		};
	 		    		     		        			 setPos(layerSnap,pos);
	 		    		     		        			if(tableBoxCount >x && tableBoxCount < ( x + 1)){
		 		    		   		        				  tempBranchBoxX = mergeTableBoxXAll;//下宽度
		 		    		   		          		          tempBranchBoxY = branchBoxLineY;//下高
		 		    		   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
		 		    		   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
		 		    		     		        		}
	 		    		     		        			
	 		    	    	    					}
	 	    	    	    					}
	 	    	    	    					mergeTableBoxXAll = null;
	 	    	    	    					//表箱循环-end
	 	    	    	    					cabinetsY = branchBoxY - cabinetsDifference;//一个出线柜开关Y轴坐标(相对分支箱往上位置 = 分支箱开关Y绝对位置  - 分支箱开关合并组与出线柜开关高度y值)
	 	    	    	    					//一组分支箱的中间X向上画线
					    	    		        var lowerBranchBoxX = tempBranchBoxX;//下宽度
			    	 	    		        	var lowerBranchBoxY = tempBranchBoxLineY;//下高
			    	 	    		        	var lowerBranchBoxX1 = tempBranchBoxX;//上宽度 (分线箱上处宽度)
			    	 	    		        	var lowerBranchBoxY1 = cabinetsY + 100;//上高 (分线箱上处高度)
			    	 	    		            createLineEl(layerSnap, {
							    		        	id :"idLines" + z_epuParentId,
							    		        	type: "TableBox"
							    		        }, {
							    		        	x: lowerBranchBoxX,//下宽度
							    		        	y: lowerBranchBoxY,//下高
							    		        	x2: lowerBranchBoxX1,//上宽度
							    		        	y2: lowerBranchBoxY1 ,//上高
							    		        	scale: 1
							    		        });
			    	 	    		            
	 	    	    	    					cabinetsX = tempBranchBoxX - 32;//一个出线柜开关X轴坐标
					    	    		        //展示一个出线柜下一个开关图形（正常）
					    	    		        setCreateUseEl(layerSnap,"id" + j_epuParentId, "LoadBreakSwitch",cabinetsX,cabinetsY);
			    	 	    		        	//出线柜分割备注
			    	 	    		        	splitRemarks(layerSnap,"cabinetsID","出线柜",65,(cabinetsY+40),"fText",20);
			    	 	    		        	 createLineEl(layerSnap, {
						    		        			id :"idLine" + j_epuParentId,
						    		        			dash:"true"
						    		        		}, {
						    		        			x: svg_width,//下宽度
						    		        			y: cabinetsY + 100,//下高
						    		        			x2: 0,//上宽度
						    		        			y2: cabinetsY + 100,//上高
						    		        			scale: 1
						    		        		});
				    	 	    		        //出线柜开关往下画线
				    	 	    		        var lowerCabinetsLineX = cabinetsX + 32;//下宽度（出线柜开关下处宽度）
				    	 	    		        var lowerCabinetsLineY = cabinetsY + 50;//下高（出线柜开关下处高度）
				    	 	    		        var lowerCabinetsLineX1 = cabinetsX + 32;//上宽度
				    	 	    		        var lowerCabinetsLineY1 = cabinetsY + 42;//上高
				    	 	    		        createLineEl(layerSnap, {
							    		        		id :"lowerCabinetsID" + z_epuParentId,
							    		        		type: "TableBox"
							    		        }, {
							    		        		x: lowerCabinetsLineX,//下宽度
							    		        		y: lowerCabinetsLineY,//下高
							    		        		x2: lowerCabinetsLineX1,//上宽度
							    		        		y2: lowerCabinetsLineY1,//上高
							    		        		scale: 1
							    		        });
				    	 	    		        //将每组分支箱与出线柜开关连线 
			    	 	    		        	pos = {
		 	 	     		    		        	x: lowerBranchBoxX1,//下宽度 (分线箱上处宽度)
		 	 	     		    		        	y: lowerBranchBoxY1,//下高(分线箱上处高度)
		 	 	     		    		        	x2: lowerCabinetsLineX,//上宽度（出线柜开关下处宽度）
		 	 	     		    		        	y2: lowerCabinetsLineY,//上高（出线柜开关下处高度）
		 	 	     		    		        	scale: 1
		 	 	     		    		        };
		 	 	        		        		setPos(layerSnap,pos);
		 	 	        		        		//将一个出线柜下的开关合并
		 	 	        		        		var cabinetsLineX = cabinetsX + 32;//下宽度
		 	 	        		        		var cabinetsLineY = cabinetsY + 22;//下高
		 	 	        		        		var cabinetsLineX2 = cabinetsX + 32;//上宽度
		 	 	        		        		var cabinetsLineY2 = cabinetsY - 50;//上高
	    		 		    		        	 if (!mergeBranchBoxXAll) {
	    		     		        				 mergeBranchBoxXAll = cabinetsLineX + (branchBoxList.length - 1) * gird / 2;
	    		     		        				 //table
	    			 	    	    				 setCabinetsXTable(layerSnap,j_epuParentId,mergeBranchBoxXAll,cabinetsY - 50);//相对分线柜开关中位线显示table
	    		     		        			 }
	    		     		        			 pos={
	    		  		    		        			x: mergeBranchBoxXAll,//下宽度
	    		  		    		        			y: cabinetsLineY2,//下高
	    		  		    		        			x2: cabinetsLineX,//上宽度
	    		  		    		        			y2: cabinetsLineY,//上高
	    		  		    		        			scale: 1
	    		  		    		        		};
	    		     		        			 setPos(layerSnap,pos);
	    		     		        			if(branchBoxCount > z && branchBoxCount < ( z + 1)){
		    		   		        				  tempCabinetsX = mergeBranchBoxXAll;//下宽度
		    		   		        				  tempCabinetsY = cabinetsLineY;//下高
		    		   		        				  tempCabinetsLineX = cabinetsLineX2;//上宽度
		    		   		        				  tempCabinetsLineY = cabinetsLineY2;///上高
		    		     		        		}
	 	    	    						}
	 	    	    					}
	 	    	    					mergeBranchBoxXAll = null;
	 	    	    					//分支箱循环-end
	 	    	    					rootSwitchY = cabinetsY - rootSwitchDifference;//一个箱变开关Y轴坐标(相对出线柜往上位置 = 出线柜开关Y绝对位置  - 出线柜开关合并组与箱变开关高度y值)
	 	    	    					rootSwitchX = tempCabinetsX - 32;//一个出线柜开关X轴坐标
	 	    	    					//一组出线柜的中间X向上画线
			    	    		        var lowerCabinetsX = tempCabinetsX;//下宽度
	    	 	    		        	var lowerCabinetsY = tempCabinetsLineY;//下高
	    	 	    		        	var lowerCabinetsX1 = tempCabinetsX;//上宽度 (出现柜上处宽度)
	    	 	    		        	var lowerCabinetsY1 = rootSwitchY + 100;//上高 (出现柜上处高度)
	    	 	    		            createLineEl(layerSnap, {
					    		        	id :"idLines" + j_epuParentId,
					    		        	type: "TableBox"
					    		        }, {
					    		        	x: lowerCabinetsX,//下宽度
					    		        	y: lowerCabinetsY,//下高
					    		        	x2: lowerCabinetsX1,//上宽度
					    		        	y2: lowerCabinetsY1 ,//上高
					    		        	scale: 1
					    		        });
	    	 	    		            //将一个箱变下的开关合并
 	 	        		        		var cabinetsLineX = rootSwitchX + 32;//下宽度
 	 	        		        		var cabinetsLineY = rootSwitchY + 100;//下高
 	 	        		        		var cabinetsLineX2 = rootSwitchX + 32;//上宽度
 	 	        		        		var cabinetsLineY2 = rootSwitchY - 50;//上高
		 		    		        	 if (!mergeRootXAll) {
		 		    		        		 mergeRootXAll = cabinetsLineX + (cabinetsList.length - 1) * gird / 2;
		     		        			 }
		     		        			 pos={
		  		    		        			x: mergeRootXAll,//下宽度
		  		    		        			y: cabinetsLineY2,//下高
		  		    		        			x2: cabinetsLineX,//上宽度
		  		    		        			y2: cabinetsLineY,//上高
		  		    		        			scale: 1
		  		    		        		};
		     		        			 setPos(layerSnap,pos);
		     		        			if(cabinetsCount > j && cabinetsCount < ( j + 1)){
  		   		        				  tempRootX = mergeRootXAll;//下宽度
  		   		        				  tempRootY = cabinetsLineY;//下高
  		   		        				  tempRootLineX = cabinetsLineX2;//上宽度
  		   		        				  tempRootLineY = cabinetsLineY2;///上高
		     		        			}
	 	    						}
	 	    						mergeRootXAll = null;
	 	    					}
	 	    					//出线柜循环-end
	 	    					rootY = rootSwitchY - rootDifference;//一个箱变Y轴坐标(相对出线柜往上位置 = 出线柜中位Y绝对位置  - 出线柜合并组与箱变开关高度y值)
	    	    				//一组分支箱的中间X向上画线
	    	    		        var lowerRootX = tempRootX;//下宽度
	 	    		        	var lowerRootY = tempRootLineY;//下高
	 	    		        	var lowerRootX1 = tempRootX;//上宽度 (出线柜合并线上处宽度)
	 	    		        	var lowerRootY1 = rootY + 53;//上高 (出线柜合并线上处高度)
	 	    		            createLineEl(layerSnap, {
			    		        	id :"idLines" + i_epuParentId,
			    		        	type: "TableBox"
			    		        }, {
			    		        	x: lowerRootX,//下宽度
			    		        	y: lowerRootY,//下高
			    		        	x2: lowerRootX1,//上宽度
			    		        	y2: lowerRootY1 ,//上高
			    		        	scale: 1
			    		        });
	 	    		            
	 	    		           rootX = tempRootX - 32;//一个出线柜开关X轴坐标
	    	    		        //展示一个箱变
	 	    		           setCreateUseEl(layerSnap,"id" + i_epuParentId, "EnergyConsumer",rootX,rootY);
	 	    		          //箱变分割备注
	    					   splitRemarks(layerSnap,"rootID","箱变",45,(rootY + 50),"fText",20);
    						   createLineEl(layerSnap, {
	    		        			id :"idLine" + i_epuParentId,
	    		        			dash:"true"
	    		        		}, {
	    		        			x: svg_width,//下宽度
	    		        			y: (rootY + 80) ,//下高
	    		        			x2: 0,//上宽度
	    		        			y2: (rootY + 80),//上高
	    		        			scale: 1
	    		        		});
	        				 }
	        				 //箱变循环- end
	        			 }
	        		 }
	        	 }
	         }
	     });
	}
} 


function setPos(lay,pos){
	
	if (pos.x != pos.x2 && pos.y != pos.y2) {
		createLineEl(lay,{
//			id: n.id + "_line_1"
		}, {
			scale: pos.scale,
			x: pos.x ,
			y: pos.y,
			x2: pos.x2,
			y2: pos.y
		});
		createLineEl(lay,{
//			id: n.id + "_line_2"
		}, {
			scale: pos.scale,
			x: pos.x2 ,
			y: pos.y,
			x2: pos.x2,
			y2: pos.y2
		});
	} else {
		createLineEl(lay,{
//			id: n.id + "_line"
		}, pos);
	}
}
/**
 * 引入图状
 * **/
function setCreateUseEl(layerSnap,id,type,x,y){
	createUseEl(layerSnap, {
		id :id,
		type: type
	}, {
		x: x,
		y: y,
		scale: 1
	});
}

/**
 * 分割备注
 * **/
function splitRemarks(layerSnap,id,title,x,y,txt,size,tspan){
	createTextEl(layerSnap, {
		id:id,
		title : title,
		tspan : tspan
	}, {
		x: x,
		y: y,
		scale: 1, 
		rotate: 0,
		txt: txt,//黑色字体样式
		size:size
	});
}


/**
 **获取上级节点信息
 *param：paramEpuType 类型
 *param：rowId ROW_ID
 *param：data 数据集合
 ***/
function getRootData(paramEpuType,rowId,data){
	var arrayList = new Array();
	for(var i= 0; i< data.length; i++){
		var json = data[i];
		var rowId = json["rowId"];
		var epuType = json["epuType"];//
		if(epuType == paramEpuType && rowId == rowId){//展示箱变图像
			arrayList.push(json);
		}
	}
	return arrayList;
}

/**
 **获取下级节点信息
  *param：paramEpuType 类型
 *param：paramEpuParentId 父节点
 *param：data 数据集合
 ***/
function getNextData(paramEpuType,paramEpuParentId,data,arrayList){
	for(var i= 0; i< data.length; i++){
		var json = data[i];
		var epuParentId = json["epuParentId"];
		var epuType = json["epuType"];//
		if(epuType == paramEpuType ){
			if(epuParentId == paramEpuParentId){
				arrayList.push(json);
			}
		}
	}
	return arrayList;
}

function setCabinetsXTable(layerSnap,id,cabinetsX,cabinetsY){
//	
	var idTableNull_X = cabinetsX;
	var idTableNull_Y = cabinetsY - 150;
	setCreateUseEl(layerSnap,"idTableNull" + id, "tableList1",idTableNull_X + 32,idTableNull_Y);//空框
	
	var idTableU_X = cabinetsX +58;
	var idTableU_Y = cabinetsY -150;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableU_X,idTableU_Y);//u框
	splitRemarks(layerSnap,"idTableUtxt" + id,"U",idTableU_X + 37,idTableU_Y+22,"fText",18);//U文字
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableU_X,idTableU_Y);//u框
	
	var idTableI_X = idTableU_X +58;
	var idTableI_Y = cabinetsY -150;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableI_X,idTableI_Y);//i框
	splitRemarks(layerSnap,"idTableUtxt" + id,"I",idTableI_X + 37,idTableI_Y+22,"fText",18);//I文字
	
	var idTableP_X = idTableI_X +58;
	var idTableP_Y = cabinetsY -150;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableP_X,idTableP_Y);//P框
	splitRemarks(layerSnap,"idTableUtxt" + id,"P",idTableP_X + 37,idTableP_Y+22,"fText",18);//P文字
	
	var idTableA_X = idTableNull_X;
	var idTableA_Y = idTableNull_Y+ 26;
	
	var idTableAU_X = idTableA_X +58;
	var idTableAU_Y = idTableNull_Y+ 26;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableAU_X,idTableAU_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"5261.23",idTableAU_X + 55,idTableAU_Y+22,"fText",14);//I文字
	
	setCreateUseEl(layerSnap,"idTableUtxtzA" + id, "tableList1",idTableNull_X  + 32,idTableAU_Y);//空框
	splitRemarks(layerSnap,"idTableUtxtz" + id,"A",idTableAU_X - 5 ,idTableAU_Y+22,"fText",18);//A
	
	var idTableAI_X = idTableAU_X +58;
	var idTableAI_Y = idTableNull_Y+ 26;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableAI_X,idTableAI_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"5261.23",idTableAI_X + 55,idTableAI_Y+22,"fText",14);//U文字
	
	var idTableAP_X = idTableAI_X +58;
	var idTableAP_Y = idTableNull_Y+ 26;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableAP_X,idTableAP_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"5261.23",idTableAP_X + 55,idTableAP_Y+22,"kV110",14);//P文字

	
	
	
	var idTableBU_X = idTableA_X +58;
	var idTableBU_Y = idTableNull_Y+ 52;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableBU_X,idTableBU_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"1",idTableBU_X + 55,idTableBU_Y+22,"fText",14);//I文字
	
	setCreateUseEl(layerSnap,"idTableUtxtzB" + id, "tableList1",idTableNull_X + 32,idTableBU_Y);//空框
	splitRemarks(layerSnap,"idTableUtxtz" + id,"B",idTableBU_X - 5,idTableBU_Y+22,"fText",18);//B
	
	var idTableBI_X = idTableBU_X +58;
	var idTableBI_Y = idTableNull_Y+ 52;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableBI_X,idTableBI_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"11",idTableBI_X + 55,idTableBI_Y+22,"fText",14);//U文字
	
	var idTableBP_X = idTableBI_X +58;
	var idTableBP_Y = idTableNull_Y+ 52;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableBP_X,idTableBP_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"111",idTableBP_X + 55,idTableBP_Y+22,"kV110",14);//P文字

	
	
	
	
	var idTableCU_X = idTableA_X +58;
	var idTableCU_Y = idTableNull_Y+ 78;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableCU_X,idTableCU_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"1121",idTableCU_X + 55,idTableCU_Y+22,"fText",14);//I文字
	
	setCreateUseEl(layerSnap,"idTableUtxtzC" + id, "tableList1",idTableNull_X + 32,idTableCU_Y);//空框
	splitRemarks(layerSnap,"idTableUtxtz" + id,"C",idTableCU_X - 5,idTableCU_Y+22,"fText",18);//C
	
	var idTableCI_X = idTableCU_X +58;
	var idTableCI_Y = idTableNull_Y+ 78;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableCI_X,idTableCI_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"11",idTableCI_X + 55,idTableCI_Y+22,"fText",14);//U文字
	
	var idTableCP_X = idTableCI_X +58;
	var idTableCP_Y = idTableNull_Y+ 78;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableCP_X,idTableCP_Y);//au框
	splitRemarks(layerSnap,"idTableUtxt" + id,"111",idTableCP_X + 55,idTableCP_Y+22,"kV110",14);//P文字
}

/**
 * 文本换行符转换
 * strParam:传输的文本
 * start:以多少字符为一组范围
 * x:横向坐标
 * y:纵向坐标
 * number:y轴，累加数
 * ***/
function textNewline(strParam,start,x,y,number)
{	var str='';
	for(var i = 0;i < strParam.length;i ++){
		var chaTxt = strParam[i];
		 str += chaTxt;
		 if(!((i+1) % start)){
			str += 'woodare';
		 }
	}
	var arrs = str.split("woodare");
	var newStr = "";
	for(var i = 0;i< arrs.length;i++){
		y += number;
		newStr += "<tspan x=\"" + x + "\" y=\"" + y + "\">" + arrs[i] + "</tspan>";
	}
	return [newStr,y];
}
