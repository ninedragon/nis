//var mySvg = SVG_HELPER.drawSvg(allData, 'body');


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
var mySvg = null;
var scaleZoom = 1;
var data = null;
/**
 * 展示拓扑
 * **/
function showTop(rowId){
	if(null != rowId && "" != rowId){
		$.ajax({ 
			 type: "post",
	         url:  getRootPath_web() + "/epu/getEupInfosTree.shtml",
	         data: {
	        	 rootId: rowId
	         },
	         async:false,
	         dataType: "json",
	         cache: false,
	         success: function(allData){ 
	        	 if(allData){
	        		 mySvg = SVG_HELPER.drawSvg(allData, 'body');
	        		 data = allData;
	        		 /**
	        		 以下方法 参数 都是 ID
	        		 boxError: 出线柜/分支箱  整体状态 标红, 
	        		 boxWarning: 出线柜/分支箱  整体状态 标蓝,
	        		 boxClear: 出线柜/分支箱  整体状态 恢复,
	        		 kaiguanxianError: 开关线 标红,
	        		 kaiguanxianWarning: 开关线 标蓝,
	        		 kaiguanxianClear: 开关线 恢复
	        		 **/
	        		 var intervalObj = setInterval(function(){
	        		 	if(mySvg){
	        		 		mySvg.kaiguanxianError("0ce0ccf1-8049-4572-9ac3-709ad695cbf4");//表箱ID
	        		 		mySvg.boxError("92f47bd1-649e-402c-91e8-c74301905edd");//出线柜ID
	        		 	}
	        		 },5000);//5秒
	        	 }
	        } 
		});
	}
}

/**
* 单击执行放大缩小
**/
function clickScale(param){
	scaleZoom = scaleZoom || 1;
	if(param == "max"){
		if(scaleZoom < 0.9){
			scaleZoom = scaleZoom + 0.1;
			mySvg.scale(scaleZoom);
		}else if(scaleZoom >= 0.9){
			 mySvg = SVG_HELPER.drawSvg(data, 'body');
		}
	}else if(param == "min"){
		if(scaleZoom > 0.5){
			scaleZoom = scaleZoom - 0.1;
			mySvg.scale(scaleZoom);
		}
	}
}

