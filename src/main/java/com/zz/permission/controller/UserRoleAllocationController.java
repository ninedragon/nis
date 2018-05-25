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
import com.zz.permission.bo.URoleBo;
import com.zz.permission.bo.UserRoleAllocationBo;
import com.zz.permission.service.PermissionService;
import com.zz.user.service.UUserService;

@Controller
@Scope(value="prototype")
@RequestMapping("role")
public class UserRoleAllocationController extends BaseController {
	@Autowired
	UUserService userService;
	@Autowired
	PermissionService permissionService;
	/**
	 * 用户角色权限分配
	 * @param modelMap
	 * @param pageNo
	 * @param findContent
	 * @return
	 */
	@RequestMapping(value="allocation")
	public ModelAndView allocation(ModelMap modelMap,Integer pageNo,String findContent,HttpServletRequest request){
		modelMap.put("findContent", findContent);
		Pagination<UserRoleAllocationBo> boPage = userService.findUserAndRole(modelMap,pageNo,pageSize);
		modelMap.put("page", boPage);
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("role/allocation");
		}else{
			ModelAndView modelAndView = new ModelAndView("woodare/role/allocation");
			modelAndView.addObject("leftMenuview", "2");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("page", boPage);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	
	/**
	 * 根据用户ID查询权限
	 * @param id
	 * @return
	 */
	@RequestMapping(value="selectRoleByUserId")
	@ResponseBody
	public List<URoleBo> selectRoleByUserId(Long id){
		List<URoleBo> bos = userService.selectRoleByUserId(id);
		return bos;
	}
	/**
	 * 操作用户的角色
	 * @param userId 	用户ID
	 * @param ids		角色ID，以‘,’间隔
	 * @return
	 */
	@RequestMapping(value="addRole2User")
	@ResponseBody
	public Map<String,Object> addRole2User(Long userId,String ids){
		return userService.addRole2User(userId,ids);
	}
	/**
	 * 根据用户id清空角色。
	 * @param userIds	用户ID ，以‘,’间隔
	 * @return
	 */
	@RequestMapping(value="clearRoleByUserIds")
	@ResponseBody
	public Map<String,Object> clearRoleByUserIds(String userIds){
		return userService.deleteRoleByUserIds(userIds);
	}
	
	
	/**
	 * 分配角色信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="allotRole",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView allotRole(Long id){
		ModelAndView modelAndView = new ModelAndView("woodare/role/allotRole");
		List<URoleBo> bosList = userService.selectRoleByUserId(id);
		modelAndView.addObject("bosList", bosList);
		return modelAndView;
	}
	
}
