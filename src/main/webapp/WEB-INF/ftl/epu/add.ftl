<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>设备信息</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
		<script >
			so.init(function(){
				
				  initProvince();
				  initEpuType();
				   registEvent();
	
			});
			
			 function initProvince() {
		            $.ajax({
		                type: "post",
		                url:  "${basePath}/epu/getProvinces.shtml",
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
			 function initEpuType() {
		            $.ajax({
		                type: "post",
		                url:  "${basePath}/epu/chanceAllType.shtml",
		                data: {
		                },
		                async:false,
		                dataType: "json",
		                cache: false,
		                error: function (a,b,c) {
		                },
		                success: function (a) {
		                    var length = a.epuTypeBean.length;
		                    $('#epuType').html('<option value="">--请选择--</option>');
		                    $('#parentEpuType').html('<option value="">--请选择--</option>');
		                    for (var i = 0; i < length; i++) {
		                        $('#epuType').append('<option value="' + a.epuTypeBean[i].code + '">' + a.epuTypeBean[i].codeName + '</option>');
		                        $('#parentEpuType').append('<option value="' + a.epuTypeBean[i].code + '">' + a.epuTypeBean[i].codeName + '</option>');
		                    }
		                }
		            });
			};
			
			 function registEvent() {
				  $('#epuProvince').change(function () {
					  var i = $('#epuProvince option:selected').val();			
				  $.ajax({
		                type: "post",
		                url:  "${basePath}/epu/getCity.shtml",
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
									url : "${basePath}/epu/getCityDistrict.shtml",
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
					
					  $('#epuType').change(function () {
						  var epuType = $('#epuType option:selected').val();	
						  if(epuType=='M0001' )
					        {
		                    	  $("#hiddenParent").attr("style","display:none;");
		                    	  $("#parentEpuType").val("");
		                    	  $("#epuParentId").val("");
		                    	  
		                    	  $("#isMapMarkDiv").show();
					        }
		                    else
		                    {
		                    	  $("#hiddenParent").attr("style","display:table-row;");
		                    	  $("#isMapMarkDiv").hide();
		                    }
	                       if( epuType=='M0003' )
					        {
		                    	  $("#hiddenDev").attr("style","display:table-row;");
		                    	  $("#hiddenDev1").attr("style","display:table-row;");
					        }
		                    else
		                    {
		                    	  $("#hiddenDev").attr("style","display:none;");
		                    	  $("#hiddenDev1").attr("style","display:none;");
		                    	  $("#districtId").val("");
		                    	  $("#addressId").val("");
		                    	  $("#channelId").val("");
		                    	  $("#lineId").val("");
		                    	  
		                    }
					  $.ajax({
			                type: "post",
			                url:  "${basePath}/epu/getEpuCodeByCode.shtml",
			                data: {
			                    "code": epuType
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuTypeBean = a.epuTypeBean;
			                   if(epuTypeBean!=null && epuTypeBean!=undefined )
			                	   {
				                	   if(epuTypeBean.parentCode!=null){
				                		   $("#parentEpuType").val(epuTypeBean.parentCode);
				                		   $("#hiddenParent").attr("style","display:table-row;");
				                		   
				                		   $.ajax({
				   			                type: "post",
				   			                url:  "${basePath}/epu/getParentEpu.shtml",
				   			                data: {
				   			                    "epuType": epuTypeBean.parentCode
				   			                },
				   			                dataType: "json",
				   			                async:false,
				   			                cache: false,
				   			                error: function (a,b,c) {
				   			                },
				   			                success: function (a) {
				   			                    var epuParentList = a.epuParentList;
				   			            
				   			                    $('#epuParentId').html('<option value="">--请选择--</option>');
				   			                    for (var i = 0; i < epuParentList.length; i++) {
				   			                        $('#epuParentId').append('<option value="' + epuParentList[i].rowId + '">' + epuParentList[i].epuName + '</option>');
				   			                    }
				   			                   
				   			                }
				   				    });
				   				 
				                		  
				                	   }			                	  
				                	    else			                		   
				                	   {
				                	    	$("#hiddenParent").attr("style","display:none;");
				                	   }
			                		}
			                   //关联终端的只有分支箱
			                   if(epuType=='M0003' )
			                	   {
			                	   $.ajax({
			   			                type: "post",
			   			                url:  "${basePath}/epu/selectDistrictId.shtml",
			   			                data: {
			   			                   
			   			                },
			   			                dataType: "json",
			   			                async:false,
			   			                cache: false,
			   			                error: function (a,b,c) {
			   			                },
			   			                success: function (a) {
			   			                    var epuInfoList = a.epuInfoList;
			   			            
			   			                    $('#districtId').html('<option value="">--请选择--</option>');
			   			                    for (var i = 0; i < epuInfoList.length; i++) {
			   			                        $('#districtId').append('<option value="' + epuInfoList[i].districtId + '">' + epuInfoList[i].districtId + '</option>');
			   			                    }
			   			  
			   			                }			                
			                	   });
			                	   
			                	 /*   $.ajax({
			   			                type: "post",
			   			                url:  "${basePath}/epu/selectDIstinctByChannelId.shtml",
			   			                data: {
			   			                   
			   			                },
			   			                dataType: "json",
			   			                async:false,
			   			                cache: false,
			   			                error: function (a,b,c) {
			   			                },
			   			                success: function (a) {
			   			                    var epuInfoList = a.epuInfoList;
			   			            
			   			                    $('#channelId').html('<option value="">--请选择--</option>');
			   			                    for (var i = 0; i < epuInfoList.length; i++) {
			   			                        $('#channelId').append('<option value="' + epuInfoList[i].channelId + '">' + epuInfoList[i].channelId + '</option>');
			   			                    }
			   			  
			   			                }			                
			                	   }); */
			                	
			                	   }
			                      
			                   
			                }
				    });
				 });
				 
					  
					  $('#parentEpuType').change(function () {
						  var i = $('#parentEpuType option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "${basePath}/epu/getParentEpu.shtml",
			                data: {
			                    "epuType": i
			                },
			                dataType: "json",
			                async:false,
			                cache: false,
			                error: function (a,b,c) {
			                },
			                success: function (a) {
			                    var epuParentList = a.epuParentList;
			            
			                    $('#epuParentId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuParentList.length; i++) {
			                        $('#epuParentId').append('<option value="' + epuParentList[i].rowId + '">' + epuParentList[i].epuName + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  $('#districtId').change(function () {
						  var i = $('#districtId option:selected').val();			
					  $.ajax({
			                type: "post",
			                url:  "${basePath}/epu/selectAddressIdByDistrictId.shtml",
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
			            
			                    $('#addressId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#addressId').append('<option value="' + epuInfoList[i].addressId + '">' + epuInfoList[i].addressId + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  $('#addressId').change(function () {
						  var districtId = $('#districtId option:selected').val();	
						  var addressId = $('#addressId option:selected').val();		
					  $.ajax({
			                type: "post",
			                url:  "${basePath}/epu/selectDIstinctByChannelId.shtml",
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
			            
			                    $('#channelId').html('<option value="">--请选择--</option>');
			                    for (var i = 0; i < epuInfoList.length; i++) {
			                        $('#channelId').append('<option value="' + epuInfoList[i].channelId + '">' + epuInfoList[i].channelId + '</option>');
			                    }
			                   
			                }
				    });
				 });
					  
					  
					  
			 };
		    
				function linkMap() {
					 var rowId=$('#rowId').val();
					var cityName=$("#epuDistrict").find("option:selected").text();
					/*  if(rowId=='' || rowId==null || rowId==undefined )
						 {
						rowId= guid();
						$('#rowId').val(rowId);
						 } */
						var rowId=$("#rowId").val();
						var epuProvince=$("#epuProvince").val();
						var epuCity=$("#epuCity").val();
						var epuDistrict=$("#epuDistrict").val();					
						var epuType=$("#epuType").val();					
						var epuName=$("#epuName").val();
						var epuLocal=$("#epuLocal").val();
						var epuParentId=$("#epuParentId").val();
						var districtId=$("#districtId").val();
						var addressId=$("#addressId").val();
						var channelId=$("#channelId").val();
						var lineId=$("#lineId").val();
						var url="${basePath}/html/mapMark.html";
						url+="?rowId=" + rowId+"&cityName="+encodeURI(cityName)+"&epuProvince="+epuProvince+"&epuCity="+epuCity;
						url+="&epuDistrict=" + epuDistrict+"&epuType="+epuType+"&epuName="+encodeURI(epuName)+"&epuLocal="+encodeURI(epuLocal);
						url+="&epuParentId=" + epuParentId+"&districtId="+districtId+"&addressId="+addressId+"&channelId="+channelId+"&lineId="+encodeURI(lineId);
					 window.location=url;
				 };
				 
/* 				 function guid() {
					    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
					        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
					        return v.toString(16);
					    });
					}
			  */
			 function submitFun(flag){
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
					var rowId=$("#rowId").val();
					var epuProvince=$("#epuProvince").val();
					var epuCity=$("#epuCity").val();
					var epuDistrict=$("#epuDistrict").val();					
					var epuType=$("#epuType").val();					
					var epuName=$("#epuName").val();
					var epuLocal=$("#epuLocal").val();
					var epuParentId=$("#epuParentId").val();
					var districtId=$("#districtId").val();
					var addressId=$("#addressId").val();
					var channelId=$("#channelId").val();
					var lineId=$("#lineId").val();
					$("#loadingDiv").show();
					$.ajax({
						url : "${basePath}/epu/updateEpuInfo.shtml",
						type : 'POST',
						dataType : 'json',
						async : false,
						data : {
							rowId:rowId,
							epuProvince:epuProvince,
							epuCity:epuCity,
							epuDistrict:epuDistrict,
							epuType:epuType,
							epuName:epuName,
							epuLocal:epuLocal,
							epuParentId:epuParentId,
							districtId:districtId,
							addressId:addressId,
							channelId:channelId,
							lineId:lineId		
						},
						success : function(data) {
							   $("#loadingDiv").hide();
								window.location="${basePath}/epu/showList.shtml";
						
						}
			
					});
					
					function returnBack(){
						window.location="${basePath}/epu/showList.shtml";
					}
			}
		</script>
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 1/>
				<div class="col-md-10">
					<h2>设备信息列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
									<!--编辑模块开始-->
		          
		           <input name="rowId" type="hidden" id="rowId"  value="">
				<table border="0" cellspacing="0" cellpadding="0" class="edit-wapper">					
					<tr>						
						<td >
							<div class="mode"><span><label style="color: red;">*</label>省份：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="epuProvince" id="epuProvince" class="text requiredSelect" title="省份">
							
								</select>
							</div>
						</td>
						
						  <td>
							<div class="mode"><span><label style="color: red;">*</label>城市：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="epuCity" id="epuCity" class="text requiredSelect" title="城市">
								</select>
							</div>
						</td>
						
					</tr>
					<tr>
					    <td >
							<div class="mode"><span><label style="color: red;">*</label>区县：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="epuDistrict" id="epuDistrict" class="text requiredSelect" title="区县">
								</select>
							</div>
						</td>
						   <td >
							<div class="mode"><span><label style="color: red;">*</label>设备类型：</span></div>
						</td>
						<td>
							<div class="mode">
								<select name="epuType" id="epuType" class="text requiredSelect" title="设备类型">
								</select>
							</div>
						</td>
					</tr>
					<tr>
					    <td >
							<div class="mode"><span><label style="color: red;">*</label>设备名称：</span></div>
						</td>
						<td >
							<div class="mode"><input name="epuName" id="epuName"   type="text" class="text request" title="设备名称" maxlength="100"></div>
						</td>
						   <td >
							<div class="mode"><span><label style="color: red;">*</label>设备位置：</span></div>
							
						</td>
						<td >							
							<div class="mode"><input name="epuLocal"  id="epuLocal" type="text" class="text request" title="设备位置" maxlength="100">&nbsp;&nbsp;
								<span id='isMapMarkDiv' >
							<a href="javascript:linkMap();" class="but02"  id="butadd" >地图标注</a>
								</span>
							</div>								
							
						</td>
					</tr>
              
                  	<tr id='hiddenParent'>						
						<td >
							<div class="mode"><span><label style="color: red;">*</label>上级设备类型：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="parentEpuType" id="parentEpuType" class="text requiredSelect" title="上级设备类型" disabled="disabled">
							
								</select>
							</div>
						</td>
						 <td >
							<div class="mode"><span><label style="color: red;">*</label>上级设备名称：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="epuParentId" id="epuParentId" class="text requiredSelect" title="上级设备名称">
								</select>
							</div>
						</td>
						
					</tr>		

					  <tr id="hiddenDev">
					    <td >
							<div class="mode"><span><label style="color: red;">*</label>关联终端编号：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="districtId" id="districtId" class="text requiredSelect" title="关联终端编号">
								</select>
							</div>
						</td>
						 <td >
							<div class="mode"><span><label style="color: red;">*</label>关联终端地址号：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="addressId" id="addressId" class="text requiredSelect" title="关联终端地址号">
								</select>
							</div>
						</td>
					</tr>
					<tr  id="hiddenDev1">
					    <td >
							<div class="mode"><span><label style="color: red;">*</label>关联终端通道号：</span></div>
						</td>
						<td >
							<div class="mode">
								<select name="channelId" id="channelId" class="text requiredSelect" title="关联终端通道号">
								</select>
							</div>
						</td>
						 <td >
							<div class="mode"><span><label style="color: red;">*</label>线缆号：</span></div>
						</td>
						<td >
							
						<div class="mode"><input name="lineId" id="lineId"   type="text" class="text request" title="线缆号" maxlength="100"></div>
							
						</td>
					</tr>
					
				</table>
		
			<div class="fast-button">
				<div class="but02" style="text-align: center;">
					<a href="javascript:submitFun('1');" class="but02" id="query">保存</a> 
					<a href="${basePath}/epu/showList.shtml"class="but02"  id="butadd" >返回</a>
				</div>
			</div>

			<!--编辑模块结束/-->
				
					</form>
				</div>
			</div>
		</div>
			
	</body>
</html>