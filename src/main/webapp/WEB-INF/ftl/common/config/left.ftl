<#macro user index>
<div id="one" class="col-md-2">
	<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
	  <li class="${(index==1)?string('active',' ')}">
	      <a href="${basePath}/user/index.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>个人资料
	      </a>
	       <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-left: 160px; margin-top: -40px;">
              <li><a href="${basePath}/user/updateSelf.shtml">资料修改</a></li>
              <li><a href="${basePath}/user/updatePswd.shtml">密码修改</a></li>
          </ul>
	  </li>
	  <li class="${(index==2)?string('active',' ')} dropdown">
	      <a href="${basePath}/role/mypermission.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>我的权限
	      </a>
	  </li>
	</ul>
</div>
</#macro>
<#macro member index>
	<@shiro.hasAnyRoles name='888888,100001'>          
		<div  id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/member/list.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>管理列表
			      </a>
			  </li>
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/member/online.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>在线用户
			      </a>
			  </li>
			  <li class="${(index==3)?string('active',' ')}">
			      <a href="${basePath}/member/list2.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>居民列表
			      </a>
			  </li>
			</ul>
		</div>
	</@shiro.hasAnyRoles>         
</#macro>
<#macro role index>
	<@shiro.hasAnyRoles name='888888,100001'>  
		<div id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			 
			 <@shiro.hasPermission name="/role/index.shtml">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/role/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/role/allocation.shtml">
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/role/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>角色分配
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/index.shtml">
			  <li class="${(index==3)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/index.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/permission/allocation.shtml">
			  <li class="${(index==4)?string('active',' ')} dropdown">
			      <a href="${basePath}/permission/allocation.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>权限分配
			      </a>
			  </li>
			  </@shiro.hasPermission>
			</ul>
		</div>
	</@shiro.hasAnyRoles>   

</#macro>
<#macro edata index>
	<@shiro.hasAnyRoles name='888888,100001,200001'>  
		<div id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			 
			 <@shiro.hasPermission name="/edata/zong.shtml">
			  <li class="${(index==1)?string('active',' ')}">
			      <a href="${basePath}/edata/zong.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>总体能耗数据
			      </a>
			  </li>
			  </@shiro.hasPermission>
			 <@shiro.hasPermission name="/edata/fenxiang.shtml">
			  <li class="${(index==2)?string('active',' ')} dropdown">
			      <a href="${basePath}/edata/fenxiang.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>分项能耗数据
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/edata/yuanshi.shtml">
			  <li class="${(index==5)?string('active',' ')}">
			      <a href="${basePath}/edata/yuanshi.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>原始上传数据
			      </a>
			  </li>
			  </@shiro.hasPermission>
			  <@shiro.hasPermission name="/edata/yuanshij.shtml">
			  <li class="${(index==6)?string('active',' ')}">
			      <a href="${basePath}/edata/yuanshij.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>原始上传数据-阶跃
			      </a>
			  </li>
			  </@shiro.hasPermission>
			</ul>
		</div>
	</@shiro.hasAnyRoles>   
</#macro>

<#macro edata index>
	<@shiro.hasAnyRoles name='888888,100001,200001'>  
		<div id="one" class="col-md-2">
			<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
			 
			 <@shiro.hasPermission name="/edata/zong.shtml">
			  <li class="${(index==1)?string('active',' ')}">
			          <a href="${basePath}/epu/showList.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>设备信息列表
			      </a>
			  </li>
			   <li class="${(index==2)?string('active',' ')}">
			      <a href="${basePath}/ammeter/showAmList.shtml">
			    	 <i class="glyphicon glyphicon-chevron-right"></i>设备信息列表
			      </a>
			  </li>
			  </@shiro.hasPermission>
			</ul>
		</div>
	</@shiro.hasAnyRoles>   
</#macro>

