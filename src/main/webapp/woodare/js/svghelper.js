
var SVG_HELPER = (function() {
var iv = 10;

function drawSvg(svgModelData, el) {
	$("#Snap_Layer").remove();
	d3.namespace("xmlns:cge","http://iec.ch/TC57/2005/SVG-schema#");
	var svgSnap = d3.select(el || "body").append("svg");
	svgSnap.attr("width", 6000)
	   .attr("height", 1200)
	   .attr("xmlns", "http://www.w3.org/2000/svg")
	   .attr("xmlns:xlink", "http://www.w3.org/1999/xlink")
	   .attr("xmlns:cge", "http://iec.ch/TC57/2005/SVG-schema#");
	var layerSnap = svgSnap.html("g").attr("id","Snap_Layer");
	var startID = null;//"76c0acfe-cf97-4e5b-b966-9664bc252136";

	var list = [];
	// "M0001"
	$(svgModelData).each(function(){
		if (this.epuType == "M0001") {
			if (!startID || startID == this.rowId) {
				list.push(this);
			}
		}
	});

	$(list).each(function() {
		getChildren(this);
	});
	var w1 = 0;
	var leftPad = 300;
	var x1 = leftPad;
	var x2 = leftPad;
	var x3 = leftPad;
	var x4 = leftPad;
	$(list).each(function() {
		var w2 = 0;
		$(this.children).each(function(){
			var cids1 = [];
			var w3 = 0;
			$(this.children).each(function() {
				var cIds = [];
				var w4 = 0;
				$(this.children).each(function(){
					//M0004
					this._x = x4;
					this._y = 900;
					createMeterBox(layerSnap, this.rowId, this._x, this._y,this.epuName );
					x4 += this.width;
					w4 += this.width;
					cIds.push(this.rowId);
					 var svgimg = document.createElementNS('http://www.w3.org/2000/svg','image');
  		            svgimg.setAttributeNS(null,"height","100");
  		            svgimg.setAttributeNS(null,"width","100");
  		          svgimg.setAttributeNS(null,"cursor","pointer");
  		            svgimg.setAttributeNS("http://www.w3.org/1999/xlink","href", "../woodare/image/boxImg.png");
  		            svgimg.setAttributeNS(null,"x", (this._x - 4));
  		            svgimg.setAttributeNS(null,"y", (this._y - 6));
  		            svgimg.setAttributeNS(null,"id","meterbox_" + this.rowId);
  		            svgimg.setAttributeNS(null, "visibility", "visible");
	  		         $("#Snap_Layer").append(svgimg).find("image[id='meterbox_"+this.rowId+"']").attr("epuName",this.epuName).click(function(){
		            	  showAmmeter(this,svgModelData);
	  		         });
  		           
					//给表箱绑定单击事件
		        	$("#meterbox_" + this.rowId).attr("epuName",this.epuName).css("cursor", "pointer").bind("click",function(){
		            	  showAmmeter(this,svgModelData);
 					});
				});
				//M0003
				var tmpX = x3 + (w4 > this.width ? ((w4 - this.width) / 2) : 0);
				this._x = tmpX;
				this._y = 500;
				createBox(layerSnap, this.rowId, this._x, this._y, this.epuName, cIds);
				x3 += Math.max( this.width, w4 );
				cids1.push(this.rowId);
				x4 = Math.max(x4, x3);
				w3 += Math.max( this.width, w4 );
				// 划线
				var px = this._x;
				var py = this._y;
				var gird = 300 / (cIds.length + 1);
				var half = cIds.length / 2 
				var h = 20;
				$(this.children).each(function(index) {
					if (this._x + 45 <= px + (index + 1) * gird || index < half) {
						h = h + iv;
					} else {
						h = h - iv;
						if (h < 0) {
							h = 20;
						}
					}
					createLineEl(layerSnap, {
						x:this._x + 45,
						y:this._y,
						x2: px + (index + 1) * gird,
						y2: py + 180,
						h: h
					});
				});
				
			});
			
			var tmpX = x2 + (w3 > this.width ? ((w3 - this.width) / 2) : 0);
			//M0002
			this._x = tmpX;
			this._y = 200;
			createBox(layerSnap, this.rowId, this._x, this._y,this.epuName, cids1);
			x2 += Math.max( this.width, w3 );
			x3 = Math.max(x2, x3);
			x4 = Math.max(x4, x3);
			w2 += Math.max( this.width, w3 );
			
			var px = this._x;
			var py = this._y;
			var gird = 300 / (cids1.length + 1);
			var half = cids1.length / 2 
			var h = 20;
			var tempX = this._x;
			var tempY = this._y;
			var tempCount = $(this.children).length;
			$(this.children).each(function(index) {
				if (this._x + 150 <= px + (index + 1) * gird || index < half) {
					h = h + iv;
				} else {
					h = h - iv;
					if (h < 0) {
						h = 20;
					}
				}
				createLineEl(layerSnap, {
					x:this._x + 150,
					y:this._y,
					x2: px + (index + 1) * gird,
					y2: py + 180,
					h: h
				});
				//展示table信息
				showTabData(layerSnap,this.rowId,tempX,tempY,tempCount,index);
			});
		});
		//M0001
		var tmpX = x1 + (w2 > this.width ? ((w2 - this.width) / 2) : 0);
		this._x = tmpX;
		this._y = 0;
		createXiangbian(layerSnap, this.rowId, this._x, this._y);
		x1 += Math.max( this.width, w2 );
		x2 = Math.max(x2, x1);
		x3 = Math.max(x2, x3);
		x4 = Math.max(x4, x3);
		w1 += Math.max( this.width, w2 );
		// 划线
		var px = this._x;
		var py = this._y;
		$(this.children).each(function(index) {
			createLineEl(layerSnap, {
				x:this._x + 150,
				y:this._y,
				x2: px + 64,
				y2: py + 112,
				h: 20
			});
		});
	});
	svgSnap.attr("width", w1 + leftPad + 100);
	var rowId = parent.$(".all li[class='on']").attr("id").replace("tab_","");
	parent.$("#"+rowId+"Iframe").attr("height", svgSnap.attr("height"));//设置主体IFRAME的宽度
	parent.$("#"+rowId+"Iframe").attr("width", w1 + leftPad + 100);//设置主体IFRAME的宽度
	var wd = parseFloat($("#wd").val() || 1) ;
	if(wd < 1){
		wd = wd.toFixed(1);
	}
	$("#wd").val(wd);//文本框内容缩放级别值
	svgSnap.attr("transform","scale(" + wd + " " + wd + ") translate(0 0)");
	// 画左侧标识
	
	svgSnap.append('text').attr("font-size", "36").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)").text("箱变").attr("x", 20 ).attr("y",100);
	svgSnap.append('text').attr("font-size", "36").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)").text("出线柜").attr("x", 20 ).attr("y",300);
	svgSnap.append('text').attr("font-size", "36").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)").text("分支箱").attr("x", 20 ).attr("y",600);
	svgSnap.append('text').attr("font-size", "36").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)").text("表箱").attr("x", 20 ).attr("y",950);
	
	function getChildren(item) {
	item.children = [];
	$(svgModelData).each(function(){
		if (this.epuParentId == item.rowId) {
			var self = getChildren(this);
			item.children.push(self);
		}
	});
	if (item.epuType == 'M0004') {
		item.width = 150;
	} else if (item.epuType == 'M0003') {
		item.width = 400;
	} else if (item.epuType == 'M0002') {
		item.width = 600;
	} else {
		item.width = 100;
	}
	return item;
}
	return {
		scale: function(zoom) {
			var x = 0;
			var y = 0;
			svgSnap.attr("transform","scale(" + zoom + " " + zoom + ") translate(" + x + " " + y + ")");
			if(zoom < 1){
				zoom = zoom.toFixed(1);
			}
			$("#wd").val(zoom);//文本框内容缩放级别值
		},
		boxError: function(id) {
			updateBox(id, "error-box");
		},
		boxWarning: function(id) {
			updateBox(id, "warning-box");
		},
		boxClear: function(id) {
			updateBox(id, "");
		},
		kaiguanxianError: function(id) {
			updateKaiguanxian(id, "error");
		},
		kaiguanxianWarning: function(id) {
			updateKaiguanxian(id, "warning");
		},
		kaiguanxianClear: function(id) {
			updateKaiguanxian(id, "");
		}
	}
}

