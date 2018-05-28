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
<!-- <html> -->
  <head>
    <base href="<%=basePath%>">
    <title>V2-设备信息列表</title>          
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link   rel="icon" href="<%=basePath%>/favicon.ico" type="image/x-icon" />
	<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
	<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
	<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/woodare/css/comm.css" />
		<script src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
	<script src="<%=basePath%>/woodare/js/menu.js"></script>
	<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
	<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script  src="<%=basePath%>/js/shiro.demo.js"></script>
	<link rel="stylesheet" href="<%=basePath%>/css/zTreeStyle/zTreeStyle.css" type="text/css" />	
		<script type="text/javascript" src="<%=basePath%>/woodare/js/jquery.ztree.core.min.js"></script>
        	<style type="text/css">  
            body{  
                margin:0;  
                padding:0;  
                overflow: hidden;  
                }  
        </style>
         <script type="text/javascript">         
	        $(function(){  
	            changeWH();  
	        });  
	  
	    function changeWH(){    
	        $("#tab1Iframe").height($(document).height());  
	        $("#tab1Iframe").width($(document).width());  
	    } ;  
    	window.onresize=function(){ 
         changeWH();     
    		};
      </script>   
	<script type="text/javascript" src="<%=basePath%>/woodare/js/jquery.ztree.core.min.js"></script>
	 <style type="text/css">  
	 	.actions {
    position: fixed;
    background: rgba(0,0,0,0.5);
    padding: 8px 20px;
    color: #FFF;
    border-radius: 8px;
    top: 20%;
    left: 23%;
	font-size: 18px;
	display: none;
}

.actions a {
    color: #FFF;
	display:block;
	margin: 4px;
}
.actions a:hover {
    color: red;
}
	  </style>
  <script >
  function addNode(event, treeId, treeNode, clickFlag) {
    var zTree = $.fn.zTree.getZTreeObj("treeNone");
    var type = treeNode.type;
    if (treeNode.isParent  && typeof (treeNode.children) == "undefined")
     {
         var parameter = 
         {
            pId : treeNode.id,
            pName:treeNode.name
        };
        if (type == 0) {
            $.post("<%=basePath%>/epu/showCity.shtml", parameter, function(data) {
                zTree.addNodes(treeNode, data);
            });
        }
        if (type == 1) {
            $.post("<%=basePath%>/epu/showCounty.shtml", parameter, function(data) {
                zTree.addNodes(treeNode, data);
               
            });
       
        }
         if (type == 2) {
            $.post("<%=basePath%>/epu/showEpuInfo.shtml", parameter, function(data) {
                zTree.addNodes(treeNode, data);
            });       
        }
       
    }
   /*   if (type == 1) {
           $("#cityName").val(treeNode.name);
		   $("#epuCity").val(treeNode.id);
		    $("#epuDistrict").val("");
		    $("#rowId").val("");
			var tabId = $(".tab-nav li[view='show']").attr("id");
	         $("#" + tabId + "Iframe")[0].contentWindow.location.reload(true);
        }
         if (type == 2) {
           $("#cityName").val(treeNode.pName);
           $("#epuCity").val(treeNode.pId);
            $("#epuDistrict").val(treeNode.id);
           $("#rowId").val("");
	       	var tabId = $(".tab-nav li[view='show']").attr("id");
	        $("#" + tabId + "Iframe")[0].contentWindow.location.reload(true);    
        }
     */
      if (type == 3) {
		   $("#cityName").val("");
           $("#epuCity").val("");
           $("#epuDistrict").val("");
           $("#rowId").val(treeNode.id);
           $("#xbName").html(treeNode.name);
           
           var tabId = $(".tab-nav li[view='show']").attr("id");
           var iframeID  = $("#" + tabId + "Iframe")[0];
           if(tabId == "tab2" || tabId == "tab3"){
        	   clickIframe();//刷新右侧箱变
           }else{
        	   iframeID.contentWindow.location.reload(true);    
           }
        }
}
  	var menu = {
	    setting : {
	        data : {
	            simpleData : {
	                enable : true
	            }
	        },
	        keep : {
	            parent : true
	        },
	        /*
	         * view : { dblClickExpand : false },
	         */
	        callback : { // 回调函数
	            onExpand : addNode,
	            onClick : addNode
	        }
	    },
	 
	    loadMenuTree : function() {
	        $.post("<%=basePath%>/epu/showProvince.shtml", null, function(data) {
            $.fn.zTree.init($("#treeNone"), menu.setting, data);
        });
	    }
	};
	
			so.init(function(){
	         menu.loadMenuTree();
				
			});

		</script>
		<script type="text/javascript">  
            var tabClick = function(v) {  
                var llis = $('.data-bar li');  
                for(var i = 1; i <= llis.length; i++) {  
                	if(i == v){
                		$("#tab" + i ).css("background-color","orange");
						$("#tab" + i ).attr("view","show");
                		$("#tab" + i + "_content").css("display","block");
                	}else{
                		$("#tab" + i ).attr("view","none");
                		$("#tab" + i ).css("background-color","white");
                		$("#tab" + i + "_content").css("display","none");
                	}
                }
                if(v == 2 || v == 3){//只有箱变和电表TAB可以执行此动作
            		$(".actions").show();
            		clickIframe();//刷新右侧
            	}
            }  
           /**
           *刷新右侧箱变
           **/
          function clickIframe(){
        	  var rowId = $("#rowId").val();//获取箱变根ID
              var tabId = $(".tab-nav li[view='show']").attr("id");//获取TAB的ID
              var iframeID  = $("#" + tabId + "Iframe")[0];//获取iframe的ID
              if(tabId == "tab2"){//只有箱变和电表TAB可以执行此动作
           	   	  iframeID.contentWindow.showTop(rowId);
              }else if( tabId == "tab3"){//只有电表TAB可以执行此动作
            	  var tableBoxId = $("#tableBoxId").val();//获取箱变根ID
            	  iframeID.contentWindow.showTop(rowId,tableBoxId);
              }
          }
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

