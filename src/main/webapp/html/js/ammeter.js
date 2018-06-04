
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

var scaleZoom = 1;
var dataTemp = null;
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
		path.attr("stroke-dasharray", "3 3");
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
 * 展示电表信息
 * @param rowIdParam 箱变根
 * @param tableBoxId 表箱ID
 */
function showTop(data,rowId,tableBoxId){
	svgSnap.select("g[id='ammeter_Layer']").remove();
	var layerSnap = svgSnap.append("g").attr("id","ammeter_Layer");
	dataTemp = data;
//	 eupType ： 
//	 M0001 箱变
//	 M0002 出线柜
//	 M0003 分支箱
//	 M0004 表箱
	if((null != rowId && "" != rowId ) && (null != tableBoxId && "" != tableBoxId )){
//		 $.ajax({
//             type: "post",
//             url:  getRootPath_web()+"/epu/getEupInfosTree.shtml",
//	         data: {
//	        	 rootId: rowId
//	         },
////             async:false,
//             dataType: "json",
//             cache: false,
//             error: function (a,b,c) {
//             },
//             success: function (data) {
				setScale(svgSnap,1);
            	 if(null != data && data.length > 0){
     	         	var branchBoxDifference = 100;//差值
 	        		var branchBoxRelative = 100;//没有表箱的分支箱相对位置
 	        	   	var gird = 100;
 		        	var tempXAll = null;
 		        	var ammeterX = 100;//电表X绝对位置
	     		    var ammeterY = 500;//电表Y绝对位置	
	     			var branchBoxX = ammeterX;//分支箱X绝对位置
 	        		var branchBoxY = ammeterY;//分支箱Y绝对位置    
	     		         
 	        		var cabinetsX = branchBoxX;//出线柜X绝对位置
 	        		var cabinetsY = branchBoxY;//出现柜Y绝对位置
 	        		var cabinetsDifference = 300;
 	        		
 	        		
        		   var tempCount = 0;//获取分线箱的组中位数
  		           var tempBranchBoxX = 0;//获取到分线箱的下宽度
  		           var tempBranchBoxY = 0;//获取到分线箱的下高
  		           var tempBranchBoxLineX = 0;//获取到分线箱的上宽度
  		           var tempBranchBoxLineY = 0;//获取到分线箱的上高
     			   var rootList  = getRootData("M0004",tableBoxId,data);//表箱
     			   if(null != rootList && rootList.length > 0){//有表箱集合的
     				  var lsitBranchBoxXY = new Array();//定义出线柜的上处划线的上宽度 上高度
     					//表箱循环-begin
	       			 	for(var i= 0; i < rootList.length;i ++){
		       			 	var i_json = rootList[i];
	    			 		var i_epuParentId = i_json["rowId"];
	    			 		var ammeterList = new Array();
	    			 		getNextData("M0005",i_epuParentId,data,ammeterList);//电表(epuId根据这个找下级)
	    			 		if(null != ammeterList && ammeterList.length > 0){//有电表集合的
	    			 			tempCount = ammeterList.length-1 / 2;
	        			 		//电表循环 -begin
	        			 		for(var x = 0;x < ammeterList.length ;x ++){
	        			 			var x_json = ammeterList[x];
	        			 			var x_rowId = x_json["ammeterId"];//电表ID
	        			 			var x_name = x_json["ammeterName"];//电表名称
	        			 			//展示电表
	        			 			ammeterX = ammeterX + gird;
	 	    						setCreateUseEl(layerSnap,"id" + x_rowId, "TableBox",ammeterX,ammeterY);
	 	    						splitRemarks(layerSnap,"idTitle" + x_rowId,"电表",ammeterX + 50,ammeterY + 40,"fText",16);//电表标题
	 	    						//电表文本引入
	    		        			 var ammeterTxtX = ammeterX + 70;
	    		        			 var ammeterTxtY = ammeterY + 35;
	    		        			 var textNewlineArr = textNewline(x_name,6,ammeterTxtX-20,ammeterTxtY + 20,20);
	    		    		         splitRemarks(layerSnap,"idTxt" + x_rowId,textNewlineArr[0],0 ,0,"fText",12,true);//电表文本文本内容
	    		    		         //table
	    		    		         var table_ammeterY = textNewlineArr[1] + 180;
	    		    		         setammeterTable(layerSnap,x_rowId,ammeterX-65,table_ammeterY);
	    		    		 		//电表分割备注
		 		    		        	splitRemarks(layerSnap,"ammeterTxtID","电表",45,(ammeterY + 40),"fText",20);
	 		    		        	 //引入电表与分支箱线
	    		        			 createLineEl(layerSnap, {
			    		        			id :"idLine" + x_rowId,
			    		        			type: "TableBox"
			    		        		}, {
			    		        			x: ammeterX + 32,//下宽度
			    		        			y: ammeterY + 13,//下高
			    		        			x2: ammeterX + 32,//上宽度
			    		        			y2: ammeterY - 58,//上高
			    		        			scale: 1
			    		        		});
	    		        			 //展示分支箱图形（正常）
	 	    						 branchBoxX = ammeterX;
	 	    		        		 branchBoxY = ammeterY- branchBoxDifference;
//	 	    		        		 setCreateUseEl(layerSnap,"branchBoxid" + i_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	 	    		        		 //合并分支箱
	 		    		        	 branchBoxLineX = branchBoxX + 32;//下宽度
	 		    		        	 branchBoxLineY = branchBoxY + 50;//下高
	 		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
	 		    		        	 branchBoxLineY2 = branchBoxY - 80;//上高
	 		    		        	 if (!tempXAll) {
	     		        				 tempXAll = branchBoxLineX + (ammeterList.length -1) * gird / 2;
	     		        			 }
	     		        			 pos={
	  		    		        			x: tempXAll,//下宽度
	  		    		        			y: branchBoxLineY2,//下高
	  		    		        			x2: branchBoxLineX,//上宽度
	  		    		        			y2: branchBoxLineY,//上高
	  		    		        			scale: 1
	  		    		        		};
	     		        			 setPos(layerSnap,pos);
	     		        			if(tempCount >x && tempCount < ( x + 1)){
	   		        				  tempBranchBoxX = tempXAll;//下宽度
	   		          		          tempBranchBoxY = branchBoxLineY;//下高
	   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
	   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	     		        			}
	        			 		}
	        			 		//电表循环 -end
	    			 		}
	       			 	}
	       			 	//表箱循环-end
    					 tempXAll = null;//清空
    			 		//没有数据的电表 -end
	    				cabinetsX = branchBoxX;
	    		         cabinetsY = branchBoxY - cabinetsDifference ;
	    		         if(tempBranchBoxX == 0){return false;}
	    		       //表箱
	    		         setCreateUseEl(layerSnap,"id" + i_epuParentId, "TableBox",tempBranchBoxX -35,cabinetsY);
	    		         //文本内容
	    		         var tableBoTxtX = tempBranchBoxX + 10;
	    		         var tableBoTxtY = cabinetsY + 35;
	    		         splitRemarks(layerSnap,"idTitle" + i_epuParentId,"表箱",tableBoTxtX+5,tableBoTxtY+5,"fText",16);//标题
	    		         var i_epuName = i_json["epuName"]||"";
	    		         var textNewlineArr = textNewline(i_epuName,6,tableBoTxtX+20,tableBoTxtY + 20,20);
	    		         splitRemarks(layerSnap,"idTxt" + i_epuParentId,textNewlineArr[0],0 ,0,"fText",12,true);//表箱文本内容
	    		         //table
	    		         setCabinetsXTable(layerSnap,i_epuParentId,tempBranchBoxX+30,cabinetsY + 150);
	    		        	//出线柜分割备注
	    		        	splitRemarks(layerSnap,"cabinetsID","表箱",45,(cabinetsY+40),"fText",20);
	    		        	//出线柜往下画线
	    		        	var lowerCabinetsLineX = tempBranchBoxX;//下宽度（出线柜下处宽度）
	    		        	var lowerCabinetsLineY = cabinetsY + 100;//下高（分线柜下处高度）
	    		        	var lowerCabinetsLineX1 = tempBranchBoxX ;//上宽度
	    		        	var lowerCabinetsLineY1 = cabinetsY + 50;//上高
	    		        	createLineEl(layerSnap, {
	    		        		id :"lowerCabinetsID" + i_epuParentId,
	    		        		type: "TableBox"
	    		        	}, {
	    		        		x: lowerCabinetsLineX,//下宽度
	    		        		y: lowerCabinetsLineY,//下高
	    		        		x2: lowerCabinetsLineX1,//上宽度
	    		        		y2: lowerCabinetsLineY1,//上高
	    		        		scale: 1
	    		        	});
	    		        	 if(ammeterList.length > 0){//分线箱下面有表箱(有表箱，表箱与分纤箱一对一)的执行如下：
	    		        		var lowerBranchBoxX = tempBranchBoxX;//下宽度
	    		        		var lowerBranchBoxY = tempBranchBoxLineY;//下高
	    		        		 createLineEl(layerSnap, {
	    		        			id :"idLines" + i_epuParentId,
	    		        			type: "TableBox"
	    		        		}, {
	    		        			x: lowerBranchBoxX,//下宽度
	    		        			y: lowerBranchBoxY,//下高
	    		        			x2: lowerCabinetsLineX1,//上宽度
	    		        			y2: lowerCabinetsLineY1 ,//上高
	    		        			scale: 1
	    		        		});
	    		        		 pos = {
		    		        			x: lowerCabinetsLineX1,//下宽度 (分线箱上处宽度)
		    		        			y: lowerCabinetsLineY1,//下高(分线箱上处高度)
		    		        			x2: lowerCabinetsLineX,//上宽度
		    		        			y2: lowerCabinetsLineY,//上高
		    		        			scale: 1
		    		        		};
	    		        		 setPos(layerSnap,pos);
	    		        	 }else{//没有表箱的默认
 	 	    		        	 createLineEl(layerSnap, {
			    		        			id :"idLines" + i_epuParentId,
			    		        			type: "TableBox"
			    		        		}, {
			    		        			x: tempBranchBoxX,//下宽度
			    		        			y: tempBranchBoxLineY,//下高
			    		        			x2: tempBranchBoxLineX - 0.5,//上宽度
			    		        			y2: cabinetsY + 50,//上高
			    		        			scale: 1
			    		        		});
	 	    		        	 }
     			   }
            	}
            	 var widthVal = (ammeterX + 350);
            	 var heightVal = (table_ammeterY + 150);
            	 parent.$("#tab3Iframe").attr("width", widthVal).attr("height", heightVal);
            	 svgSnap.attr("width", widthVal).attr("height", heightVal)
            	 parent.$(".ammeter").css("width", (widthVal + 20)+"px").css("height", (heightVal - 150)+ "px");
//         });
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
 *param：rowIdParam ROW_ID
 *param：data 数据集合
 ***/
function getRootData(paramEpuType,rowIdParam,data){
	var arrayList = new Array();
	for(var i= 0; i< data.length; i++){
		var json = data[i];
		var rowId = json["rowId"];
		var epuType = json["epuType"];//
		if(epuType == paramEpuType && rowIdParam == rowId){//展示箱变图像
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
		var epuParentId = json["epuId"];
		var epuType = json["epuType"];
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
//	setCreateUseEl(layerSnap,"idTableNull" + id, "tableList",idTableNull_X,idTableNull_Y);//空框
	
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
	
	splitRemarks(layerSnap,"idTableUtxtz" + id,"A",idTableAU_X ,idTableAU_Y+22,"fText",18);//A
	
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
	
	splitRemarks(layerSnap,"idTableUtxtz" + id,"B",idTableBU_X ,idTableBU_Y+22,"fText",18);//B
	
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
	
	splitRemarks(layerSnap,"idTableUtxtz" + id,"C",idTableCU_X ,idTableCU_Y+22,"fText",18);//C
	
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
 * 电表信息
 * **/
function setammeterTable(layerSnap,id,cabinetsX,cabinetsY){
	var UbTemp_Y = 150; 
	var idTableUb_X = cabinetsX + 58;
	var idTableUb_Y = cabinetsY - UbTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList1",idTableUb_X,idTableUb_Y);//u框
	splitRemarks(layerSnap,"idTableUtxt" + id,"Ub",idTableUb_X + 25,idTableUb_Y + 22,"fText",18);//Ub文字
	var idTableUb1_X = idTableUb_X + 26;
	var idTableUb1_Y = cabinetsY - UbTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableUb1_X,idTableUb1_Y);//i框
	splitRemarks(layerSnap,"idTableUtxt" + id,"220.1",idTableUb1_X + 60,idTableUb1_Y+22,"fText",14);//I文字
	
	var IbTemp_Y = 124; 
	var idTableIb_X = cabinetsX + 58;
	var idTableIb_Y = cabinetsY - IbTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList1",idTableIb_X,idTableIb_Y);//u框
	splitRemarks(layerSnap,"idTableUtxt" + id,"Ib",idTableIb_X + 25,idTableIb_Y + 22,"fText",18);//Ib文字
	var idTableIb1_X = idTableIb_X + 26;
	var idTableIb1_Y = cabinetsY - IbTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableIb1_X,idTableIb1_Y);//i框
	splitRemarks(layerSnap,"idTableUtxt" + id,"3.2",idTableIb1_X + 60,idTableIb1_Y+22,"fText",14);
	
	
	var pTemp_Y = 98; 
	var idTableP_X = cabinetsX + 58;
	var idTableP_Y = cabinetsY - pTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList1",idTableP_X,idTableP_Y);//u框
	splitRemarks(layerSnap,"idTableUtxt" + id,"P",idTableP_X + 25,idTableP_Y + 22,"fText",18);//P文字
	var idTableP1_X = idTableP_X + 26;
	var idTableP1_Y = cabinetsY - pTemp_Y;
	setCreateUseEl(layerSnap,"idTableU" + id, "tableList",idTableP1_X,idTableP1_Y);//i框
	splitRemarks(layerSnap,"idTableUtxt" + id,"5.2",idTableP1_X + 60,idTableP1_Y+22,"fText",14);
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

/**
* 单击执行放大缩小
**/
function clickScale(param){
	scaleZoom = scaleZoom || 1;
	if(param == "max"){
		if(scaleZoom < 0.9){
			scaleZoom = scaleZoom + 0.1;
			setScale(svgSnap,scaleZoom);
		}else if(scaleZoom >= 0.9){
			var rowId = parent.$("#rowId").val();
			var tableBoxId = parent.$("#tableBoxId").val();
			scaleZoom = 1;//每次单击菜单，缩放级别回归到1
			$("#wd").val(scaleZoom);//文本框内容缩放级别值
			showTop(dataTemp,rowId,tableBoxId);
		}
	}else if(param == "min"){
		if(scaleZoom > 0.2){
			scaleZoom = scaleZoom - 0.1;
			setScale(svgSnap,scaleZoom);
		}
	} 
}

function setScale(svgSnap,zoom){
	var x = 0;
	var y = 0;
	if(zoom < 1){
		zoom = zoom.toFixed(1);
	}
	$("#wd").val(zoom);//文本框内容缩放级别值
	svgSnap.attr("transform","scale(" + zoom + " " + zoom + ") translate(" + x + " " + y + ")");
}

$(function() {
	  //绑定事件
	parent.$("#tableBoxDiv").scroll(function(){
	 	$(".gj").css("top", ($(this).scrollTop() ));
  		$(".gj").css("left", ($(this).scrollLeft() ));
	 });
});