//
function updateBox(id, cls) {
	$("#chuxiangui_rect_" + id).attr("class",cls);
}

function updateKaiguanxian(id, cls) {
	$("#kaiguanxian_" + id).find("rect").attr("class",cls);
	$("#kaiguanxian_" + id).find("path").attr("class",cls);
}


function createXiangbian(layer, id, x, y) {
	var grid = 128;
	var g = layer.append("g").attr("id", id);
	var transX = 0;
	var transY = 0;
	var rotateX = x + grid / 2;
	var rotateY = y + grid / 2;
	var useage = g.append('use').attr("width", grid).attr("height", grid).attr("transform","scale(1) translate(" + transX + " " + transY + ") rotate(0 " + rotateX + " " + rotateY + ")").attr("xlink:href", "#EnergyConsumer_PD_单电源用户_2" ).attr("x", x).attr("y", y);
}

function createBox(layer, id, x, y, name, lines) {
	var g = layer.append("g").attr("id", "chuxiangui_" + id);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("stroke-dasharray","5,5").attr("fill","none").attr("x", x).attr("y", y).attr("width", 300).attr("height", 180).attr("id", "chuxiangui_rect_" + id);

	if (lines && lines.length) {
		var start = x + 180;
		var end = x;
		var gird = 300 / (lines.length + 1);
		$(lines).each(function(index, item) {
			var ix = x + gird * (index + 1) - 8;
			start = Math.min(start, ix + 8);
			end = Math.max(end, ix + 8);
			createKaiguanxian(g, item, ix, y + 30, 150);
		});
		g.append('path').attr("d", "M" + start + "," + (y + 30) + " L" + end + "," + (y + 30)).attr("stroke-width", 2).attr("stroke", "#000").attr("fill","none");
		g.append('path').attr("d", "M" + (x + 150) + "," + (y) + " L" + (x + 150)  + "," + (y + 30)).attr("stroke-width", 2).attr("stroke", "#000").attr("fill","none");
	}
	g.append('path').attr("id", "chuxiangui_text_" + id).attr("d", "M" + (x - 30) + "," + y + " L" + (x - 30) + "," + (y + 180)).attr("stroke-width", 0);
	var txt = g.append('text').attr("font-size", "20").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)");
	txt.append('textPath').attr("xlink:href","#chuxiangui_text_" + id).text(name);
}

