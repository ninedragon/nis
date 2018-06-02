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
var dataTemp = null;
/**
 * 展示拓扑
 * **/
function showTop(rowId){
	if(null != rowId && "" != rowId){
		parent.$(".loading").show();//显示蒙层
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
	        	 parent.$(".loading").hide();//隐藏蒙层
	        	 if(allData){
	        		 mySvg = SVG_HELPER.drawSvg(allData, 'body');
	        		 dataTemp = allData;
	        		 var wd = parseFloat($("#wd").val() || 1) ;
	        		 mySvg.scale(wd);
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

var obj =  parent.$(".all li[class='on']");
var rowId = obj.attr("id").replace("tab_","");
if(obj.attr("isShow") != "yes"){//如果是第一次，则加载
	obj.attr("isShow","yes");
	showTop(rowId);//初始化加载
}


/**
* 单击执行放大缩小
**/
function clickScale(param){
	var wd = parseFloat($("#wd").val()) || 1;
	if(param == "max"){
		if(wd < 1){
			wd = wd + 0.1;
			mySvg.scale(wd);
		}
	}else if(param == "min"){
		if(wd > 0.2){
			wd = wd - 0.1;
			mySvg.scale(wd);
		}
	}
}


$(function() {
	  //绑定事件
	var obj =  parent.$(".all li[class='on']");
	var rowId = obj.attr("id").replace("tab_","");
	parent.$("#" + rowId + "tabShow").scroll(function(){
	 	    $(".gj").css("top", ($(this).scrollTop() ));
    		$(".gj").css("left", ($(this).scrollLeft() ));
	 });
});