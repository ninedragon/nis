
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
					//给表箱绑定单击事件
		        	$("#meterbox_" + this.rowId).attr("epuName",this.epuName);
		        	$("#meterbox_" + this.rowId).bind("click",function(){
						  var txtID = $(this).attr("id");//展示的文字ID
						  parent.$("#tableBoxId").val(txtID.replace("meterbox_",""));//当前表箱ID
						  var textValue = $(this).attr("epuName");//展示的文字内容
						  parent.$("#tableBoxName").text(textValue + "单线图");//TAB
						  var rowId = parent.$("#rowId").val();//获取箱变根ID
			              var iframeID  = parent.$("#tab3Iframe")[0];//获取iframe的ID
			              var tableBoxId = parent.$("#tableBoxId").val();//获取箱变根ID
			              //只有电表TAB可以执行此动作
			              parent.$("#messageAmmeter").show();
		            	  iframeID.contentWindow.showTop(svgModelData,rowId,tableBoxId);
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


function createMeterBox(layer, id, x, y, name) {
	var g = layer.append("g").attr("id", "meterbox_" + id);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x).attr("y", y).attr("width", 90).attr("height", 90).attr("id", "meterbox_rect_" + id);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 20).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 20).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 20).attr("width", 10).attr("height", 10);

	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 40).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 40).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 40).attr("width", 10).attr("height", 10);
	
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 20).attr("y", y + 60).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 40).attr("y", y + 60).attr("width", 10).attr("height", 10);
	g.append('rect').attr("stroke-width", 1).attr("stroke", "#000").attr("fill","none").attr("x", x + 60).attr("y", y + 60).attr("width", 10).attr("height", 10);
	
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

return {
	drawSvg : drawSvg
}
})();