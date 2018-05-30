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
    
    <title>V2-电表信息列表</title>
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
				//全选
				//so.checkBoxInit('#checkAll','[check=box]');
			/* 	so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return so._delete(array);
				}); */
				so.initProvince();
				so.registEvent();
				initList();
			});
		
			so.initProvince= function initProvince() {
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
		                        $('#epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
		                    }
		                }
		            });
			};

			so._delete= function _delete(ids){
				var index = layer.confirm("确定需要删除这"+ ids.length +"个电表？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/ammeter/delEpuInfo.shtml',{rowIds:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
							 window.location="<%=basePath%>/ammeter/showAmList.shtml";
						}
					},'json');
					layer.close(index);
				});
			}
			 so.registEvent=function registEvent() {
				  $('#epuProvince').change(function () {
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
		                    $('#epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });
					$("#epuCity").change(
							function() {
								var i = $('#epuCity option:selected').val();
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
										$('#epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('#epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							});
				 
			 };
			  so.editEpuInfo=function editEpuInfo(rowId) {				 
				 window.location="<%=basePath%>/ammeter/editInit.shtml?rowId=" + rowId;
			 };
			<%-- so.delEpuInfo=function delEpuInfo(rowId) {				
				if(confirm('确实要删除该内容吗?')){
	   				  $("#loadingDiv").show();
	   				 $.ajax({
	   		  			    url:"<%=basePath%>/ammeter/delEpuInfo.shtml",
	   		  			    type:'POST',
	   		  			    dataType:'json',
	   		  			    data:{rowIds:rowId},
	   		  			    success:function(data){
	   		  			    	if(data.error=="删除失败!"){
	   		  			    	layer.msg(data.error,function(){});
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}else{ 
	   		  			     	layer.msg("删除成功!",function(){});
	   		  					 window.location="<%=basePath%>/ammeter/showAmList.shtml";
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}
	   		  			    }
	   		  			    
	   		  			  });
	   			  }				  

			 };--%>
			  function initList(pageNo) {
			    	 $("#loadingDiv").show(); 

			        $.ajax({
			            url: "<%=basePath%>/ammeter/queryEpuList.shtml",
			            type: 'POST',
			            dataType: 'json',
			            async:false,
			            data: {			          
			            	epuProvince: $("#epuProvince").val(),
			            	epuCity: $("#epuCity").val(),
			            	epuDistrict: $("#epuDistrict").val(),
			            	ammeterName: $("#ammeterName").val(),
			                districtId: $("#districtId").val(),
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
			       
			                            tbody += '<tr>';
			                        /*    tbody += '<td align="center"><input value="'+epuList[i].rowId+'" check="box" type="checkbox" /></td>';   */           
			                            tbody += '<td align="center"><div>' + epuList[i].epuProvinceName+ '</div></td>';
			                            tbody += '<td align="center"><div>' + epuList[i].epuCityName + '</div></td>';
			                            tbody += '<td align="center"><div>' + epuList[i].epuDistrictName+ '</div></td>';			                        			                            
			                            tbody += '<td align="center"><div>' + epuList[i].ammeterName+ '</div></td>';
			                            tbody += '<td align="center"><div>' +epuList[i].epuName + '</div></td>';
			                            tbody += '<td align="center"><div>' +epuList[i].districtId+((epuList[i].addressId==null || epuList[i].addressId=='' )?'':"-" +epuList[i].addressId) +((epuList[i].channelId==null || epuList[i].channelId=='' )?'':"-" +epuList[i].channelId)+ '</div></td>';			                          
			                             
			                              tbody += '<td align="center"><div></div></td>'; 
			                              tbody += '<td><div><a href="javascript:amEdit.saveShow(\''+epuList[i].rowId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:so._delete([\''+epuList[i].rowId+'\']);">删除</a>';			                     			        
			                           
			                            tbody += '</tr>';
			                            
			                        }
			                        $("#epuListTable").html(tbody);
			                        so.checkBoxInit('#checkAll','[check=box]');
			                          var a = page.pageHtml;
									var b = a.substring(0,a.lastIndexOf('\<script'));  
			                        var pageHtml=b.replace(/_submitform/g,'initList');
			                       $(".pagination").html(pageHtml);
			                         $("#loadingDiv").hide(); 
			                    }
			                    else
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
		var amAdd= {};
	/* 	so.init(function(){
				
				  initProvince();
				  initDistrict();
				   registEvent();
		
			}); */
			 
			amAdd.initProvince= function initProvince() {
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
		                    $('#amDiv #epuProvince').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#amDiv #epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
		                    }
		                }
		            });
			};
			
			amAdd.initDistrict=function initDistrict(){
				
				  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/epu/selectDistrictId.shtml",
			                data: {
			                   
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuInfoList = a.epuInfoList;
			            
			                    $('#amDiv #districtId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                   	  $('#amDiv #districtId').append('<option value="' + epuInfoList[i].districtId + '">' + epuInfoList[i].districtId + '</option>');
			                      
			                    }
			                }			                
          	   });
          	   
				
			}

			
			 amAdd.registEvent=function registEvent() {
				  $('#amDiv #epuProvince').change(function () {
					  var i = $('#amDiv #epuProvince option:selected').val();			
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
		                    $('#amDiv #epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#amDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });
					$("#amDiv #epuCity").change(function () {
								var i = $('#amDiv #epuCity option:selected').val();
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
										$('#amDiv #epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('#amDiv #epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							});				
				 
					  
					  $('#amDiv #epuDistrict').change(function () {
						  var i = $('#amDiv #epuDistrict option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/ammeter/selectEpuNameByAm.shtml",
			                data: {
			                    "epuDistrict": i
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuParentList = a.epuParentList;
			            
			                    $('#amDiv #epuId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuParentList.length; i++) {
			                        $('#amDiv #epuId').append('<option value="' + epuParentList[i].epuId + '">' + epuParentList[i].epuName + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  $('#amDiv #districtId').change(function () {
						  var i = $('#amDiv #districtId option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/epu/selectAddressIdByDistrictId.shtml",
			                data: {
			                    "districtId": i
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuInfoList = a.epuInfoList;
			            
			                    $('#amDiv #addressId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#amDiv #addressId').append('<option value="' + epuInfoList[i].addressId + '">' + epuInfoList[i].addressId + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  
					  $('#amDiv #addressId').change(function () {
						  var districtId = $('#amDiv #districtId option:selected').val();	
						  var addressId = $('#amDiv #addressId option:selected').val();		
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/epu/selectDIstinctByChannelId.shtml",
			                data: {
			                    districtId: districtId,
			                    addressId:addressId
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuInfoList = a.epuInfoList;
			            
			                    $('#amDiv #channelId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#amDiv #channelId').append('<option value="' + epuInfoList[i].channelId + '">' + epuInfoList[i].channelId + '</option>');
			                    }
			                   
			                }
				    });
				 });
			 };
		    
			 amAdd.submitFun=function submitFun(flag){
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
					var rowId=$("#amDiv #rowId").val();
					var epuProvince=$("#amDiv #epuProvince").val();
					var epuCity=$("#amDiv #epuCity").val();
					var epuDistrict=$("#amDiv #epuDistrict").val();									
					var ammeterName=$("#amDiv #ammeterName").val();
					var ammeterId=$("#amDiv #ammeterId").val();
					var epuId=$("#amDiv #epuId").val();
					var districtId=$("#amDiv #districtId").val();
					var addressId=$("#amDiv #addressId").val();
					var channelId=$("#amDiv #channelId").val();
					var houseId=$("#amDiv #houseId").val();
					var phaseRemark=$("#amDiv #phaseRemark").val();
					$("#loadingDiv").show();
					$.ajax({
						url : "<%=basePath%>/ammeter/updateEpuInfo.shtml",
						type : 'POST',
						dataType : 'json',
						async : false,
						data : {
							rowId:rowId,
							epuProvince:epuProvince,
							epuCity:epuCity,
							epuDistrict:epuDistrict,
							ammeterName:ammeterName,
							ammeterId:ammeterId,
							epuId:epuId,
							districtId:districtId,
							addressId:addressId,
							channelId:channelId,
							houseId:houseId,
							phaseRemark:phaseRemark
						},
						success : function(data) {
							   $("#loadingDiv").hide();
								window.location="<%=basePath%>/ammeter/showAmList.shtml";
						
						}
			
					});
					
			}
			
			 amAdd.saveShow=function saveShow(){
			  
			       $("#amDiv #rowId").val('');
					$("#amDiv #epuProvince").val('');
				    $("#amDiv #epuCity").val('');
					$("#amDiv #epuDistrict").val('');					
					$("#amDiv #epuType").val('');					
					$("#amDiv #epuName").val('');
					$("#amDiv #epuId").val('');
					$("#amDiv #epuParentId").val('');
					$("#amDiv #districtId").val('');
				$("#amDiv #addressId").val('');
				$("#amDiv #channelId").val('');

				$("#amDiv #ammeterName").val('');
				$("#amDiv #ammeterId").val('');
				$("#amDiv #houseId").val('');
				$("#amDiv #phaseRemark").val('');
			
				$("#amDiv").show();
				  amAdd.initProvince();
				  amAdd.initDistrict();
				   amAdd.registEvent();
			}
		</script>
		<script type="text/javascript">
		/* 	.init(function(){
				
				   initPage();
				   registEvent();			
			}); */
   var amEdit={};
     amEdit.epuProvince;
     amEdit.epuCity;
     amEdit.epuDistrict;
    amEdit.districtId;
    amEdit.addressId;
    amEdit.channelId;
    amEdit.epuId;

   
			/* so.init(function(){
				
				   amEdit.initPage();
				   amEdit.registEvent();
			}); */
			//初始化页面数据
			amEdit.initPage =function initPage() {
	                    
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
		                    $('#amDiv #epuProvince').html('<option value="">--请选择--</option>');
		                  
		                   
		                    for (var i = 0; i < length; i++) {
		                    	if(amEdit.epuProvince==a[i].provinceId)
		                    		{
		                    		   $('#amDiv #epuProvince').append('<option value="' + a[i].provinceId + '" selected="selected">' + a[i].provinceNameCn + '</option>');
		                    		}else
		                    			
		                    		{
		                    			   $('#amDiv #epuProvince').append('<option value="' + a[i].provinceId + '">' + a[i].provinceNameCn + '</option>');
		                    		}
		                     
		                    }
		                }
		            });
		         // 城市
		            $.ajax({
		                type: "post",
		                url:  "<%=basePath%>/epu/getCity.shtml",
		                data: {
		                    "provinceId": amEdit.epuProvince,
		                    'districtFlag': 0
		                },
		                dataType: "json",
		                async:false,
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.length;
		                    $('#amDiv #epuCity').html('<option value="">--请选择--</option>');
		                
		                    for (var i = 0; i < length; i++) {
		                    	if(amEdit.epuCity==a[i].cityCode )
		                    	{
		                    		  $('#amDiv #epuCity').append('<option value="' + a[i].cityCode + '" selected="selected">' + a[i].cityNameCn + '</option>');
		                    	}
		                    	else
		                    	{
		                    		  $('#amDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    	}
		                      
		                    }
		                }
			    });
		         // 区域
		        	$.ajax({
						type : "post",
						url : "<%=basePath%>/epu/getCityDistrict.shtml",
						data : {
							"cityId" : amEdit.epuCity
						},
						dataType : "json",
						cache : false,
						error : function(a, b, c) {
						},
						success : function(a) {
							var length = a.length;
							$('#amDiv #epuDistrict').html(
									'<option value="">--请选择--</option>');
						
							for (var i = 0; i < length; i++) {
								if(amEdit.epuDistrict==a[i].cityCode)
		                    	{
									$('#amDiv #epuDistrict').append('<option value="' + a[i].cityCode+ '" selected="selected">' + a[i].cityNameCn+ '</option>');	
		                    	}
								else
								{
									$('#amDiv #epuDistrict').append('<option value="' + a[i].cityCode+ '">' + a[i].cityNameCn+ '</option>');	
								}
								
							}
						}
					});
		         
		        	  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/ammeter/selectEpuNameByAm.shtml",
			                data: {
			                    "epuDistrict": amEdit.epuDistrict
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuParentList = a.epuParentList;
			            
			                    $('#amDiv #epuId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuParentList.length; i++) {
			                    	if(amEdit.epuId==epuParentList[i].epuId)
   			                    	{
			                        $('#amDiv #epuId').append('<option value="' + epuParentList[i].epuId + '" selected="selected">' + epuParentList[i].epuName + '</option>');
   			                    	}
			                    	else
			                    	{
				                        $('#amDiv #epuId').append('<option value="' + epuParentList[i].epuId + '">' + epuParentList[i].epuName + '</option>');
	   			                    }	
			                    }
			                   
			                }
				    });
		         
		       
		         //关联终端bcd编号
		     
			                	   $.ajax({
			   			                type: "post",
			   			                url:  "<%=basePath%>/epu/selectDistrictId.shtml",
			   			                data: {
			   			                   
			   			                },
			   			                dataType: "json",
			   			                async:false,
			   			                cache: false,
			   			                error: function (a,b,c) {
			   			                },
			   			                success: function (a) {
			   			                    var epuInfoList = a.epuInfoList;
			   			            
			   			                    $('#amDiv #districtId').html('<option value="">--请选择--</option>');
			   			                    for (var i = 0; i < epuInfoList.length; i++) {
			   			                    	if(amEdit.districtId==epuInfoList[i].districtId)
			   			                    	{
			   			                    	  $('#amDiv #districtId').append('<option value="' + epuInfoList[i].districtId + '" selected="selected">' + epuInfoList[i].districtId + '</option>');
			   			                    	}
			   			                    	else
			   			                    	{
			   			                    	  $('#amDiv #districtId').append('<option value="' + epuInfoList[i].districtId + '">' + epuInfoList[i].districtId + '</option>');
			   			                    	}
			   			                      
			   			                    }
			   			                }			                
			                	   });
			       
			                	   $.ajax({
						                type: "post",
						                url:  "<%=basePath%>/epu/selectAddressIdByDistrictId.shtml",
						                data: {
						                    districtId: amEdit.districtId
						                },
						                dataType: "json",
						                async:false,
						                cache: false,
						                error: function (a,b,c) {
						                },
						                success: function (a) {
						                    var epuInfoList = a.epuInfoList;
						            
						                    $('#amDiv #addressId').html('<option value="">--请选择--</option>');
						                    for (var i = 0; i < epuInfoList.length; i++) {
						                    	if(amEdit.addressId==epuInfoList[i].addressId)
			   			                    	{
			   			                    	  $('#amDiv #addressId').append('<option value="' + epuInfoList[i].addressId + '" selected="selected">' + epuInfoList[i].addressId + '</option>');
			   			                    	}
			   			                    	else
			   			                    	{
						                        $('#amDiv #addressId').append('<option value="' + epuInfoList[i].addressId + '">' + epuInfoList[i].addressId + '</option>');
						                        }
						                    }
						                   
						                }
							    });
			                	   
			                	   $.ajax({
						                type: "post",
						                url:  "<%=basePath%>/epu/selectDIstinctByChannelId.shtml",
						                data: {
						                    districtId: amEdit.districtId,
						                    addressId:amEdit.addressId
						                },
						                dataType: "json",
						                async:false,
						                cache: false,
						                error: function (a,b,c) {
						                },
						                success: function (a) {
						                    var epuInfoList = a.epuInfoList;
						            
						                    $('#amDiv #channelId').html('<option value="">--请选择--</option>');
						                    for (var i = 0; i < epuInfoList.length; i++) {
						                    	if(amEdit.channelId==epuInfoList[i].channelId)
			   			                    	{
						                    		  $('#amDiv #channelId').append('<option value="' + epuInfoList[i].channelId + '"  selected="selected">' + epuInfoList[i].channelId + '</option>');
			   			                    	}
						                    	else
						                    		
						                    	{
						                    		  $('#amDiv #channelId').append('<option value="' + epuInfoList[i].channelId + '">' + epuInfoList[i].channelId + '</option>');
						                    	}
						                      
						                    }
						                   
						                }
							    });
			       
		            
			};

			
			 amEdit.registEvent =function registEvent() {
				  $('#amDiv #epuProvince').change(function () {
					  var i = $('#amDiv #epuProvince option:selected').val();			
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
		                    $('#amDiv #epuCity').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#amDiv #epuCity').append('<option value="' + a[i].cityCode + '">' + a[i].cityNameCn + '</option>');
		                    }
		                }
			    });
			 });
					$("#amDiv #epuCity").change(function () {
								var i = $('#amDiv #epuCity option:selected').val();
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
										$('#amDiv #epuDistrict').html(
												'<option value="">--请选择--</option>');
										for (var i = 0; i < length; i++) {
											$('#amDiv #epuDistrict').append(
													'<option value="' + a[i].cityCode
															+ '">' + a[i].cityNameCn
															+ '</option>');
										}
									}
								});
							});				
				 
					  
					  $('#amDiv #epuDistrict').change(function () {
						  var i = $('#amDiv #epuDistrict option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/ammeter/selectEpuNameByAm.shtml",
			                data: {
			                    "epuDistrict": i
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuParentList = a.epuParentList;
			            
			                    $('#amDiv #epuId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuParentList.length; i++) {
			                        $('#amDiv #epuId').append('<option value="' + epuParentList[i].epuId + '">' + epuParentList[i].epuName + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  $('#amDiv #districtId').change(function () {
						  var i = $('#amDiv #districtId option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/epu/selectAddressIdByDistrictId.shtml",
			                data: {
			                    "districtId": i
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuInfoList = a.epuInfoList;
			            
			                    $('#amDiv #addressId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#amDiv #addressId').append('<option value="' + epuInfoList[i].addressId + '">' + epuInfoList[i].addressId + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  
					  $('#amDiv #addressId').change(function () {
						  var districtId = $('#amDiv #districtId option:selected').val();	
						  var addressId = $('#amDiv #addressId option:selected').val();		
					  $.ajax({
			                type: "post",
			                url:  "<%=basePath%>/epu/selectDIstinctByChannelId.shtml",
			                data: {
			                    districtId: districtId,
			                    addressId:addressId
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuInfoList = a.epuInfoList;
			            
			                    $('#amDiv #channelId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#amDiv #channelId').append('<option value="' + epuInfoList[i].channelId + '">' + epuInfoList[i].channelId + '</option>');
			                    }
			                   
			                }
				    });
				 });
			 };
				
			 amEdit.submitFun =function submitFun(flag){
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
						var rowId=$("#amDiv #rowId").val();
						var epuProvince=$("#amDiv #epuProvince").val();
						var epuCity=$("#amDiv #epuCity").val();
						var epuDistrict=$("#amDiv #epuDistrict").val();									
						var ammeterName=$("#amDiv #ammeterName").val();
						var ammeterId=$("#amDiv #ammeterId").val();
						var epuId=$("#amDiv #epuId").val();
						var districtId=$("#amDiv #districtId").val();
						var addressId=$("#amDiv #addressId").val();
						var channelId=$("#amDiv #channelId").val();
						var houseId=$("#amDiv #houseId").val();
						var phaseRemark=$("#amDiv #phaseRemark").val();
						$("#loadingDiv").show();
						$.ajax({
							url : "<%=basePath%>/ammeter/updateEpuInfo.shtml",
							type : 'POST',
							dataType : 'json',
							async : false,
							data : {
								rowId:rowId,
								epuProvince:epuProvince,
								epuCity:epuCity,
								epuDistrict:epuDistrict,
								ammeterName:ammeterName,
								ammeterId:ammeterId,
								epuId:epuId,
								districtId:districtId,
								addressId:addressId,
								channelId:channelId,
								houseId:houseId,
								phaseRemark:phaseRemark
							},
							success : function(data) {
								   $("#loadingDiv").hide();
									window.location="<%=basePath%>/ammeter/showAmList.shtml";
							
							}
				
						});
						
					
				}
	
				    amEdit.saveShow=function saveShow(rowId){
			  
							$("#loadingDiv").show();		 
						$.ajax({
							url : "<%=basePath%>/ammeter/editInit.shtml",
							type : 'POST',
							dataType : 'json',
							async : false,
							data : {
								rowId:rowId
							
							},
							success : function(data) {
							
							  var  epuInfo=data.epuInfo;
										$("#amDiv #rowId").val(epuInfo.rowId );				
										$("#amDiv #ammeterName").val(epuInfo.ammeterName );
										$("#amDiv #ammeterId").val(epuInfo.ammeterId );
										$("#amDiv #houseId").val(epuInfo.houseId );
										$("#amDiv #phaseRemark").val(epuInfo.phaseRemark );
										  amEdit.epuProvince=epuInfo.epuProvince;
										  amEdit.epuCity=epuInfo.epuCity;
										     amEdit.epuDistrict=epuInfo.epuDistrict;
										     amEdit.epuId=epuInfo.epuId;
										   amEdit.districtId=epuInfo.districtId;
										   amEdit.addressId=epuInfo.addressId;
										  amEdit.channelId=epuInfo.channelId;
										   
										
								    $("#amDiv").show();
								    amEdit.initPage();
				                    amEdit.registEvent();	
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
		
	<h4>电表信息列表</h4>	
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
            <input  id="ammeterName" name ="ammeterName" type="text"  value="${(empty ammeterName)? '' : ammeterName}">
    	</lable>
        <lable>
        	<span>关联终端</span>
            <input  id="districtId" name="districtId" type="text" value="${(empty districtId)? '' : email}">
    	</lable>       
        <div class="but-nav">
        	<button type="button"  onclick="javascript:initList();"       class="btn btn-primary" style="background-color: #169274;">查询</button>
        	<button type="button"  onclick="javascript:amAdd.saveShow();"       class="btn btn-primary" style="background-color: #169274;">新增</button>
        </div>
	</div>
    <!--搜索结束/-->
    
    <!--其他操作开始-->
    <div class="other-nav">
<!--         <div class="sec-box"> -->
<!--         	<input name="" type="text"><span>搜索</span> -->
<!--         </div> -->
    	<!-- <div class="but-nav">
            <span class="icon03" id="deleteAll">删除</span>
        </div> -->
    </div>
    <!--其他操作结束/-->
    <!--表格开始-->
    <div class="table-box">
        <table width="100%">
            <tr>             		
               <!--  <th><input  type="checkbox" id="checkAll"></th>          -->                
				<th>省份</th>
				<th>城市</th>
				<th>区县</th>
				<th>设备名称</th>
				<th>上级设备</th>
				<th>终端设备</th>												
				<th>状态</th>
				<th>操作</th>			
            </tr>
           <tbody id="epuListTable"></tbody>
        </table>
    </div>
	<!--表格结束/-->
    
<!--     分页开始 -->
<%-- 	<c:if test="${!empty page }">
        <c:if test="${!empty page.list }">
	   		 <div class="pagination pull-right">
				${page.pageHtml}
			 </div>
		</c:if>
	</c:if> --%>
	
	 <div class="pagination pull-right">
     </div>
<!--     分页结束/ -->
 </form>
</div>
<!--主体结束/-->
</body>
</html>
<!--弹层开始-->
<div class="wapp-layer"  id="amDiv">
	    <div class="box" style="height:auto">
	<h4>新增电表<span class="close-js"  onclick="$('#amDiv').hide();">关闭</span></h4>
	  <input name="rowId" type="hidden" id="rowId"  value="">
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
               <span>所属表箱</span>
               <select name="epuId" id="epuId" class="text requiredSelect" title="所属表箱">
								</select>
            </lable>       
            <lable>
               <span>电表名称</span>
                <input name="ammeterName" id="ammeterName"   type="text" class="text request" title="电表名称" maxlength="100">
            </lable>
             <lable>
               <span>电表号</span>
                <input name="ammeterId"  id="ammeterId"  value="${epuInfo.ammeterId}" type="text" class="text request" title="电表号" maxlength="100">
            </lable>
            
            <lable>
                 <span>门牌号</span>
               <input name="houseId"  id="houseId" type="text" class="text request" title="门牌号" maxlength="100">
                          
            </lable>
            
            <lable>
               <span>相别</span>
               <input name="phaseRemark"  id="phaseRemark" type="text" class="text request" title="电表号" maxlength="100">                         
            </lable>      
            <lable>
                <span>关联终端编号</span>
                <select name="districtId" id="districtId" class="text requiredSelect" title="关联终端编号"></select>
            </lable>
             <lable>
                <span>关联终端地址号</span>
                <select name="addressId" id="addressId" class="text requiredSelect" title="关联终端地址号">
								</select>
            </lable>
             <lable>
                <span>关联终端通道号</span>
                <select name="channelId" id="channelId" class="text requiredSelect" title="关联终端通道号">
								</select>
            </lable>
           	
             <div class="but-nav" style="margin:0px 0px 20px 0px">
                <span class="but" onclick="javascript:amAdd.submitFun('1');">保&nbsp;&nbsp;存</a></span>
                <span class="but miss close-js" onclick="$('#amDiv').hide();">取&nbsp;&nbsp;消</span>
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
