<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>居民列表 —用户中心</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="${basePath}/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="${basePath}/favicon.ico" />
		<link href="${basePath}/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="${basePath}/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="${basePath}/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="${basePath}/js/common/layer/layer.js"></script>
		<script  src="${basePath}/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="${basePath}/js/shiro.demo.js"></script>
		<#-- 3、bootstrap table组件以及中文包的引用 -->
	    <script src="${basePath}/js/common/bootstrap-table/bootstrap-table.js"></script>
	    <link href="${basePath}/js/common/bootstrap-table/bootstrap-table.css" rel="stylesheet" />
	    <script src="${basePath}/js/common/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
	    
	    <#-- 4、页面Js文件的引用 -->
	    <#-- 5,toastr的引用 -->
	    <script src="${basePath}/js/toastr/toastr.min.js"></script>
	    <link href="${basePath}/js/toastr/toastr.css" rel="stylesheet" />
	</head>
    <body data-target="#one" data-spy="scroll">
		
		<@_top.top 2/>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<@_left.member 3/>
				<div class="col-md-10">
					<h2>居民列表</h2>
					<hr>
					<div class="panel-body" style="padding-bottom:0px;">
				        <div class="panel panel-default">
				            <div class="panel-heading">查询条件</div>
				            <div class="panel-body">
				                <form id="formSearch" class="form-horizontal">
				                    <div class="form-group" style="margin-top:15px">
				                        <label class="control-label col-sm-1" for="nickname">昵称</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="nickname" >
				                        </div>
				                        <label class="control-label col-sm-1" for="email">email</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="email">
				                        </div>
				                        <label class="control-label col-sm-1" for="status">登录状态</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control"   id="status">
				                        </div>
				                        <label class="control-label col-sm-1" for="createTime">创建时间</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="createTime">
				                        </div>
				                        <label class="control-label col-sm-1" for="lastLoginTime">最后登录时间</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="lastLoginTime">
				                        </div>
				                        <label class="control-label col-sm-1" for="meter">电表号</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="meter">
				                        </div>


				                    </div>
				                    <div class="form-group" style="margin-top:15px">
				                        <label class="control-label col-sm-1" for="supply">供电单位</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="supply" >
				                        </div>
				                        <label class="control-label col-sm-1" for="location">家庭地址</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="location">
				                        </div>
				                        <label class="control-label col-sm-1" for="housenum">门牌号</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="housenum">
				                        </div>
				                        <label class="control-label col-sm-1" for="sim">SIM卡号</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="sim">
				                        </div>
				                        <label class="control-label col-sm-1" for="absid">绝对编号</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="absid">
				                        </div>
				                        <label class="control-label col-sm-1" for="version">设备版本号</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="version">
				                        </div>

				                    </div>				                    
			                        <div class="" style="text-align:left;">
			                            <label class="control-label col-sm-1" for="id">id</label>
				                        <div class="col-sm-1">
				                            <input type="text" class="form-control" id="id">
				                        </div>
			                            <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
			                        </div>				                    
				                </form>
				            </div>
				        </div>       


				    </div>
					<hr>
				        <div id="toolbar" class="btn-group">
				            <button id="btn_add" type="button" class="btn btn-default">
				                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
				            </button>
				            <button id="btn_edit" type="button" class="btn btn-default">
				                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
				            </button>
				            <button id="btn_delete" type="button" class="btn btn-default">
				                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
				            </button>
				        </div>
				        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" 
												aria-hidden="true">×
										</button>
										<h4 class="modal-title" id="myModalLabel">
											模态框（Modal）标题
										</h4>
									</div>
									<div class="modal-body">
									<#--     <div class="form-group">
										    <label for="txt_departmentname">部门名称</label>
										    <input type="text" name="txt_departmentname" class="form-control" id="txt_departmentname" placeholder="部门名称">
									    </div>	 -->								
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" 
												data-dismiss="modal">关闭
										</button>
										<button type="button" class="btn btn-primary" id="btn_submit">
											提交更改
										</button>
									</div>
								</div><!-- /.modal-content -->
							</div><!-- /.modal-dialog -->
					    </div>
				        <table id="tb_users"></table>										
				</div>
			</div>
		</div>
		<script src="${basePath}/js/common/member/Index.js"></script>	
	</body>
</html>