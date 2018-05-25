package com.zz.ammeter.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.StringUtils;
import com.zz.ammeter.service.AmmeterService;
import com.zz.common.controller.BaseController;
import com.zz.common.model.TAmmeterInfo;
import com.zz.common.model.TEpuInfo;
import com.zz.common.model.UUser;
import com.zz.common.utils.LoggerUtils;
import com.zz.core.mybatis.page.Pagination;
import com.zz.core.shiro.session.CustomSessionManager;
import com.zz.core.shiro.token.manager.TokenManager;
import com.zz.user.service.UUserService;
@Controller
@Scope(value = "prototype")
@RequestMapping("ammeter")
public class AmmeterController extends BaseController {
	

	/***
	 * 用户手动操作Session
	 * */
	@Autowired
	CustomSessionManager customSessionManager;
	@Autowired
	UUserService userService;
	@Autowired
	AmmeterService ammeterService;

	@RequestMapping(value="showAmList")
	public ModelAndView showList(ModelMap map){	
		
		ModelAndView modelAndView =   new ModelAndView("woodare/am/showAmList");
		modelAndView.addObject("leftMenuview", "4");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
		UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
		modelAndView.addObject("token", token);//左侧上方管理员信息
		return modelAndView;
	}
	@RequestMapping("selectEpuNameByAm")
	@ResponseBody
	public Object selectEpuNameByAm(ModelMap map,
			TEpuInfo tEpuInfo, HttpServletRequest request,String epuDistrict)
			throws Exception {
		Map<String, Object> epuInof = ammeterService.selectEpuNameByAm(epuDistrict);
		return epuInof;
	}
	
	/**
	 * 查询电表列表管理
	 * @return
	 */
	@RequestMapping("queryEpuList")
	public @ResponseBody Map<String,Object> queryEpuList(Integer pageNo,Integer pageSize,HttpServletRequest request,ModelMap map,TAmmeterInfo ammeterInfo) {
		
		map.put("epuProvince", ammeterInfo.getEpuProvince());
		map.put("epuCity", ammeterInfo.getEpuCity());
		map.put("epuDistrict", ammeterInfo.getEpuDistrict());
		map.put("ammeterName", ammeterInfo.getAmmeterName());
		map.put("findContent", ammeterInfo.getDistrictId());
		Pagination<TAmmeterInfo> page = ammeterService.findByPage(map,pageNo,pageSize);
		Map<String, Object> mapReturn  = new HashMap<String, Object>();
		mapReturn.put("page", page);
		return mapReturn;
	}
	
	@RequestMapping(value="addAm")
	public ModelAndView addEpu(ModelMap map){		
		return new ModelAndView("ammeter/addAm");
	}
	

	@RequestMapping("updateEpuInfo")
	@ResponseBody
	public Map<String,Object> updateEpuInfo(TAmmeterInfo ammeterInfo, HttpServletRequest request){
		 Map<String, Object> retureMap=new HashMap<String,Object>();
		try {
			Long userId = TokenManager.getUserId();
			String rowId=ammeterInfo.getRowId();
			String flag="0";//0:插入 1：更新
			if(StringUtils.isEmpty(rowId))
			{
				rowId=UUID.randomUUID().toString();
				ammeterInfo.setCreateId(userId+"");
				ammeterInfo.setUpdateId(userId+"");
				ammeterInfo.setRowId(rowId);
			}
			else
			{
				flag="1";
				ammeterInfo.setUpdateId(userId+"");
			}
			
			 retureMap=ammeterService.updateEpuInfo(ammeterInfo,flag);
			 retureMap.put("rowId", rowId);
		} catch (Exception e) {
			retureMap.put("status", 0);
			logger.error("errorMessage:" + e.getMessage());
			LoggerUtils.fmtError(getClass(), e, "更新数据失败，%s。", e.getMessage());
		}
		return retureMap;
	}
	
	
	@RequestMapping("delEpuInfo")
	@ResponseBody
	public Map<String,Object> delEpuInfo(String rowIds, HttpServletRequest request){
		 Map<String, Object> retureMap=new HashMap<String,Object>();
			retureMap=ammeterService.delEpuInfoById(rowIds);
		return retureMap;
	}
	
	
	@RequestMapping("editInit")
	@ResponseBody
	public Object editInit(HttpServletRequest request,HttpSession session,String rowId) {
		List <TAmmeterInfo> epuInfo= ammeterService.selectEpuInfoByRowId(rowId,"");	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuInfo", epuInfo.get(0));
		return map;
	}
}
