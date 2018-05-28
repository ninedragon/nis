
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
	        			 var rootList  = getRootData("M0001",rowId,data);//箱变
	        			 if(null != rootList && rootList.length > 0){
        					var branchBoxDifference = 100;//差值
         	        		var branchBoxRelative = 100;//没有表箱的分支箱相对位置
         	        	   	var gird = 80;
         		        	var mergeBranchBoxXAll = null;//每组合并时候取中间值
         		        	var ammeterX = 200;//电表X绝对位置
        	     		    var ammeterY = 600;//电表Y绝对位置	
        	     			var branchBoxX = ammeterX;//分支箱X绝对位置
         	        		var branchBoxY = ammeterY;//分支箱Y绝对位置    
        	     		         
         	        		var cabinetsX = branchBoxX;//出线柜X绝对位置
         	        		var cabinetsY = branchBoxY;//出现柜Y绝对位置
         	        		var cabinetsDifference = 150;//设置出线柜相对分支箱高度
         	        		var cabinetsDifferenceTemp = 150;//设置出线柜与箱变之间图形的相对分支箱高度
         	        		
         	        		var mergeCabinetsXAll = null;
	        				 //箱变循环- begin
	        				 for(var i= 0; i < rootList.length; i++){
        						var i_json = rootList[i];
	 	    					var i_epuParentId = i_json["rowId"];
	 	    					var cabinetsList  = new Array();//出线柜
	 	    					var lsitBranchBoxXY = new Array();//定义出线柜的上处划线的上宽度 上高度
	 	    					getNextData("M0002",i_epuParentId,data,cabinetsList);
	 	    					var tempCabinetsCount = 0;//获取出现柜的组中位数
    	    					 var tempCabinetsX = 0;//获取到出现柜的下宽度
    	          		         var tempCabinetsY = 0;//获取到出现柜的下高
    	          		         var tempCabinetsLineX = 0;//获取到出现柜的上宽度
    	          		         var tempCabinetsLineY = 0;//获取到出现柜的上高
	 	    					//出线柜循环 -begin
	 	    					if(null != cabinetsList && cabinetsList.length > 0){	
	 	    						tempCabinetsCount = (cabinetsList.length-1) / 2;
	 	    						var jCountTempX = 115;//table相对X
	 	    						var jCountTempY = 0;//table相对y
	 	    						for(var j= 0; j < cabinetsList.length; j++){
	 	    							var j_json = cabinetsList[j];
	 	    	    					var j_epuParentId = j_json["rowId"];
	 	    							var branchBoxList  = new Array();//分支箱
	 	    	    					getNextData("M0003",j_epuParentId,data,branchBoxList);
	 	    	    					//分支箱循环-begin
	 	    	    					var cabinetsX_branchBoxX = 0;//计算合并后的具体位置值
	 	    	    					var cabinetsY_branchBoxY = 0;//计算合并后的具体位置值
	 	    	    					
	 	    	    					 var tempCount = 0;//获取分线箱的组中位数
	 	    	    					 var tempBranchBoxX = 0;//获取到分线箱的下宽度
	 	    	          		         var tempBranchBoxY = 0;//获取到分线箱的下高
	 	    	          		         var tempBranchBoxLineX = 0;//获取到分线箱的上宽度
	 	    	          		         var tempBranchBoxLineY = 0;//获取到分线箱的上高
	 	    	    					if(null != branchBoxList && branchBoxList.length > 0){
	 	    	    						tempCount = (branchBoxList.length-1) / 2;
	 	    	    						for(var z = 0; z < branchBoxList.length; z++){
	 	    	    	    					var z_json = branchBoxList[z];
	 	    	    	    					var z_epuParentId = z_json["rowId"];
	 	    	    	    					 var z_epuStatus = z_json["epuStatus"];
	 	    	    	    					 var tableBoxList  = new Array();//表箱
	 	    	    	    					getNextData("M0004",z_epuParentId,data,tableBoxList);
	 	    	    	    					//表箱循环-begin
	 	    	    	    					if(null != tableBoxList && tableBoxList.length > 0){//有表箱集合的
	 		    	    	    					for(var x= 0; x < tableBoxList.length; x ++){
	 		    	    	    						var x_json = tableBoxList[x];
	 		    	    	    						var x_rowId = x_json["rowId"];
	 		    	    	    						//展示表箱
	 		    		        			 			ammeterX = ammeterX + gird;
	 		    		 	    						setCreateUseEl(layerSnap,"id" + x_rowId, "TableBox",ammeterX,ammeterY);
	 		    		 	    						 var txtKey = (z_epuParentId +"_" + x_rowId);
		 		    		    		        		 splitRemarks(layerSnap,"idTitle" + txtKey,"表箱",ammeterX + 50,ammeterY + 37,"fText",16);
		 		    		    		        		//给表箱绑定单击事件
		 		    		    		        		$("#idTitle" + txtKey).attr("epuName",x_json["epuName"]);
		 		    		    		        			$("#idTitle" + txtKey).bind("click",function(){
		 		    	    	    							  var txtID = $(this).attr("id");//展示的文字ID
		 		    	    	    							  txtID = txtID.replace("idTxt","");
		 		    	    	    							  txtID = txtID.split("_")[1];//获取表箱ID
		 		    	    	    							  parent.$("#tableBoxId").val(txtID.replace("idTxt",""));//当前表箱ID
		 		    	    	    							  var textValue = $(this).attr("epuName");//展示的文字内容
		 		    	    	    							  parent.$("#tableBoxName").html(textValue + "单线图");//TAB
		 		    	    	    							  
		 		    	    	    							  var rowId = parent.$("#rowId").val();//获取箱变根ID
		 		    	    	    				              var iframeID  = parent.$("#tab3Iframe")[0];//获取iframe的ID
		 		    	    	    				              var tableBoxId = parent.$("#tableBoxId").val();//获取箱变根ID
		 		    	    	    				              //只有电表TAB可以执行此动作
			    	    	    				            	  iframeID.contentWindow.showTop(rowId,tableBoxId);
			    	    	    				            	  parent.$("#messageAmmeter").show();
		 		    	    	    						});
		 		    	    	    						//表箱分割备注
		 		    	    		    		        	splitRemarks(layerSnap,"tableBoxID","表箱",45,(ammeterY + 40),"fText",20);
		 		    	    		    		        	 createLineEl(layerSnap, {
			 						    		        			id :"idLine" + j_epuParentId,
			 						    		        			dash:"true"
			 						    		        		}, {
			 						    		        			x: 4000,//下宽度
			 						    		        			y: ammeterY + 200,//下高
			 						    		        			x2: 0,//上宽度
			 						    		        			y2: ammeterY + 200,//上高
			 						    		        			scale: 1
			 						    		        		});
		 		    		    		        		 //引入表箱与分支箱线
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
	 		    		    		        			 //展示分支箱图形（正常）
	 		    		 	    						 branchBoxX = ammeterX;
	 		    		 	    		        		 branchBoxY = ammeterY- branchBoxDifference;
	 		    		 	    		        		 setCreateUseEl(layerSnap,"branchBoxid" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	 		    		 	    		        		  //分支箱分割备注
	 		    		 	    		        		 splitRemarks(layerSnap,"branchBoxID","分支箱",65,(branchBoxY + 40),"fText",20);
	 		    		 	    		        		 createLineEl(layerSnap, {
	 						    		        			id :"idLine" + j_epuParentId,
	 						    		        			dash:"true"
	 						    		        		}, {
	 						    		        			x: 4000,//下宽度
	 						    		        			y: branchBoxY +70,//下高
	 						    		        			x2: 0,//上宽度
	 						    		        			y2: branchBoxY+70,//上高
	 						    		        			scale: 1
	 						    		        		});
	 		    		 	    		        		 //合并分支箱
	 		    		 		    		        	 branchBoxLineX = branchBoxX + 32;//下宽度
	 		    		 		    		        	 branchBoxLineY = branchBoxY + 22;//下高
	 		    		 		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
	 		    		 		    		        	 branchBoxLineY2 = branchBoxY - 80;//上高
	 		    		 		    		        	 if (!mergeBranchBoxXAll) {
	 		    		 		    		        		 cabinetsX_branchBoxX = branchBoxX;//计算合并后的具体位置值
	 		    		 		    		       			 cabinetsY_branchBoxY = branchBoxY;//计算合并后的具体位置值
	 		    		     		        				 mergeBranchBoxXAll = branchBoxLineX + (tableBoxList.length -1) * gird / 2;
	 		    		     		        			 }
	 		    		     		        			 pos={
	 		    		  		    		        			x: mergeBranchBoxXAll,//下宽度
	 		    		  		    		        			y: branchBoxLineY2,//下高
	 		    		  		    		        			x2: branchBoxLineX,//上宽度
	 		    		  		    		        			y2: branchBoxLineY,//上高
	 		    		  		    		        			scale: 1
	 		    		  		    		        		};
	 		    		     		        			 setPos(layerSnap,pos);
	 		    		     		        			if(branchBoxList.length == 1){
	 		    		     		        				  tempBranchBoxX = branchBoxLineX - 32 ;//下宽度
		 		    		   		          		          tempBranchBoxY = branchBoxLineY;//下高
		 		    		   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
		 		    		   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	 		    		     		        			}else if(tempCount >= z && tempCount < ( z + 1)){
		 		    		   		        				  tempBranchBoxX = branchBoxLineX + 20;//下宽度
		 		    		   		          		          tempBranchBoxY = branchBoxLineY;//下高
		 		    		   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
		 		    		   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
		 		    		     		        		}
	 		    	    	    					}
	 	    	    	    					}else{
	 	    	    	    						//分支箱没有循环的-begin
//	 	    	    	    						alert("表箱");
	 	    	    	    						//展示表箱
 		    		        			 			ammeterX = ammeterX + gird;
 		    		 	    						 var txtKey = (z_epuParentId +"_");
	 		    		    		        		 //引入表箱与分支箱线
 		    		    		        			 createLineEl(layerSnap, {
 		    				    		        			id :"idLine" + txtKey,
 		    				    		        			type: "TableBox"
 		    				    		        		}, {
 		    				    		        			x: ammeterX + 33,//下宽度
 		    				    		        			y: ammeterY + 13,//下高
 		    				    		        			x2: ammeterX + 32,//上宽度
 		    				    		        			y2: ammeterY - 58,//上高
 		    				    		        			scale: 1
 		    				    		        		});
 		    		    		        			 //展示分支箱图形（正常）
 		    		 	    						 branchBoxX = ammeterX;
 		    		 	    		        		 branchBoxY = ammeterY- branchBoxDifference;
 		    		 	    		        		 setCreateUseEl(layerSnap,"branchBoxid" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
 		    		 	    		        		 //合并分支箱
 		    		 		    		        	 branchBoxLineX = branchBoxX + 32;//下宽度
 		    		 		    		        	 branchBoxLineY = branchBoxY + 22;//下高
 		    		 		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
 		    		 		    		        	 branchBoxLineY2 = branchBoxY - 80;//上高
 		    		 		    		        	 if (!mergeBranchBoxXAll) {
 		    		 		    		        		 cabinetsX_branchBoxX = branchBoxX;//计算合并后的具体位置值
 		    		 		    		       			 cabinetsY_branchBoxY = branchBoxY;//计算合并后的具体位置值
 		    		     		        				 mergeBranchBoxXAll = branchBoxLineX;
 		    		     		        			 }
 		    		     		        			 pos={
 		    		  		    		        			x: mergeBranchBoxXAll,//下宽度
 		    		  		    		        			y: branchBoxLineY2,//下高
 		    		  		    		        			x2: branchBoxLineX,//上宽度
 		    		  		    		        			y2: branchBoxLineY,//上高
 		    		  		    		        			scale: 1
 		    		  		    		        		};
 		    		     		        			 setPos(layerSnap,pos);
	    		     		        				  tempBranchBoxX = branchBoxLineX - 32 ;//下宽度
		    		   		          		          tempBranchBoxY = branchBoxLineY;//下高
		    		   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
		    		   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	 	    	    	    					}
	 	    	    	    					//表箱循环-end
	 	    	    						}
	 	    	    						mergeBranchBoxXAll = null;//只有一组的时候才合并
	 	    	    					}
	 	    	    					//分支箱循环-end
	 	    	    					else{
	 	    	    						//分支箱没有循环的-begin
//	 	    	    						alert("分支箱");
	 	    	    						//展示表箱
	    		        			 			ammeterX = ammeterX + gird;
	    		 	    						 var txtKey = (z_epuParentId +"_");
		    		    		        		 //引入表箱与分支箱线
//	    		    		        			 createLineEl(layerSnap, {
//	    				    		        			id :"idLine" + txtKey,
//	    				    		        			type: "TableBox"
//	    				    		        		}, {
//	    				    		        			x: ammeterX + 33,//下宽度
//	    				    		        			y: ammeterY + 13,//下高
//	    				    		        			x2: ammeterX + 32,//上宽度
//	    				    		        			y2: ammeterY - 58,//上高
//	    				    		        			scale: 1
//	    				    		        		});
	    		    		        			 //展示分支箱图形（正常）
	    		 	    						 branchBoxX = ammeterX;
	    		 	    		        		 branchBoxY = ammeterY - branchBoxDifference;
//	    		 	    		        		 setCreateUseEl(layerSnap,"branchBoxid" + z_epuParentId, "LoadBreakSwitch",branchBoxX,branchBoxY);
	    		 	    		        		 //合并分支箱
	    		 		    		        	 branchBoxLineX = branchBoxX + 32;//下宽度
	    		 		    		        	 branchBoxLineY = branchBoxY + 22;//下高
	    		 		    		        	 branchBoxLineX2 = branchBoxX + 32;//上宽度
	    		 		    		        	 branchBoxLineY2 = branchBoxY - 100;//上高
	    		 		    		        	 if (!mergeBranchBoxXAll) {
	    		 		    		        		 cabinetsX_branchBoxX = branchBoxX;//计算合并后的具体位置值
	    		 		    		       			 cabinetsY_branchBoxY = branchBoxY;//计算合并后的具体位置值
	    		     		        			 }
	    		     		        			 pos={
	    		  		    		        			x: branchBoxLineX,//下宽度
	    		  		    		        			y: branchBoxLineY2,//下高
	    		  		    		        			x2: branchBoxLineX,//上宽度
	    		  		    		        			y2: branchBoxLineY,//上高
	    		  		    		        			scale: 1
	    		  		    		        		};
//	    		     		        			 setPos(layerSnap,pos);
		     		        				  tempBranchBoxX = branchBoxLineX - 32 ;//下宽度
    		   		          		          tempBranchBoxY = branchBoxLineY;//下高
    		   		          		          tempBranchBoxLineX = branchBoxLineX2;//上宽度
    		   		          		          tempBranchBoxLineY = branchBoxLineY2;///上高
	 	    	    						//分支箱没有循环的-end
	 	    	    					}
	 	    	    					cabinetsX = tempBranchBoxX;
	 	    		    		        cabinetsY = cabinetsY_branchBoxY - cabinetsDifference ;
//	 	    		    		        alert(cabinetsList.length+"=="+tempBranchBoxX+"==="+cabinetsY)
	 	    		    		       //出线柜
	 	    		    		        setCreateUseEl(layerSnap,"id" + j_epuParentId, "LoadBreakSwitchRed",cabinetsX,cabinetsY);
	 	    		    		       //table
	 	    		    		       jCountTempX = jCountTempX - 30;
	 	    		    		      jCountTempY = jCountTempY - 10;
	 	    		    		        if(j % 2 == 0){
	    	    	    		         setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX - jCountTempX,cabinetsY+jCountTempY);
	 	    		    		        }else{
	 	    		    		        	setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX-jCountTempX,cabinetsY + 115);
	 	    		    		        }
	    	 	    		        	//出线柜分割备注
	    	 	    		        	splitRemarks(layerSnap,"cabinetsID","出线柜",65,(cabinetsY+40),"fText",20);
	    	 	    		        	 createLineEl(layerSnap, {
				    		        			id :"idLine" + j_epuParentId,
				    		        			dash:"true"
				    		        		}, {
				    		        			x: 4000,//下宽度
				    		        			y: cabinetsY + 100,//下高
				    		        			x2: 0,//上宽度
				    		        			y2: cabinetsY + 100,//上高
				    		        			scale: 1
				    		        		});
	 	    		    		        //合并出线柜
	 	    		    		        branchBoxLineX = cabinetsX + 32;//下宽度
	 	    		    		        branchBoxLineY = cabinetsY + 22;//下高
	 	    		    		        branchBoxLineX2 = cabinetsX + 32;//上宽度
	 	    		    		        branchBoxLineY2 = cabinetsY - 80;//上高
 		 		    		        	 if (!mergeCabinetsXAll) {
 		 		    		        		mergeCabinetsXAll = branchBoxLineX + (cabinetsList.length -1) * gird / 2;
 		     		        			 }
 		     		        			 pos={
 		  		    		        			x: mergeCabinetsXAll,//下宽度
 		  		    		        			y: branchBoxLineY2,//下高
 		  		    		        			x2: branchBoxLineX,//上宽度
 		  		    		        			y2: branchBoxLineY,//上高
 		  		    		        			scale: 1
 		  		    		        		};
 		     		        			 setPos(layerSnap,pos);
		 	    		    		   	if(cabinetsList.length == 1){
		 	    		    		   		tempCabinetsX = branchBoxLineX;//下宽度
		 	    		    		   		tempCabinetsY = branchBoxLineY;//下高
		 	    		    		   		tempCabinetsLineX = branchBoxLineX2;//上宽度
		 	    		    		   		tempCabinetsLineY = branchBoxLineY2;///上高
		     		        			}else if(tempCabinetsCount >= j && tempCabinetsCount < ( j + 1)){
	     		        					tempCabinetsX = branchBoxLineX + 20;//下宽度
	     		        					tempCabinetsY = branchBoxLineY;//下高
	     		        					tempCabinetsLineX = branchBoxLineX2;//上宽度
	     		        					tempCabinetsLineY = branchBoxLineY2;///上高
			     		        		}
		 	    		    		   	
 	    	 	    		        	//出线柜往下画线
 	    	 	    		        	var lowerCabinetsLineX = cabinetsX + 32;//下宽度（出线柜下处宽度）
 	    	 	    		        	var lowerCabinetsLineY = cabinetsY + 50;//下高（分线柜下处高度）
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
 	    	 	    		        	  
 	    	 	    		        	 if(branchBoxList.length > 0){//分线箱下面有表箱(有表箱，表箱与分纤箱一对一)的执行如下：
 	    	 	    		        		var lowerBranchBoxX = lowerCabinetsLineX;//下宽度
 	    	 	    		        		var lowerBranchBoxY = tempBranchBoxLineY;//下高
 	    	 	    		        		 createLineEl(layerSnap, {
 					    		        			id :"idLines" + j_epuParentId,
 					    		        			type: "TableBox"
 					    		        		}, {
 	    	 	    		        			x: lowerBranchBoxX,//下宽度 (分线箱上处宽度)
	     		    		        			y: lowerBranchBoxY,//下高(分线箱上处高度)
	     		    		        			x2: lowerCabinetsLineX,//上宽度
	     		    		        			y2: lowerCabinetsLineY,//上高
 					    		        			scale: 1
 					    		        		});
 	    	 	    		        	 }
		 	    					}
	 	    					}else{
	 	    						tempCabinetsX = ammeterX;
	 	    						cabinetsY_branchBoxY = ammeterY;
	 	    						//没有循环的出线柜
//	 	    						alert("出线柜");
	 	    						cabinetsX = tempCabinetsX-32;
 	    		    		        cabinetsY = cabinetsY_branchBoxY  ;
 	    		    		       //出线柜
 	    		    		        setCreateUseEl(layerSnap,"id" + j_epuParentId, "LoadBreakSwitchRed",cabinetsX,cabinetsY);
// 	    		    		       //table
 	    		    		       if(j % 2 == 0){
    	    	    		         setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX,cabinetsY);
 	    		    		        }else{
 	    		    		        	setCabinetsXTable(layerSnap,j_epuParentId,cabinetsX,cabinetsY + 115);
 	    		    		        }
    	 	    		        	//出线柜分割备注
    	 	    		        	splitRemarks(layerSnap,"cabinetsID","出线柜",65,(cabinetsY+40),"fText",20);
    	 	    		        	 createLineEl(layerSnap, {
			    		        			id :"idLine" + j_epuParentId,
			    		        			dash:"true"
			    		        		}, {
			    		        			x: 4000,//下宽度
			    		        			y: cabinetsY +70,//下高
			    		        			x2: 0,//上宽度
			    		        			y2: cabinetsY+70,//上高
			    		        			scale: 1
			    		        		});
 	    		    		        //合并出线柜
 	    		    		        branchBoxLineX = cabinetsX + 32;//下宽度
 	    		    		        branchBoxLineY = cabinetsY + 22;//下高
 	    		    		        branchBoxLineX2 = cabinetsX + 32;//上宽度
 	    		    		        branchBoxLineY2 = cabinetsY - 80;//上高
		 		    		        	 if (!mergeCabinetsXAll) {
//		 		    		        		mergeCabinetsXAll = branchBoxLineX + (cabinetsList.length -1) * gird / 2;
		     		        			 }
		     		        			 pos={
		  		    		        			x: branchBoxLineX,//下宽度
		  		    		        			y: branchBoxLineY2,//下高
		  		    		        			x2: branchBoxLineX,//上宽度
		  		    		        			y2: branchBoxLineY,//上高
		  		    		        			scale: 1
		  		    		        		};
		     		        			 setPos(layerSnap,pos);
	 	    					}
	 	    					//出线柜循环-end
	 	    					mergeCabinetsXAll = null;//只有一组的时候才合并
	 	    					var rootX = tempCabinetsX;
	    		    		    var rootY = branchBoxLineY-145;
	    		    		    createLineEl(layerSnap, {
		    		        			id :"lowerTempID" + i_epuParentId,
		    		        			type: "TableBox"
		    		        		}, {
		    		        			x: rootX,//下宽度
		    		        			y: rootY,//下高
		    		        			x2: rootX,//上宽度
		    		        			y2: rootY+45,//上高
		    		        			scale: 1
		    		        		});
	    		    		       //箱变与出线柜之间图形
	    		    		        setCreateUseEl(layerSnap,"rootTempId" + i_epuParentId, "LoadBreakSwitch",rootX-32,rootY-42);
		    		    		    createLineEl(layerSnap, {
		    		        			id :"lowerTempLineID" + i_epuParentId,
		    		        			type: "TableBox"
		    		        		}, {
		    		        			x: rootX,//下宽度
		    		        			y: rootY - 20,//下高
		    		        			x2: rootX,//上宽度
		    		        			y2: rootY- 100,//上高
		    		        			scale: 1
		    		        		});
		    		    		    //箱变
		    		    		    setCreateUseEl(layerSnap,"id" + i_epuParentId, "EnergyConsumer",rootX-32,rootY-155);
		    		    		   //箱变分割备注
	 	    						splitRemarks(layerSnap,"rootID","箱变",45,(rootY-155),"fText",20);
	 	    						 createLineEl(layerSnap, {
			    		        			id :"idLine" + i_epuParentId,
			    		        			dash:"true"
			    		        		}, {
			    		        			x: 4000,//下宽度
			    		        			y: rootY - 80,//下高
			    		        			x2: 0,//上宽度
			    		        			y2: rootY- 80,//上高
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