<!--主体开始-->
 <input type="hidden" id="tableBoxId" name="tableBoxId"  value=""/>
<div class="wapp-main">
	<h4>实时监控展现</h4>
    <form method="post" action="" id="formId" class="form-inline">
        <input type="hidden" id="rowId" name="rowId"  value=""/>
        <input type="hidden" id="epuCity" name="epuCity"  value=""/>
        <input type="hidden" id="cityName" name="cityName"  value=""/>
        <input type="hidden" id="epuDistrict" name="epuDistrict"  value=""/>
    </form>
    <!--实时监控开始-->
    <div class="date-mode">
        <!--树结构开始-->
        <div class="tree-box ztree" id="treeNone">

        </div>
        <!--树结构结束/-->
        
        <!--动态数据开始-->
        <div class="data-bar">
            <ul class="tab-nav">
                <li  id="tab1"  onclick="tabClick(1)" style="background-color: orange" view="show" >地图总览</li>                
                <li  id="tab2" onclick="tabClick(2)" view="none"><div id='xbName'>箱变名称</div></li>
<!--                 <li  id="tab3" onclick="tabClick(3)" view="none"><div id='tableBoxName'>表箱单线图</div></li> -->
            </ul>
            <div class="box" id="tabShow">         
	            <div class="tab_css" id="tab1_content" style="display: block">  
	               <iframe  id="tab1Iframe" src="<%=basePath%>/html/showMapMark.html" frameborder="0" scrolling="no"></iframe> 
	            </div>  
	            <div class="tab_css" id="tab2_content"  style="display: none;">  
	                 <iframe id="tab2Iframe" src="<%=basePath%>/html/topologyHtml.html" width="4000" height="4000" frameborder="0" scrolling="no"></iframe>
	            </div>  
<!-- 	            <div class="tab_css" id="tab3_content" style="display: none;">   -->
<%-- 	                <iframe id="tab3Iframe" src="<%=basePath%>/html/ammeter.html" width="4000" height="4000" frameborder="0" scrolling="no"></iframe> --%>
<!-- 	            </div>                     -->
            </div>
        </div>
        <!--动态数据结束/-->
    </div>
    <!--实时监控结束/-->
</div>
<!--主体结束/-->
</body>
<!--弹层开始-->
<div class="wapp-layer"  id="messageAmmeter" >
	<div class="box tips">
    	<h4><label id='tableBoxName'></label><span class="close-js" onclick="$('#messageAmmeter').hide();">关闭</span></h4>
        <div class="edit">
            <p><sapn id="statusSpan"></sapn></p>
			<iframe id="tab3Iframe" src="<%=basePath%>/html/ammeter.html" width="4000" height="4000" frameborder="0" scrolling="no"></iframe>
            <div class="but-nav">
                <span class="but" onclick="updatestatus();">确&nbsp;&nbsp;定</span>
                <span class="but miss close-js" onclick="$('#messageAmmeter').hide();">取&nbsp;&nbsp;消</span>
            </div>
        </div>
    </div>
</div>
<!--弹层结束/-->
</html>

<!-- 	<div class="actions"> -->
<!-- 		<label style="color: RED;">红色图标表示汇总负荷超过线柜负荷15%</label><br/> -->
<!-- 		<label style="color: blue;">蓝色图标表示汇总低于出线负荷15%</label><br/> -->
<!-- 		<label >白色图标表示正常情况</label><br/> -->
<!-- 		<label>&nbsp;</label><br/> -->
<!-- 		<label style="font-size: 14px;color:#000000;">说明：</label><br/> -->
<!-- 		<label  style="font-size: 14px;color:#000000;">电压单位V;</label><br/> -->
<!-- 		<label   style="font-size: 14px;color:#000000;">电流单位A;</label><br/> -->
<!-- 		<label   style="font-size: 14px;color:#000000;">功率单位KW;</label><br/> -->
<!-- 	</div> -->
  </body>
</html>
