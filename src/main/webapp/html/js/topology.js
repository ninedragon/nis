
d3.namespace("xmlns:cge","http://iec.ch/TC57/2005/SVG-schema#");

var lbss = [];
var svgSnap = d3.select("body").append("svg");
svgSnap.attr("width", 3975)
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
	var txt = g.append('text').attr("text-anchor", anchor).attr("font-size", size).attr("stroke", "rgb(255,0,0)").attr("fill","rgb(255,0,0)").attr("x", x).attr("y", y).text(data.title).attr("class", txtCls).attr("transform","scale(" + position.scale + ") translate(0 0) rotate(" + position.rotate + " " + x + " " + y + ")");
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
	 		        	 var tempXAll = null;
	 		        	 
	     		         var tableBoxX = 300;//表箱X绝对位置
	     		         var tableBoxY = 1000;//表箱Y绝对位置	
	     		         
	     		    	 var branchBoxX = tableBoxX;//分支箱X绝对位置
	 	        		 var branchBoxY = tableBoxY;//分支箱Y绝对位置
	 	        		 
	 	        		 var branchBoxDifference = 100;//差值
	 	        		 var branchBoxRelative = 100;//没有表箱的分支箱相对位置
	 	        	   	 var gird = 100;
	 		        	 var tempXAll = null;
	 	        		 
	 	    	         var cabinetsX = branchBoxX;//出线柜X绝对位置
	     		         var cabinetsY = branchBoxY;//出现柜Y绝对位置
	     		         var cabinetsDifference = 300;
	     		         
	     		         var rootX = cabinetsX;//箱变X绝对位置
	     		         var rootY = cabinetsY;//箱变Y绝对位置
	     		         var rootDifference = 350;//root相对的高度y
	     		         
	     		         var tempCount = 0;//获取分线箱的组中位数
	     		         var tempBranchBoxX = 0;//获取到分线箱的下宽度
	     		         var tempBranchBoxY = 0;//获取到分线箱的下高
	     		         var tempBranchBoxLineX = 0;//获取到分线箱的上宽度
	     		         var tempBranchBoxLineY = 0;//获取到分线箱的上高
	     		         
	     		         
	 	    			 var rootList  = getRootData("M0001",rowId,data);//箱变
	 	    			if(null != rootList && rootList.length >0){
	 	    				for(var i= 0; i< rootList.length; i++){
	 	    					var i_json = rootList[i];
	 	    					var i_epuParentId = i_json["rowId"];
	 	    					var cabinetsList  = new Array();//出线柜
	 	    					var lsitBranchBoxXY = new Array();//定义出线柜的上处划线的上宽度 上高度
	 	    					getNextData("M0002",i_epuParentId,data,cabinetsList);
	 	    					if(null != cabinetsList && cabinetsList.length > 0){
	 	    						//出线柜循环 -begin
	 	    						for(var j= 0; j < cabinetsList.length; j++){
	 	    	    					var j_json = cabinetsList[j];
	 	    	    					var j_epuParentId = j_json["rowId"];
	 	    							var branchBoxList  = new Array();//分支箱
	 	    	    					getNextData("M0003",j_epuParentId,data,branchBoxList);
	 	    	    					if(null != branchBoxList && branchBoxList.length > 0){
	 	    	    						var tableBoxList  = new Array();//表箱
	 	    	    						//分支箱循环-begin
	 	    	    						for(var z= 0; z < branchBoxList.length; z++){
	 	    	    	    					var z_json = branchBoxList[z];
	 	    	    	    					var z_epuParentId = z_json["rowId"];
	 	    	    	    					 var z_epuStatus = z_json["epuStatus"];
	 	    	    	    					getNextData("M0004",z_epuParentId,data,tableBoxList);
	 	    	    	    					if(null != tableBoxList && tableBoxList.length > 0){//有表箱集合的
	 	    	    	    						tempCount = tableBoxList.length-1 / 2;
	 	    	    	    						//表箱循环-begin
	 		    	    	    					for(var x= 0; x < tableBoxList.length; x ++){
	 		    	    	    						var x_json = tableBoxList[x];
	 		    	    	    						var x_rowId = x_json["rowId"];
	 		    	    	    						 var x_epuStatus = x_json["epuStatus"];
	 		    	    	    						//展示表箱
	 		    	    	    						tableBoxX = tableBoxX + gird;
	 		    	    	    						 setCreateUseEl(layerSnap,"id" + x_rowId, "TableBox",tableBoxX,tableBoxY);
	 		    	    	    						//表箱文本引入
	 		    		    		        			 var tableBoTxtX = tableBoxX + 50;
	 		    		    		        			 var tableBoTxtY = tableBoxY + 35;
	 		    		    		        			 //x_json["epuName"]
	 		    		    		        			splitRemarks(layerSnap,"idTxt" + x_rowId,x_json["epuName"],tableBoTxtX,tableBoTxtY,"fText",12);
	 		    		    		        			//给表箱绑定单击事件
	 		    		    		        			$("#idTxt" + x_rowId).bind("click",function(){
	 		    	    	    							  var txtID = $(this).attr("id");//展示的文字ID
	 		    	    	    							  parent.$("#tableBoxId").val(txtID.replace("idTxt",""));//当前表箱ID
	 		    	    	    							  var textValue = $(this).text();//展示的文字内容
	 		    	    	    							  parent.$("#tableBoxName").html(textValue + "单线图");//TAB
	 		    	    	    							  
	 		    	    	    							  var rowId = parent.$("#rowId").val();//获取箱变根ID
	 		    	    	    				              var iframeID  = parent.$("#tab3Iframe")[0];//获取iframe的ID
	 		    	    	    				              var tableBoxId = parent.$("#tableBoxId").val();//获取箱变根ID
	 		    	    	    				              //只有电表TAB可以执行此动作
		    	    	    				            	  iframeID.contentWindow.showTop(rowId,tableBoxId);
	 		    	    	    						});
	 		    	    	    						//表箱分割备注
	 		    	    		    		        	splitRemarks(layerSnap,"tableBoxID","表箱",45,(tableBoxY + 40),"fText",20);
	 		    	    	    						 //引入表箱与分支箱线
	 		    		    		        			 createLineEl(layerSnap, {
	 		    				    		        			id :"idLine" + x_rowId,
	 		    				    		        			type: "TableBox"
	 		    				    		        		}, {
	 		    				    		        			x: tableBoxX + 33,//下宽度
	 		    				    		        			y: tableBoxY + 13,//下高
	 		    				    		        			x2: tableBoxX + 32,//上宽度
	 		    				    		        			y2: tableBoxY - 58,//上高
	 		    				    		        			scale: 1
	 		    				    		        		});
	 		    	    	    						 //展示分支箱图形（正常）
	 		    	    	    						 branchBoxX = tableBoxX ;
	 		    	    	    		        		 branchBoxY = tableBoxY - branchBoxDifference;
	 		    	    	    		        		 setCreateUseEl(layerSnap,"id" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	 		    	  		    		        	    //分支箱分割备注
	 		    	    		    		            splitRemarks(layerSnap,"branchBoxID","分支箱",65,(branchBoxY + 40),"fText",20);
	 		    	    		    		        	 //连接线
	 		    	    		    		        	 //合并分支箱
	 		    	    		    		        	 branchBoxLineX = branchBoxX + 32;//下宽度
	 		    	    		    		        	 branchBoxLineY = branchBoxY + 22;//下高
	 		    	    		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
	 		    	    		    		        	 branchBoxLineY2 = branchBoxY - 80;//上高
	 		    	    		    		        	 if (!tempXAll) {
	 		    	        		        				 tempXAll = branchBoxLineX + (tableBoxList.length -1) * gird / 2;
	 		    	        		        			 }
	 		    	        		        			 pos={
	 		    	     		    		        			x: tempXAll,//下宽度
	 		    	     		    		        			y: branchBoxLineY2,//下高
	 		    	     		    		        			x2: branchBoxLineX,//上宽度
	 		    	     		    		        			y2: branchBoxLineY,//上高
	 		    	     		    		        			scale: 1
	 		    	     		    		        		};
	// 		    	        		        			 console.log(pos);
	 		    	        		        			 setPos(layerSnap,pos);
	 		    	        		        			 if(tempCount >x && tempCount < ( x + 1)){
	 		    	        		        				  tempBranchBoxX = tempXAll;//下宽度
	 		    	        		          		          tempBranchBoxY = branchBoxLineY;//下高
	 		    	        		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
	 		    	        		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	 		    	        		        			 }
	 		    	    	    					}
	 		    	    	    					//表箱循环-end
	 	    	    	    					}else{//当前分支箱下没有表箱,先占位
	 	    	    	    						//展示表箱
	 	    	    	    						tableBoxX = tableBoxX + gird;
	 	    	    	    						//表箱分割备注
	 	    	    		    		        	splitRemarks(layerSnap,"tableBoxID","表箱",45,(tableBoxY + 40),"fText",20);
	 	    		    		        			 temptableBoxX = tableBoxX - branchBoxRelative;//表箱位置X -没有表箱的分支箱相对位置 = 落点宽度
	 	    		    		        			 //引入表箱与分支箱线
	 	    		    		        			 createLineEl(layerSnap, {
	 	    				    		        			id :"idLine" + z_epuParentId,
	 	    				    		        			type: "TableBox"
	 	    				    		        		}, {
	 	    				    		        			x: temptableBoxX + 33,//下宽度
	 	    				    		        			y: tableBoxY + 13,//下高
	 	    				    		        			x2: temptableBoxX + 32,//上宽度
	 	    				    		        			y2: tableBoxY - 58,//上高
	 	    				    		        			scale: 1
	 	    				    		        		});
	 	    	    	    						//只展现一个分支箱图形（正常）
	 	    	    	    						 branchBoxX = tableBoxX - branchBoxRelative;//表箱位置X -没有表箱的分支箱相对位置 = 落点宽度
	 	    	    	    		        		 branchBoxY = tableBoxY - branchBoxDifference;//表箱位置Y -差值=落点高度
	 	    	    		    		        	 setCreateUseEl(layerSnap,"id" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	     	    		    		        	    //分支箱分割备注
	     	    		    		        		splitRemarks(layerSnap,"branchBoxID","分支箱",65,(branchBoxY + 40),"fText",20);
	 	    	    		    		        	 //连接线
	     		    	    	    		         branchBoxLineX = branchBoxX + 32;//下宽度
	     		    		    		        	 branchBoxLineY = branchBoxY + 22;//下高
	     		    		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
	     		    		    		        	 branchBoxLineY2 = branchBoxY - 80;//上高
	     		    		    		        	 if(tableBoxList.length > 0){
	     		    		    		        		 tempXAll = branchBoxLineX + (tableBoxList.length -1) * gird / 2;
	     		    		    		        	 }else{
	     		    		    		        		 tempXAll = branchBoxLineX + (tableBoxList.length) * gird / 2;
	     		    		    		        	 }
	     		    	    	    		         pos = {
	     	 	     		    		        			x: tempXAll,//下宽度
	     	 	     		    		        			y: branchBoxLineY2,//下高
	     	 	     		    		        			x2: branchBoxLineX,//上宽度
	     	 	     		    		        			y2: branchBoxLineY,//上高
	     	 	     		    		        			scale: 1
	     	 	     		    		        		};
	     		    	    	    		         tempBranchBoxX = tempXAll;//下宽度
	 	   	        		          		          tempBranchBoxY = branchBoxLineY;//下高
	 	   	        		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
	 	   	        		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	//     	 	        		        			 console.log(pos);
	     	 	        		        			 setPos(layerSnap,pos);
	 	    	    	    					}
	 	    	    	    					 tempXAll = null;//清空
	 	    	    	    				}
	 	    	    						//分支箱循环-end
	 	    	    				         cabinetsX = branchBoxX;
	 	    	    	    		         cabinetsY = branchBoxY - cabinetsDifference ;
	 	    	    	    		       //出线柜-红色
	 	    	    	    		         setCreateUseEl(layerSnap,"id" + j_epuParentId, "LoadBreakSwitchRed",cabinetsX,cabinetsY);
	 	    	    	    		         //table
	 	    	    	    		         setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX,cabinetsY);
	 	    	 	    		        	//出线柜分割备注
	 	    	 	    		        	splitRemarks(layerSnap,"cabinetsID","出线柜",65,(cabinetsY+40),"fText",20);
	 	    	 	    		        	//出现柜往上画线
	 	    	 	    		        	var upperCabinetsLineX = cabinetsX + 32;//下宽度（出线柜上处宽度）
	 	    	 	    		        	var upperCabinetsLineY = cabinetsY -20 ;//下高（分线柜上处高度）
	 	    	 	    		        	var upperCabinetsLineX1 =cabinetsX + 32;//上宽度
	 	    	 	    		        	var upperCabinetsLineY1 = cabinetsY +23;//上高
	 	    	 	    		        	 createLineEl(layerSnap, {
	 				    		        			id :"upperCabinetsID" + z_epuParentId,
	 				    		        			type: "TableBox"
	 				    		        		}, {
	 				    		        			x: upperCabinetsLineX,//下宽度
	 				    		        			y: upperCabinetsLineY,//下高
	 				    		        			x2: upperCabinetsLineX1,//上宽度
	 				    		        			y2: upperCabinetsLineY1,//上高
	 				    		        			scale: 1
	 				    		        		});
	 	    	 	    		        	 
	 	    	 	    		        	 var jsonBranchBoxXY = {};
	 	    	 	    		        	jsonBranchBoxXY["epuParentId"]= z_epuParentId;
	 	    	 	    		        	jsonBranchBoxXY["upperCabinetsLineX"]= upperCabinetsLineX;
	 	    	 	    		        	jsonBranchBoxXY["upperCabinetsLineY"]= upperCabinetsLineY;
	 	    	 	    		        	lsitBranchBoxXY.push(jsonBranchBoxXY);
	 	    	 	    		        	 
	 	    	 	    		        	//出线柜往下画线
	 	    	 	    		        	var lowerCabinetsLineX = cabinetsX + 32;//下宽度（出线柜下处宽度）
	 	    	 	    		        	var lowerCabinetsLineY = cabinetsY + 100;//下高（分线柜下处高度）
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
	 	    	 	    		        	  
	 	    	 	    		        	 if(tableBoxList.length > 1){//分线箱下面有表箱(有表箱，表箱与分纤箱一对一)的执行如下：
	 	    	 	    		        		var lowerBranchBoxX = tempBranchBoxX;//下宽度
	 	    	 	    		        		var lowerBranchBoxY = tempBranchBoxLineY;//下高
	 	    	 	    		        		var lowerBranchBoxX1 = tempBranchBoxLineX - 100;//上宽度 (分线箱上处宽度)
	 	    	 	    		        		var lowerBranchBoxY1 = cabinetsY + 100;//上高 (分线箱上处高度)
	 	    	 	    		        		 createLineEl(layerSnap, {
	 					    		        			id :"idLines" + j_epuParentId,
	 					    		        			type: "TableBox"
	 					    		        		}, {
	 					    		        			x: lowerBranchBoxX,//下宽度
	 					    		        			y: lowerBranchBoxY,//下高
	 					    		        			x2: lowerBranchBoxX1,//上宽度
	 					    		        			y2: lowerBranchBoxY1 ,//上高
	 					    		        			scale: 1
	 					    		        		});
	 	    	 	    		        		 pos = {
	  	 	     		    		        			x: lowerBranchBoxX1,//下宽度 (分线箱上处宽度)
	  	 	     		    		        			y: lowerBranchBoxY1,//下高(分线箱上处高度)
	  	 	     		    		        			x2: lowerCabinetsLineX,//上宽度
	  	 	     		    		        			y2: lowerCabinetsLineY,//上高
	  	 	     		    		        			scale: 1
	  	 	     		    		        		};
	//  	 	        		        			 console.log(pos);
	  	 	        		        			 setPos(layerSnap,pos);
	 	    	 	    		        	 }else{//没有表箱的默认
	 		    	 	    		        	 createLineEl(layerSnap, {
	 					    		        			id :"idLines" + j_epuParentId,
	 					    		        			type: "TableBox"
	 					    		        		}, {
	 					    		        			x: tempBranchBoxX,//下宽度
	 					    		        			y: tempBranchBoxLineY,//下高
	 					    		        			x2: tempBranchBoxLineX - 0.5,//上宽度
	 					    		        			y2: cabinetsY + 50,//上高
	 					    		        			scale: 1
	 					    		        		});
	 	    	 	    		        	 }
	 	    	    					}else{//当前出线柜下没有分支箱,先占位
	 	    	    						//只展现一个出线柜
	 	    	    				         cabinetsX = cabinetsX - 30;
	 	    	    	    		         cabinetsY = branchBoxY - cabinetsDifference ;
	 	    	    	    		       //出线柜-红色
	 	    	 	    		        	setCreateUseEl(layerSnap,"id" + j_epuParentId, "LoadBreakSwitchRed",cabinetsX,cabinetsY);
	 	    	 	    		           //table
	 	    	    	    		         setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX,cabinetsY);
	 	    	 	    		        	//出线柜分割备注
	 	    	 	    		        	splitRemarks(layerSnap,"cabinetsID","出线柜",65,(cabinetsY+40),"fText",20);
	 	    	 	    		        	//出现柜往上画线
	 	    	 	    		        	var upperCabinetsLineX = cabinetsX + 32;//下宽度（出线柜上处宽度）
	 	    	 	    		        	var upperCabinetsLineY = cabinetsY -20 ;//下高（分线柜上处高度）
	 	    	 	    		        	var upperCabinetsLineX1 =cabinetsX + 32;//上宽度
	 	    	 	    		        	var upperCabinetsLineY1 = cabinetsY +23;//上高
	 	    	 	    		        	 createLineEl(layerSnap, {
	 				    		        			id :"upperCabinetsID" + z_epuParentId,
	 				    		        			type: "TableBox"
	 				    		        		}, {
	 				    		        			x: upperCabinetsLineX,//下宽度
	 				    		        			y: upperCabinetsLineY,//下高
	 				    		        			x2: upperCabinetsLineX1,//上宽度
	 				    		        			y2: upperCabinetsLineY1,//上高
	 				    		        			scale: 1
	 				    		        		});
	 	    	 	    		        	 
	 	    	 	    		        	 var jsonBranchBoxXY = {};
	 	    	 	    		        	jsonBranchBoxXY["epuParentId"]= z_epuParentId;
	 	    	 	    		        	jsonBranchBoxXY["upperCabinetsLineX"]= upperCabinetsLineX;
	 	    	 	    		        	jsonBranchBoxXY["upperCabinetsLineY"]= upperCabinetsLineY;
	 	    	 	    		        	lsitBranchBoxXY.push(jsonBranchBoxXY);
	 	    	 	    		        	
	 	    	 	    		        	//出线柜往下画线
	 	    	 	    		        	var lowerCabinetsLineX = cabinetsX + 32;//下宽度（出线柜下处宽度）
	 	    	 	    		        	var lowerCabinetsLineY = cabinetsY + 100;//下高（分线柜下处高度）
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
	 	    	    					}
	 	    	    				}
	 	    						//出线柜循环 -end
	 	    						//展示箱变
	 	    						 rootX = cabinetsX;
	 	    	    		         rootY = cabinetsY - rootDifference;
	 	    	    		        setCreateUseEl(layerSnap,"id" + i_epuParentId, "EnergyConsumer",rootX,rootY);
	 	    						//箱变分割备注
	 	    						splitRemarks(layerSnap,"rootID","箱变",45,(rootY + 40),"fText",20);
	 	    						//箱变往下画线
	 	 	    		        	var tempCabinetsLineX = rootX + 32;//下宽度（箱变下处宽度）
	 	 	    		        	var tempCabinetsLineY = rootY + 80;//下高（箱变下处高度）
	 	 	    		        	var tempCabinetsLineX1 =rootX + 32;//上宽度
	 	 	    		        	var tempCabinetsLineY1 = rootY + 55;//上高
	 	 	    		        	 createLineEl(layerSnap, {
	 		    		        			id :"rootID" + i_epuParentId,
	 		    		        			type: "TableBox"
	 		    		        		}, {
	 		    		        			x: tempCabinetsLineX,//下宽度
	 		    		        			y: tempCabinetsLineY,//下高
	 		    		        			x2: tempCabinetsLineX1,//上宽度
	 		    		        			y2: tempCabinetsLineY1,//上高
	 		    		        			scale: 1
	 		    		        		});
	 	 	    		        	 for(var k = 0;k < lsitBranchBoxXY.length ;k++){
	 	 	    		        		 var k_json = lsitBranchBoxXY[k];
	 	 	    		        		 k_epuParentId = k_json["epuParentId"];
	 	 	    		        		upperCabinetsLineX = k_json["upperCabinetsLineX"];
	 	 	    		        		upperCabinetsLineY = k_json["upperCabinetsLineY"];
	 	 	    		        		 pos = {
	 	     		    		        			x: upperCabinetsLineX,//下宽度 (出线柜头部上处宽度)
	 	     		    		        			y: upperCabinetsLineY,//下高(出线柜头部上处高度)
	 	     		    		        			x2: tempCabinetsLineX,//上宽度
	 	     		    		        			y2: tempCabinetsLineY,//上高
	 	     		    		        			scale: 1
	 	     		    		        		};
	// 	 	    		        		 console.log(pos);
	 	        		        		 setPos(layerSnap,pos);
	 	 	    		        	 }
	 	    					}else{//当前箱变出线柜站位
	 	    						//只展示一个箱变
	 	    						rootX = cabinetsX;
	 	    	    		        rootY = cabinetsY - rootDifference;
	 	    						setCreateUseEl(layerSnap,"id"+i_epuParentId, "EnergyConsumer",rootX,rootY);
	 	    						//箱变分割备注
	 	    						splitRemarks(layerSnap,"rootID","箱变",45,(rootY + 40),"fText",20);
	 	    						
	 	    					}
	 	    				}
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
function splitRemarks(layerSnap,id,title,x,y,txt,size){
	createTextEl(layerSnap, {
		id:id,
		title : title
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

