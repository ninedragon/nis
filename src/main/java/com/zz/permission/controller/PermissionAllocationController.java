package com.zz.permission.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zz.common.controller.BaseController;
import com.zz.common.model.UUser;
import com.zz.core.mybatis.page.Pagination;
import com.zz.core.shiro.token.manager.TokenManager;
import com.zz.permission.bo.RolePermissionAllocationBo;
import com.zz.permission.bo.UPermissionBo;
import com.zz.permission.bo.URoleBo;
import com.zz.permission.service.PermissionService;
import com.zz.permission.service.RoleService;
import com.zz.user.service.UUserService;

@Controller
@Scope(value="prototype")
@RequestMapping("permission")
public class PermissionAllocationController extends BaseController {
	
	@Autowired
	PermissionService permissionService;
	@Autowired
	RoleService roleService;
	@Autowired
	UUserService userService;
	/**
	 * 权限分配
	 * @param modelMap
	 * @param pageNo
	 * @param findContent
	 * @return
	 */
	@RequestMapping(value="allocation")
	public ModelAndView allocation(ModelMap modelMap,Integer pageNo,String findContent,HttpServletRequest request){
		modelMap.put("findContent", findContent);
		Pagination<RolePermissionAllocationBo> boPage = roleService.findRoleAndPermissionPage(modelMap,pageNo,pageSize);
		modelMap.put("page", boPage);
		//张智 woodareCode begin
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("permission/allocation");
		}else{
			ModelAndView modelAndView = new ModelAndView("woodare/permission/allocation");
			modelAndView.addObject("leftMenuview", "2");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("page", boPage);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	
	/**
	 * 根据角色ID查询权限
	 * @param id
	 * @return
	 */
	@RequestMapping(value="selectPermissionById")
	@ResponseBody
	public List<UPermissionBo> selectPermissionById(Long id){
		List<UPermissionBo> permissionBos = permissionService.selectPermissionById(id);
		return permissionBos;
	}
	/**
	 * 操作角色的权限
	 * @param roleId 	角色ID
	 * @param ids		权限ID，以‘,’间隔
	 * @return
	 */
	@RequestMapping(value="addPermission2Role")
	@ResponseBody
	public Map<String,Object> addPermission2Role(Long roleId,String ids){
		return permissionService.addPermission2Role(roleId,ids);
	}
	/**
	 * 根据角色id清空权限。
	 * @param roleIds	角色ID ，以‘,’间隔
	 * @return
	 */
	@RequestMapping(value="clearPermissionByRoleIds")
	@ResponseBody
	public Map<String,Object> clearPermissionByRoleIds(String roleIds){
		return permissionService.deleteByRids(roleIds);
	}
	
	/**
	 * 分配权限信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="control",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView control(Long id){
		ModelAndView modelAndView = new ModelAndView("woodare/permission/control");
		List<UPermissionBo> permissionBosList = permissionService.selectPermissionById(id);
		modelAndView.addObject("permissionBosList", permissionBosList);
		return modelAndView;
	}
}