function createKaiguanxian(layer, id, x, y, height) {
	height = height || 180;
	var g = layer.append("g").attr("id", "kaiguanxian_" + id);
	var gird = (height - 50) / 2;
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x).attr("y", y + gird).attr("width", 16).attr("height", 50);
	g.append('path').attr("stroke-width", 2).attr("stroke", "#000").attr("fill","none").attr("d", "M " + (x + 8) + "," + y + " L " + (x + 8) + "," + (y + gird) + "");
	g.append('path').attr("stroke-width", 2).attr("stroke", "#000").attr("fill","none").attr("d", "M " + (x + 8) + "," + (y + gird + 50) + " L " + (x + 8) + "," + (y + height) + "");
}

function showAmmeter(obj,svgModelData){
	  var txtID = $(obj).attr("id");//展示的文字ID
	  parent.$("#tableBoxId").val(txtID.replace("meterbox_",""));//当前表箱ID
	  var textValue = $(obj).attr("epuName");//展示的文字内容
	  parent.$("#tableBoxName").attr("title",textValue + "单线图").text(textValue + "单线图");//TAB
	  var rowId = parent.$("#rowId").val();//获取箱变根ID
      var iframeID  = parent.$("#tab3Iframe")[0];//获取iframe的ID
      var tableBoxId = parent.$("#tableBoxId").val();//获取箱变根ID
      //只有电表TAB可以执行此动作
      parent.$("#messageAmmeter").show();
	  iframeID.contentWindow.showTop(svgModelData,rowId,tableBoxId);
}
function createMeterBox(layer, id, x, y, name) {
	var g = layer.append("g").attr("id", "meterbox_" + id);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x).attr("y", y).attr("width", 90).attr("height", 90).attr("id", "meterbox_rect_" + id);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 20).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 20).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 20).attr("width", 10).attr("height", 10);
//
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 40).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 40).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 40).attr("width", 10).attr("height", 10);
//	
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 60).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 60).attr("width", 10).attr("height", 10);
//	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 60).attr("width", 10).attr("height", 10);
//	
	if (name && name.length) {
		var size = 8;
		for (var i = 0; i < name.length / size; i++) {
			g.append('text').attr("font-size", "14").attr("stroke", "rgb(0,0,0)").attr("fill","rgb(0,0,0)").text(name.substring(i*size, i*size+size)).attr("x",x ).attr("y",y + 108 + 20 * i);
		}
	}
	
}


