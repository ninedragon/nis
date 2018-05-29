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
    <title>V2-箱变信息列表</title>
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
	<script >
			so.init(function(){
			/* 	//全选
				so.checkBoxInit('#checkAll','[check=box]');
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return _delete(array);
				}); */
				so.initProvince();
				so.registEvent();
				 initList();
				
			});
			
			so.initProvince= function () {
			
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getProvinces.shtml",
		                data: {
		                },
		                async:false,
		                dataType: "json",
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('.search #epuProvince').html('<option value="">--请选择--</option>');
		                    
		                    for (var i = 0; i < length; i++) {
		                            $('.search #epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
	                    }
		                }
		            });
			};
			
			  so.registEvent=function registEvent() {
				  $('.search #epuProvince').change(function () {
					  var i = $('#epuProvince option:selected').val();			
				  $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getCity.shtml",
		                data: {
		                    "provinceId": i,
		                    'districtFlag': 0
		                },
		                dataType: "json",
		                async:false,
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('.search #epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('.search #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });
					$(".search #epuCity").change(
							function() {
								var i = $('.search #epuCity option:selected').val();
								// 第四级
								$.ajax({
									type : "post",
									url : "<%=basePath%>/epu/getCityDistrict.shtml",
									data : {
										"cityId" : i
									},
									dataType : "json",
									cache : false,
									error : function(a, b, c) {
									},
									success : function(a) {
										var length = a.length;
										$('.search #epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('.search #epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							});
				 
			 };
			 
			  so.editEpuInfo=function editEpuInfo(rowId) {				 
				 window.location="<%=basePath%>/epu/editInit.shtml?rowId=" + rowId;
			 };
			 so.delEpuInfo=function delEpuInfo(rowId) {				
				if(confirm('确实要删除该内容吗?')){
	   				  $("#loadingDiv").show();
	   				 $.ajax({
	   		  			    url:"<%=basePath%>/epu/delEpuInfo.shtml",
	   		  			    type:'POST',
	   		  			    dataType:'json',
	   		  			    data:{rowId:rowId,epuType:'M0001'},
	   		  			    success:function(data){
	   		  			    	if(data.error=="删除失败!"){
	   		  			    	layer.msg(data.error,function(){});
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}else{ 
	   		  			     	layer.msg("删除成功!",function(){});
	   		  					 window.location="<%=basePath%>/epu/showSubstainList.shtml";
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}
	   		  			    }
	   		  			    
	   		  			  });
	   			  }
				 

			 };
			  function initList(pageNo) {
			    	 $("#loadingDiv").show(); 

			        $.ajax({
			            url: "<%=basePath%>/epu/queryEpuList.shtml",
			            type: 'POST',
			            dataType: 'json',
			            async:false,
			            data: {			          
			            	epuProvince: $(".search #epuProvince").val(),
			            	epuCity: $(".search #epuCity").val(),
			            	epuDistrict: $(".search #epuDistrict").val(),
			            	epuType: 'M0001',
			            	epuName: $(".search #epuName").val(),
			            	districtId: $(".search #districtId").val(),
			            	pageNo:pageNo,
			            	pageSize:10
			            },
			            success: function (data) {
			            	var page=data.page;
			                if (page != null ) {
			                    var epuList = page.list;
			                   
			                    if (epuList!=null && epuList.length>0) {
			                    	 var tbody = '';
			                        for (var i = 0; i < epuList.length; i++) {
			                             var epuXscale=epuList[i].epuXscale==null?"":epuList[i].epuXscale;
			                             var epuYscale=epuList[i].epuYscale==null?"":epuList[i].epuYscale;
			                             var epuLocal=epuList[i].epuLocal==null?"":epuList[i].epuLocal;
			                             var markName =(epuList[i].epuXscale==null||epuList[i].epuXscale=='')?"否":"是";
			                          
			                            tbody += '<tr>';
			                           //	tbody += '<td align="center"></td>';		             
			                            tbody += '<td align="center"><div>' + epuList[i].epuProvinceName+ '</div></td>';
			                            tbody += '<td align="center"><div>' + epuList[i].epuCityName + '</div></td>';
			                            tbody += '<td align="center"><div>' + epuList[i].epuDistrictName+ '</div></td>';
			                            tbody += '<td align="center"><div>' + epuList[i].epuLocal + '</div></td>';			                            
			                            tbody += '<td align="center"><div>' + epuList[i].epuName+ '</div></td>';
			    		                  tbody += '<td align="center"><div>'+markName +'</div></td>';                 
			                            tbody += '<td align="center"><div></div></td>'; 
			                            tbody += '<td><div><a href="javascript:epuEdit.saveShow(\''+epuList[i].rowId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:so.delEpuInfo(\''+epuList[i].rowId+'\');">删除</a>';
			                             if(epuXscale!="" && epuYscale!="")
			                             {
			                              tbody += '&nbsp;&nbsp; <a href="javascript:epuEdit.epuEditMark(\''+epuList[i].rowId+'\');">位置</a></div></td>';
			                              }			                          	                     			                            
			                            tbody += '</tr>';			                            
			                        }
			                        $("#epuListTable").html(tbody);
			                         // var pageHtml=page.pageHtml.replace(new RegExp("_submitform","gm"),"javascript:so.initList");
			                         var a = page.pageHtml;
									var b = a.substring(0,a.lastIndexOf('\<script'));  
			                        var pageHtml=b.replace(/_submitform/g,'initList');
			                       $(".pagination").html(pageHtml);
			                         $("#loadingDiv").hide(); 
			                    }else
			                    {
			                    	  $("#epuListTable").html('');
			                    }
			                    //分页
			                   // TRADEZONE_MANAGE_PAGE.totalCount = data.recordsTotal;
			                } else {
			                    //分页
			                    //TRADEZONE_MANAGE_PAGE.totalCount = 0;
			                }
			               // PAGINATION_UTIL.callbackObj = TRADEZONE_MANAGE_PAGE; //一定要有这句
			                //PAGINATION_UTIL.inputName = "startPage";//一个页面有多个列表时需要这个值不一样
			                //PAGINATION_UTIL.pagination(currentPage);
			            },
			            error: function () {
			                //分页
			              /*   TRADEZONE_MANAGE_PAGE.totalCount = 0;
			                PAGINATION_UTIL.callbackObj = TRADEZONE_MANAGE_PAGE; //一定要有这句
			                //PAGINATION_UTIL.inputName = "startPage";//一个页面有多个列表时需要这个值不一样
			                PAGINATION_UTIL.pagination(currentPage); */ 
			                $("#loadingDiv").hide();
			            }
			        });

			    };
			 
		</script>
		
		<script >
		var epAdd= {};
			
			epAdd.initProvince= function initProvince() {
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getProvinces.shtml",
		                data: {
		                },
		                async:false,
		                dataType: "json",
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#saveDiv #epuProvince').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#saveDiv #epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
		                    }
		                }
		            });
			};
<%-- 			 epAdd.initEpuType=function initEpuType() {
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/chanceAllType.shtml",
		                data: {
		                },
		                async:false,
		                dataType: "json",
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.epuTypeBean.length;
		                    $('#saveDiv #epuType').html('<option value="">--请选择--</option>');
		                    $('#saveDiv #parentEpuType').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#saveDiv #epuType').append('<option value="' + a.epuTypeBean[i].code + '">' + a.epuTypeBean[i].codeName + '</option>');
		                        $('#saveDiv #parentEpuType').append('<option value="' + a.epuTypeBean[i].code + '">' + a.epuTypeBean[i].codeName + '</option>');
		                    }
		                }
		            });
			}; --%>
			
			 epAdd.registEvent= function registEvent() {
				  $('#saveDiv #epuProvince').change(function () {
					  var i = $('#saveDiv #epuProvince option:selected').val();			
				  $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getCity.shtml",
		                data: {
		                    "provinceId": i,
		                    'districtFlag': 0
		                },
		                dataType: "json",
		                async:false,
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#saveDiv #epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#saveDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });			 
				  $("#saveDiv #epuCity").change(
							function() {
								var i = $('#saveDiv #epuCity option:selected').val();
								// 第四级
								$.ajax({
									type : "post",
									url : "<%=basePath%>/epu/getCityDistrict.shtml",
									data : {
										"cityId" : i
									},
									dataType : "json",
									cache : false,
									error : function(a, b, c) {
									},
									success : function(a) {
										var length = a.length;
										$('#saveDiv #epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('#saveDiv #epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							}); 
					};
				 
			 epAdd.submitFun=function submitFun(flag){
				var errorMsg="";
/* 				if (flag=="1")
				{
						var list=$(".request");
						for(i=0,len=list.length;i<len;i++){
							var element=list[i];
							var value=list[i].value;
							if(value==null||value==""){
								errorMsg+=element.title+"<br>";
							}
						}
						
						
						var elementRequiredSelects = $(".requiredSelect");
						var selectSize = elementRequiredSelects.length;
						for (var index = 0; index < selectSize; index++) {
							var element = elementRequiredSelects[index];
							
							var str = element.value;
							if (str == null || str == undefined || str == '') {
								var displayText=element.title;
								errorMsg+=displayText+"<br>";
							}
						}
					
					
					var elementNums = $(".requiredNum");
					var numSize = elementNums.length;
					for (var index = 0; index < numSize; index++) {
						var element = elementNums[index];
						var str = element.value;
						if (str == null || str == undefined || str == '') {
							var displayText=element.title;
							errorMsg+=displayText+"<br>";
						}
					}
					var elementInts = $(".requiredInt");
					var size = elementInts.length;
					for (var index = 0; index < size; index++) {
						var element = elementInts[index];
						var str = element.value;
						if (str == null || str == undefined || str == '') {
							var displayText=element.title;
							errorMsg+=displayText+"<br>";
						}
					}
				}
					if(errorMsg.length>0){
						alert('页面有未填项，请检查！<br>'+errorMsg);
						return false;
					} */
					//$('input[name="flag"]').val(flag);
					var rowId=$("#saveDiv #rowId").val();
					var epuProvince=$("#saveDiv #epuProvince").val();
					var epuCity=$("#saveDiv #epuCity").val();
					var epuDistrict=$("#saveDiv #epuDistrict").val();		
					var epuName=$("#saveDiv #epuName").val();
					var epuLocal=$("#saveDiv #epuLocal").val();				
					var returnFlag=true;
					//当设备名称发生变化，需要校验设备名称同区域性的唯一性
					if( $("#saveDiv #epuNameBefore").val()!=epuName)
					{
							$.ajax({
							url : "<%=basePath%>/epu/checkEpName.shtml",
							type : 'POST',
							dataType : 'json',
							async : false,
							data : {						
								epuDistrict:epuDistrict,						
								epuName:epuName,
								epuType:'M0001'
							
							},
							success : function(data) {
								  if(data.stauts!='0' && data.stauts!='')
								  {
								  layer.msg('同区域下的设备,名称不能重复，请修改!',function(){});
								  //alert('同区域下的设备,名称不能重复，请修改!');
								  returnFlag=false;
								  }
							
							}
				
						});
					}
					
					if(returnFlag)
					{
				   $("#loadingDiv").show();
					$.ajax({
						url : "<%=basePath%>/epu/updateEpuInfo.shtml",
						type : 'POST',
						dataType : 'json',
						async : false,
						data : {
							rowId:rowId,
							epuProvince:epuProvince,
							epuCity:epuCity,
							epuDistrict:epuDistrict,
							epuType:'M0001',
							epuName:epuName,
							epuLocal:epuLocal,
						
						},
						success : function(data) {
							   $("#loadingDiv").hide();
							   $('#saveDiv').hide();
								window.location="<%=basePath%>/epu/showSubstainList.shtml";
						
						}
			
					});
					} 					
					
			}
			
			  epAdd.saveShow=function saveShow()
			  {			  
			   $("#saveDiv #rowId").val('');
			  $("#saveDiv #epuProvince").val('');
			  $("#saveDiv #epuCity").val('');
			   $("#saveDiv #epuDistrict").val('');					
			   $("#saveDiv #epuName").val('');
			  $("#saveDiv #epuLocal").val('');
			   $("#saveDiv").show();
		       epAdd.initProvince();
		       epAdd.registEvent();
			  }
		</script>
		<script type="text/javascript">
		/* 	.init(function(){
				
				   initPage();
				   registEvent();			
			}); */
	   var epuEdit={};
	    epuEdit.epuProvince;
	    epuEdit.epuCity;
	    epuEdit.epuDistrict;
			//初始化页面数据
			    epuEdit.initPage= function initPage() {	                    
				// 省份
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getProvinces.shtml",
		                data: {
		                },
		                async:false,
		                dataType: "json",
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#epuProvince').html('<option value="">--请选择--</option>');		                  
		                   
		                    for (var i = 0; i < length; i++) {
		                    	if(epuEdit.epuProvince==a[i].provinceId)
		                    		{
		                    		   $('#saveDiv #epuProvince').append('<option value="' + a[i].provinceId + '" selected="selected">' + a[i].provinceNameCn + '</option>');
		                    		}else
		                    			
		                    		{
		                    			   $('#saveDiv #epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
		                    		}
		                     
		                    }
		                }
		            });
		         // 城市
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getCity.shtml",
		                data: {
		                    "provinceId": epuEdit.epuProvince,
		                    'districtFlag': 0
		                },
		                dataType: "json",
		                async:false,
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#saveDiv #epuCity').html('<option value="">--请选择--</option>');
		                
		                    for (var i = 0; i < length; i++) {
		                    	if(epuEdit.epuCity==a[i].cityCode )
		                    	{
		                    		  $('#saveDiv #epuCity').append('<option value="' + a[i].cityCode + '" selected="selected">' + a[i].cityNameCn + '</option>');
		                    	}
		                    	else
		                    	{
		                    		  $('#saveDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    	}
		                      
		                    }
		                }
			    });
		         // 区域
		        	$.ajax({
						type : "post",
						url : "<%=basePath%>/epu/getCityDistrict.shtml",
						data : {
							cityId : epuEdit.epuCity
						},
						dataType : "json",
						cache : false,
						error : function(a, b, c) {
						},
						success : function(a) {
							var length = a.length;
							$('#saveDiv #epuDistrict').html(
									'<option value="">--请选择--</option>');
						
							for (var i = 0; i < length; i++) {
								if(epuEdit.epuDistrict==a[i].cityCode)
		                    	{
									$('#saveDiv #epuDistrict').append('<option value="' + a[i].cityCode+ '" selected="selected">' + a[i].cityNameCn+ '</option>');	
		                    	}
								else
								{
									$('#saveDiv #epuDistrict').append('<option value="' + a[i].cityCode+ '">' + a[i].cityNameCn+ '</option>');	
								}
								
							}
						}
					});		      
			};

			
			 epuEdit.registEvent=function registEvent() {
				  $('#saveDiv #epuProvince').change(function () {
					  var i = $('#saveDiv #epuProvince option:selected').val();			
				  $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getCity.shtml",
		                data: {
		                    "provinceId": i,
		                    'districtFlag': 0
		                },
		                dataType: "json",
		                async:false,
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#saveDiv #epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#saveDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });
					$("#saveDiv #epuCity").change(
							function() {
								var i = $('#saveDiv #epuCity option:selected').val();
								// 第四级
								$.ajax({
									type : "post",
									url : "<%=basePath%>/epu/getCityDistrict.shtml",
									data : {
										"cityId" : i
									},
									dataType : "json",
									cache : false,
									error : function(a, b, c) {
									},
									success : function(a) {
										var length = a.length;
										$('#saveDiv #epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('#saveDiv #epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							});				
			 };
	/* 		   epuEdit.guid=function guid() {
					    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
					        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
					        return v.toString(16);
					    });
					} */
				epuEdit.linkMap=function linkMap() {
					 var rowId=$('#saveDiv #rowId').val();
					var cityName=$("#saveDiv #epuCity").find("option:selected").text();
					/*   if(rowId=='' || rowId==null || rowId==undefined )
					 	 {
						rowId=  epuEdit.guid();
						$('#rowId').val(rowId);
						 }   */
						var epuProvince=$("#saveDiv #epuProvince").val();
						var epuCity=$("#saveDiv #epuCity").val();
						var epuDistrict=$("#saveDiv #epuDistrict").val();				
						var epuName=$("#saveDiv #epuName").val();
						var epuLocal=$("#saveDiv #epuLocal").val();
						var url="<%=basePath%>/html/mapMark.html";
						url+="?rowId=" + rowId+"&cityName="+encodeURI(cityName)+"&epuProvince="+epuProvince+"&epuCity="+epuCity;
						url+="&epuDistrict=" + epuDistrict+"&epuName="+encodeURI(epuName)+"&epuLocal="+encodeURI(epuLocal);
						//url+="&epuParentId=" + epuParentId+"&districtId="+districtId+"&addressId="+addressId+"&channelId="+channelId+"&lineId="+encodeURI(lineId);
					 window.location=url;
				 };
				 epuEdit.epuEditMark=function(rowId)		 
			 {
			   var url= "<%=basePath%>/epu/queryEpu.shtml";
		 	     $.ajax({
						url :url,
						type : 'POST',
						data :{
						rowId:rowId
					
						},						
						success : function(data) {
							if(data.epuInfos.length>0)
							{
					    var cityName=data.epuInfos[0].epuCityName;
						var epuProvince=data.epuInfos[0].epuProvince;
						var epuCity=data.epuInfos[0].epuCity;
						var epuDistrict=data.epuInfos[0].epuDistrict;			
						var epuName=data.epuInfos[0].epuName;
						var epuLocal=data.epuInfos[0].epuLocal;
						url="<%=basePath%>/html/mapMark.html";
						url+="?rowId=" + rowId+"&cityName="+encodeURI(cityName)+"&epuProvince="+epuProvince+"&epuCity="+epuCity;
						url+="&epuDistrict=" + epuDistrict+"&epuName="+encodeURI(epuName)+"&epuLocal="+encodeURI(epuLocal);
					    window.location=url;
                           }						
						},
						error: function (data) 
						{
						   layer.msg(data,function(){});
				   	    }			
					}); 				
				 	};
				 
		          epuEdit.saveShow=function saveShow(rowId){
			  
							$("#loadingDiv").show();		 
						$.ajax({
							url : "<%=basePath%>/epu/editInit.shtml",
							type : 'POST',
							dataType : 'json',
							async : false,
							data : {
								rowId:rowId
							
							},
							success : function(data) {
							
							  var  epuInfo=data.epuInfo;
										$("#saveDiv #rowId").val(epuInfo.rowId );				
										$("#saveDiv #epuName").val(epuInfo.epuName );
										$("#saveDiv #epuLocal").val(epuInfo.epuLocal );
								       $("#saveDiv #epuNameBefore").val(epuInfo.epuName );
										  epuEdit.epuProvince=epuInfo.epuProvince;
										    epuEdit.epuCity=epuInfo.epuCity;
										     epuEdit.epuDistrict=epuInfo.epuDistrict;
								    $("#saveDiv").show();
								    epuEdit.initPage();
				                    epuEdit.registEvent();	
				                     $("#loadingDiv").hide();							
							}             
							});
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
<div class="wapp-main">
		<form method="post" action="" id="formId" class="form-inline">
		
	<h4>箱变信息列表</h4>	
    <!--搜索开始-->
	<div class="search">
	   <lable>
        	<span>省份</span>
            <select id="epuProvince" name="epuProvince" >
            	
            </select>
    	</lable>
    	   <lable>
        	<span>城市</span>
            <select id="epuCity" name="epuCity" >
            	
            </select>
    	</lable>
    	  <lable>
        	<span>区县</span>
            <select id="epuDistrict" name="epuDistrict" >
            	
            </select>
    	</lable>
        <lable>       
        	<span>设备名称 </span>
            <input  id="epuName" name ="epuName" type="text"  value="">
    	</lable>
         
        <div class="but-nav">
<!--         	<span class="but" id="btn_query" >查&nbsp;&nbsp;询</span> -->
        	<button type="button"  onclick="javascript:initList();"       class="btn btn-primary" style="background-color: #169274;">查询</button>
        	<button type="button"  onclick="javascript:epAdd.saveShow();"       class="btn btn-primary" style="background-color: #169274;">新增</button>
        </div>
	</div>
    <!--搜索结束/-->
    
    <!--其他操作开始-->
    <div class="other-nav">
<!--         <div class="sec-box"> -->
<!--         	<input name="" type="text"><span>搜索</span> -->
<!--         </div> -->
    	<!-- <div class="but-nav">
        	<span class="icon01">新增</span>
            <span class="icon03" id="deleteAll">删除</span>
        </div> -->
    </div>
    <!--其他操作结束/-->
    <!--表格开始-->
    <div class="table-box">
        <table width="100%">
            <tr>   
							<th>省份</th>
							<th>城市</th>
							<th>区县</th>
							<th>所在位置</th>
							<th>设备名称</th>						
							<th>是否标注</th>
							<th>状态</th>
							<th>操作</th>
				
            </tr>
           <tbody id="epuListTable"></tbody>
        </table>
    </div>
	<!--表格结束/-->
    
<!--     分页开始 -->

	   		 <div class="pagination pull-right">
			 </div>
<!--     分页结束/ -->
 </form>
</div>
<!--主体结束/-->
</body>
</html>
<!--弹层开始-->
<div class="wapp-layer"  id="saveDiv">
    <div class="box" style="height:auto">
	<h4>新增箱变<span class="close-js"  onclick="$('#saveDiv').hide();">关闭</span></h4>
	  <input name="rowId" type="hidden" id="rowId"  value="">
	    <input name="epuNameBefore" type="hidden" id="epuNameBefore"  value="">
        <div class="edit" style="height:auto">
             <lable>
                <span>省份</span>
                <select name="epuProvince" id="epuProvince" class="text requiredSelect" title="省份"></select>
            </lable>
             <lable>
                <span>城市</span>
                <select name="epuCity" id="epuCity" class="text requiredSelect" title="城市">
								</select>
            </lable>
            <lable>
                <span>区县</span>
                <select name="epuDistrict" id="epuDistrict" class="text requiredSelect" title="区县">
								</select>
            </lable>
  
            <lable>
                <span>设备名称</span>
                <input name="epuName" id="epuName"   type="text" class="text request" title="设备名称" maxlength="100">
            </lable>
         
            <lable>
                <span>设备位置</span>
                <input name="epuLocal"  id="epuLocal" type="text" class="text request" title="设备位置" maxlength="100">                          
            </lable>             
	             <lable>
	              <div id='isMapMarkDiv' >             
	  			    <span>地图标注</span>
	                 <a href="javascript:epuEdit.linkMap();" class="but02"  id="butadd" >地图标注</a>
	                   </div>
				</lable>     	
            <div class="but-nav" style="margin:0px 0px 20px 0px">
                <span class="but" onclick="javascript:epAdd.submitFun('1');">保&nbsp;&nbsp;存</a></span>
                <span class="but miss close-js" onclick="$('#saveDiv').hide();">取&nbsp;&nbsp;消</span>
            </div>         
              </div>
        </div>
    </div>
</div>
<!--弹层结束/-->
<!--弹层开始-->
<div class="wapp-layer" id="message">
	<div class="box tips">
    	<h4>提示信息<span class="close-js" onclick="$('#message').hide();">关闭</span></h4>
    		<form id="boxRoleForm">
        <div class="edit">
            <p><sapn id="statusSpan"></sapn></p>

            <div class="but-nav">
                <span class="but" onclick="updatestatus();">确&nbsp;&nbsp;定</span>
                <span class="but miss close-js" onclick="$('#message').hide();">取&nbsp;&nbsp;消</span>
            </div>
        </div>
        </form>
    </div>
</div>
<!--弹层结束/-->
  </body>
</html>
