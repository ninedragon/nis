
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

//换种方式获取，之前的方式在不同的环境下，有问题
var baseUrl = $("script[baseUrl]").attr('baseUrl');
baseUrl = baseUrl || getRootPath_web();
/**退出*/
function logout(){
	var load = layer.load();
	$.getJSON(baseUrl + '/u/logout.shtml',{},function(result){
		layer.close(load);
		if(result && result.status == 200){
			$(".qqlogin").html('').next('ul').remove();
			layer.msg('退出成功');
			window.location.reload(true);
			return !1;
		}else{
			layer.msg('退出失败，重试！');
		}
	});
}