function createLineEl(layer, position) {
//	console.log(position);
	var g = layer.append("g");
	var x = position.x;
	var y = position.y;
	var x2 = position.x2;
	var y2 = position.y2;
	var h = position.h || 0;
	var path = g.append('path').attr("stroke-width", 2).attr("stroke", "rgb(0,0,0)").attr("fill","none").attr("d", "M " + x2 + "," + (y2 + h) + " L " + x2 + "," + y2 + "");
	var path = g.append('path').attr("stroke-width", 2).attr("stroke", "rgb(0,0,0)").attr("fill","none").attr("d", "M " + x + "," + (y2 + h) + " L " + x2 + "," + (y2 + h) + "");
	var path = g.append('path').attr("stroke-width", 2).attr("stroke", "rgb(0,0,0)").attr("fill","none").attr("d", "M " + x + "," + y + " L " + x + "," + (y2 + h) + "");

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


function getSymbolByType(type) {
	var data = {
		id: "",
		x: "",
		y: ""
	};
	var id = "";
	switch(type) {
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
	var grid =64;
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
}
/*
 *展示分支箱TABLE信息 
 ***/
function showTabData(layerSnap,rowId,tempX,tempY,tempCount,index){
	if(tempCount == 1){
		setCabinetsXTable(layerSnap,rowId,tempX + 300, tempY + 200);
	}else if(tempCount == 2){
		switch((index+1)){
			case 1:
				setCabinetsXTable(layerSnap,rowId,tempX - 300, tempY + 200);
				break;
			case 2:
				setCabinetsXTable(layerSnap,rowId,tempX + 300, tempY + 200);
				break;
		}
	}else if(tempCount == 3){
		switch((index+1)){
			case 1:
				setCabinetsXTable(layerSnap,rowId,tempX - 300, tempY + 200);
				break;
			case 2:
				setCabinetsXTable(layerSnap,rowId,tempX + 10, tempY + 10);
				break;
			case 3:
				setCabinetsXTable(layerSnap,rowId,tempX + 300, tempY + 200);
				break;
		}
	}else if(tempCount == 4){
		switch((index+1)){
			case 1:
				setCabinetsXTable(layerSnap,rowId,tempX - 300, tempY + 200);
				break;
			case 2:
				setCabinetsXTable(layerSnap,rowId,tempX - 80, tempY + 10);
				break;
			case 3:
				setCabinetsXTable(layerSnap,rowId,tempX + 150, tempY + 10);
				break;
			case 4:
				setCabinetsXTable(layerSnap,rowId,tempX + 300, tempY + 200);
				break;
		}
	}else if(tempCount == 5){
		switch((index+1)){
			case 1:
				setCabinetsXTable(layerSnap,rowId,tempX - 350, tempY + 200);
				break;
			case 2:
				setCabinetsXTable(layerSnap,rowId,tempX - 190, tempY + 10);
				break;
			case 3:
				setCabinetsXTable(layerSnap,rowId,tempX + 30, tempY + 10);
				break;
			case 4:
				setCabinetsXTable(layerSnap,rowId,tempX + 250, tempY + 10);
				break;
			case 5:
				setCabinetsXTable(layerSnap,rowId,tempX + 350, tempY + 200);
				break;
		}
	}else if(tempCount == 6){
		switch((index+1)){
		case 1:
			setCabinetsXTable(layerSnap,rowId,tempX - 400, tempY + 200);
			break;
		case 2:
			setCabinetsXTable(layerSnap,rowId,tempX - 350, tempY + 10);
			break;
		case 3:
			setCabinetsXTable(layerSnap,rowId,tempX - 140, tempY + 10);
			break;
		case 4:
			setCabinetsXTable(layerSnap,rowId,tempX + 70, tempY + 10);
			break;
		case 5:
			setCabinetsXTable(layerSnap,rowId,tempX + 280, tempY + 10);
			break;
		case 6:
			setCabinetsXTable(layerSnap,rowId,tempX + 350, tempY + 200);
			break;
		}
	}
}

return {
	drawSvg : drawSvg
}
})();
