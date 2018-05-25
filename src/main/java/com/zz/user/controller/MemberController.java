package com.zz.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zz.common.controller.BaseController;
import com.zz.common.model.UUser;
import com.zz.common.utils.Page;
import com.zz.core.mybatis.page.Pagination;
import com.zz.core.shiro.session.CustomSessionManager;
import com.zz.core.shiro.token.manager.TokenManager;
import com.zz.user.bo.UserOnlineBo;
import com.zz.user.service.UUserService;
/**
 * 
 * 
 */
@Controller
@Scope(value="prototype")
@RequestMapping("member")
public class MemberController extends BaseController {
	/***
	 * 用户手动操作Session
	 * */
	@Autowired
	CustomSessionManager customSessionManager;
	@Autowired
	UUserService userService;
	/**
	 * 用户列表管理
	 * @return
	 */
	@RequestMapping(value="list")
	public ModelAndView list(ModelMap map,Integer pageNo,String findContent,HttpServletRequest request	){
		
		map.put("findContent", findContent);
		Pagination<UUser> page = userService.findByPage(map,pageNo,30);
		map.put("page", page);
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("member/list");
		}else{
			//张智 woodareCode begin
			ModelAndView modelAndView = new ModelAndView("woodare/member/list");
			modelAndView.addObject("leftMenuview", "1");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	@RequestMapping(value="list2")
	public ModelAndView list2(ModelMap map,HttpServletRequest request){
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("member/list2");
		}else{
			//张智 woodareCode begin
			//传递查询条件
			this.setQueryParamMap(map,request);
			Pagination<UUser> page = userService.findByPage(map,pageNo,30);
			ModelAndView modelAndView = new ModelAndView("woodare/member/list2");
			modelAndView.addObject("leftMenuview", "1");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			map.put("page", page);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	
	private void setQueryParamMap(ModelMap map,HttpServletRequest request){
		String nickname = request.getParameter("nickname");
		map.put("nickname", nickname);
		String email = request.getParameter("email");
		map.put("email", email);
		String status = request.getParameter("status");
		map.put("status", status);
		String createTime = request.getParameter("createTime");
		map.put("createTime", createTime);
		String lastLoginTime = request.getParameter("lastLoginTime");
		map.put("lastLoginTime", lastLoginTime);
		String meter = request.getParameter("meter");
		map.put("meter", meter);
		String supply = request.getParameter("supply");
		map.put("supply", supply);
		String location = request.getParameter("location");
		map.put("location", location);
		String housenum = request.getParameter("housenum");
		map.put("housenum", housenum);
		String sim = request.getParameter("sim");
		map.put("sim", sim);
		String absid = request.getParameter("absid");
		map.put("absid", absid);
		String version = request.getParameter("version");
		map.put("version", version);
		String id = request.getParameter("id");
		map.put("id", id);
	}
	
	@RequestMapping(value="getUsers",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getUsers(@RequestBody UUser uUser)
   {    System.out.println("------------"+uUser.getStatus()+"------------");
		Page pa = new Page();
		Integer count = userService.findUsersByCount(uUser);
		List<HashMap<String, Object>> list = userService.findUsersBy(uUser);
       	Map<String, Object> map = new HashMap<String, Object>();
//	   Integer count = edataService.findGridCount(opEegrpBO);
//       List<UUser> rows=userService.findUsersBy(entity);
//       Integer total=rows.size();
       map.put("total", count);
       map.put("rows", list);
//		System.out.println("----------------------------------------------------------我进来了");
        return map;
    }
	/**
	 * 在线用户管理
	 * @return
	 */
	@RequestMapping(value="online")
	public ModelAndView online(HttpServletRequest request){
		List<UserOnlineBo> list = customSessionManager.getAllUser();
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("member/online","list",list);
		}else{
			//张智 woodareCode begin
			ModelAndView modelAndView = new ModelAndView("woodare/member/online");
			modelAndView.addObject("leftMenuview", "1");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			modelAndView.addObject("list", list);
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	/**
	 * 在线用户详情
	 * @return
	 */
	@RequestMapping(value="onlineDetails/{sessionId}",method=RequestMethod.GET)
	public ModelAndView onlineDetails(@PathVariable("sessionId")String sessionId,HttpServletRequest request	){
		UserOnlineBo bo = customSessionManager.getSession(sessionId);
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("member/onlineDetails","bo",bo);
		}else{
			//张智 woodareCode begin
			ModelAndView modelAndView = new ModelAndView("woodare/member/onlineDetails");
			modelAndView.addObject("leftMenuview", "1");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			modelAndView.addObject("bo", bo);
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			return modelAndView;
		}
		//张智 woodareCode end
	}
	/**
	 * 改变Session状态
	 * @param status
	 * @param sessionId
	 * @return
	 */
	@RequestMapping(value="changeSessionStatus",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> changeSessionStatus(Boolean status,String sessionIds){
		return customSessionManager.changeSessionStatus(status,sessionIds);
	}
	/**
	 * 根据ID删除，
	 * @param ids	如果有多个，以“,”间隔。
	 * @return
	 */
	@RequestMapping(value="deleteUserById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteUserById(String ids){
		return userService.deleteUserById(ids);
	}
	/**
	 * 禁止登录
	 * @param id		用户ID
	 * @param status	1:有效，0:禁止登录
	 * @return
	 */
	@RequestMapping(value="forbidUserById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> forbidUserById(Long id,Long status){
		return userService.updateForbidUserById(id,status);
	}
	
	/**
	 * 获取居民信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="ajax_getFindUsersBy",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView ajax_getFindUsersBy(Long id){
		ModelAndView modelAndView = new ModelAndView("woodare/member/editInfo");
		UUser uUser  = new UUser();
		if(null != id && !"".equals(id)){
			uUser  = userService.selectByPrimaryKey(id);
		}
		modelAndView.addObject("it", uUser);
		return modelAndView;
	}
	
}
