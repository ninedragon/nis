<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>电表信息列表</title>
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
				// initEpuType();
				registEvent();
				initList();
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
			/*  function initEpuType() {
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
		                    for (var i = 0; i < length; i++) {
		                        $('#epuType').append('<option value="' + a.epuTypeBean[i].code + '">' + a.epuTypeBean[i].codeName + '</option>');
		                    }
		                }
		            });
			}; */
			
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
				 
			 };
			 function editEpuInfo(rowId) {				 
				 window.location="${basePath}/ammeter/editInit.shtml?rowId=" + rowId;
			 };
			function delEpuInfo(rowId) {				
				if(confirm('确实要删除该内容吗?')){
	   				  $("#loadingDiv").show();
	   				 $.ajax({
	   		  			    url:"${basePath}/ammeter/delEpuInfo.shtml",
	   		  			    type:'POST',
	   		  			    dataType:'json',
	   		  			    data:{rowId:rowId},
	   		  			    success:function(data){
	   		  			    	if(data.error=="删除失败!"){
	   		  			    	layer.msg(data.error,function(){});
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}else{ 
	   		  			     	layer.msg("删除成功!",function(){});
	   		  					 window.location="${basePath}/ammeter/showAmList.shtml";
	   		  			    	$("#loadingDiv").hide();
	   		  			    	}
	   		  			    }
	   		  			    
	   		  			  });
	   			  }
				 

			 };
			  function initList() {
			    	 $("#loadingDiv").show(); 

			        $.ajax({
			            url: "${basePath}/ammeter/queryEpuList.shtml",
			            type: 'POST',
			            dataType: 'json',
			            async:false,
			            data: {			          
			            	epuProvince: $("#epuProvince").val(),
			            	epuCity: $("#epuCity").val(),
			            	epuDistrict: $("#epuDistrict").val(),
			            	ammeterName: $("#ammeterName").val(),
			                districtId: $("#districtId").val()
			            },
			            success: function (data) {
			            	var page=data.page;
			                if (page != null ) {
			                    var epuList = page.list;
			                    if (epuList!=null && epuList.length>0) {
			                        var tbody = '';
			                        for (var i = 0; i < epuList.length; i++) {			                            
			       
			                            tbody += '<tr>';
			                            tbody += '<td><div><a href="javascript:editEpuInfo(\''+epuList[i].rowId+'\');">编辑</a>&nbsp;&nbsp;<a href="javascript:delEpuInfo(\''+epuList[i].rowId+'\');">删除</a>';
			                     
			             
			                             tbody += '<td><div>' + epuList[i].epuProvinceName+ '</div></td>';
			                            tbody += '<td><div>' + epuList[i].epuCityName + '</div></td>';
			                            tbody += '<td><div>' + epuList[i].epuDistrictName+ '</div></td>';			                        			                            
			                            tbody += '<td><div>' + epuList[i].ammeterName+ '</div></td>';
			                            tbody += '<td><div>' +epuList[i].epuName + '</div></td>';
			                            tbody += '<td><div>' +epuList[i].districtId+((epuList[i].addressId==null || epuList[i].addressId=='' )?'':"-" +epuList[i].addressId) +((epuList[i].channelId==null || epuList[i].channelId=='' )?'':"-" +epuList[i].channelId)+ '</div></td>';			                          
			                            tbody += '<td><div></div></td>'; 
			                            tbody += '</tr>';
			                            
			                        }
			                        $("#epuListTable").html(tbody);
			                        $(".pagination").html(page.pageHtml);
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
	</head>
	<body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 1/>
				<div class="col-md-10">
					<h2>电表信息列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
									<!--编辑模块开始-->
			<div class="search">
				<div class="mode">省份
					<span>:</span> <select
						name="epuProvince" id="epuProvince">
            
					</select>
				</div>
				<div class="mode">城市
					<span>:</span> <select
						name="epuCity" id="epuCity">

					</select>
				</div>
				<div class="mode">区县
					<span>:</span><select
						name="epuDistrict" id="epuDistrict">

					</select>
				</div>
				<div class="mode">设备名称 
					<span>:</span>
					<input name="ammeterName" type="text" class="text" id="ammeterName">
				</div>
				
				<div class="mode">关联终端
					<span>:</span>
					<input
						name="districtId" type="text" class="text" id="districtId">
				</div>
				
				<div class="but02" style="text-align: center;">
					<a href="javascript:initList();" class="but02" id="query">查询</a> 
					<a href="${basePath}/ammeter/addAm.shtml"class="but02"  id="butadd" >新增</a>
				</div>
			</div>
			<div class="fast-button">
				
			</div>

			<!--编辑模块结束/-->
					<hr>
					<table class="table table-bordered">
						<tr>
							<th >操作</th>
							<th>省份</th>
							<th>城市</th>
							<th>区县</th>
							<th>设备名称</th>
							<th>上级设备</th>
							<th>终端设备</th>												
							<th>状态</th>
						</tr>
						<tbody id="epuListTable"></tbody>
					</table>
					<div class="pagination pull-right">
					
						</div>
				
					</form>
				</div>
			</div>
		</div>
			
	</body>
</html>