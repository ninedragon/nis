package com.zz.edata.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.zz.common.controller.BaseController;
import com.zz.common.model.Deviceinfo;
import com.zz.common.model.Eeclassification;
import com.zz.common.model.Eeclassificationgrp;
import com.zz.common.model.Opdata;
import com.zz.common.model.UUser;
import com.zz.common.utils.Page;
import com.zz.core.mybatis.page.Pagination;
import com.zz.core.shiro.token.manager.TokenManager;
import com.zz.edata.bo.EquxianBo;
import com.zz.edata.bo.OpEegrpBO;
import com.zz.edata.bo.SqltoolBO;
import com.zz.edata.bo.SqltoolJBO;
import com.zz.edata.bo.SubcompareBO;
import com.zz.edata.service.EdataService;
import com.zz.user.service.UUserService;

@Controller
@Scope(value = "prototype")
@RequestMapping("edata")
public class EdataController extends BaseController {

	@Autowired
	EdataService edataService;
	@Autowired
	UUserService userService; 
	private String filename;

	/**
	 * 
	 * @param modelMap
	 * @param pageNo
	 * @param findContent
	 * @return
	 */
	// 1.处理总体用电数据controller
	@RequestMapping(value = "zong")
	public ModelAndView zong(ModelMap modelMap,HttpServletRequest request) {
		List<Deviceinfo> dlist = edataService.findAllDistrict();
		List<Eeclassificationgrp> eglist = edataService.findAllGroup();
		modelMap.put("dlist", dlist);
		modelMap.put("eglist", eglist);
		List<String> filelist = edataService.listFilePath();
		modelMap.put("filelist", filelist);
//		张智 woodareCode begin
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("edata/zong");
		}else{
//			ModelAndView modelAndView = new ModelAndView("edata/zongIndex");
			ModelAndView modelAndView = new ModelAndView("woodare/edata/zong");
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("leftMenuview", "3");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			List<Map<String, Object>> timeList = new ArrayList<Map<String, Object>>();
			for (int i = 0; i < 97; i++) {
				int ivalue= i / 4;
				String numStr1 = "" + ivalue;
				if(ivalue <= 9){
					numStr1 = "0" + ivalue;
				}
				Map<String, Object>  map= new HashMap<String, Object>();
				map.put("numStr1", numStr1);
				int itemp = (i%4) * (15);
				String numStr2 = ""+ itemp;
				if(itemp == 0){
					numStr2 = "00";
				}
				map.put("count", i);
				map.put("dateHm", numStr1 +":"+numStr2);
				timeList.add(map);
			}
			modelAndView.addObject("timeList", timeList);
			return modelAndView;
		}
	}
	// 【1.1】得到有日期的数据
	
	@RequestMapping(value = "listRecorddate", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> listRecorddate(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.listRecorddate(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getZongdata", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getZongdata(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.getZongData(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getPower", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getPower(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.getPower(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getFendata", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendata(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findfenData(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getGriddata", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getGrid(OpEegrpBO opEegrpBO) {

		// 1.处理adress为了把界面不符合规范的查询条件处理
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findGridCount(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService.findGrid(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		return map;
	}

	private void dealPage(OpEegrpBO opEegrpBO, Page pa, Integer count) {
		pa.setTotalNumber(count);
		pa.setPageNumber(opEegrpBO.getLimit());
		pa.setCurrentPage(opEegrpBO.getPage());
		pa.count();
		// 3.输入相关参数得到limit的offindex和数量
		opEegrpBO.setStartindex(pa.getDbIndex());
		opEegrpBO.setLimit(opEegrpBO.getLimit());
	}

	private void dealADR(OpEegrpBO opEegrpBO) {
		String districtid = opEegrpBO.getcDistrictbcdid().substring(0, 4);
		int addressid = Integer.parseInt(opEegrpBO.getcDistrictbcdid()
				.substring(5));
		opEegrpBO.setcDistrictbcdid(districtid);
		opEegrpBO.setcAddressid(addressid);
		if(null!=opEegrpBO.getcRecorddatebcd()){
		String cr = opEegrpBO.getcRecorddatebcd().replace("-", "").substring(2);
		opEegrpBO.setcRecorddatebcd(cr);}
	}

	private void dealADR(SubcompareBO subcompareBO) {
		String districtid = subcompareBO.getcDistrictbcdid().substring(0, 4);
		String addressid = subcompareBO.getcDistrictbcdid().substring(5);
		subcompareBO.setcDistrictbcdid(districtid);
		subcompareBO.setcAddressId(addressid);
		String cr = subcompareBO.getcRecorddatebcd().replace("-", "")
				.substring(2);
		subcompareBO.setcRecorddatebcd(cr);
	}

	// //2.处理分项能耗数据controller
	@RequestMapping(value = "fenxiang")
	public ModelAndView fenxiang(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO,HttpServletRequest request) {
		// 目的：做判断是为了防止没有输入值，一开始是出于两个功能的考虑，现在好像没必要
		// if (opEegrpBO.getcAddressid() == null
		// && opEegrpBO.getcChannelid() == null
		// && opEegrpBO.getcEegrpid() == null
		// && opEegrpBO.getcRecordinserttime() == null) {
		List<Deviceinfo> dlist = edataService.findAllDistrict();
		List<Eeclassificationgrp> eglist = edataService.findAllGroup();
		modelMap.put("dlist", dlist);
		modelMap.put("eglist", eglist);
		
//		张智 woodareCode begin
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("edata/fenxiang");
		}else{
			ModelAndView modelAndView = new ModelAndView("woodare/edata/fenxiang");
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("leftMenuview", "3");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			List<Map<String, Object>> timeList = new ArrayList<Map<String, Object>>();
			for (int i = 0; i < 97; i++) {
				int ivalue= i / 4;
				String numStr1 = "" + ivalue;
				if(ivalue <= 9){
					numStr1 = "0" + ivalue;
				}
				Map<String, Object>  map= new HashMap<String, Object>();
				map.put("numStr1", numStr1);
				int itemp = (i%4) * (15);
				String numStr2 = ""+ itemp;
				if(itemp == 0){
					numStr2 = "00";
				}
				map.put("count", i);
				map.put("dateHm", numStr1 +":"+numStr2);
				timeList.add(map);
			}
			modelAndView.addObject("timeList", timeList);
			return modelAndView;
		}
//		张智 woodareCode end
		// } else {
		// List<Deviceinfo> dlist = edataService.findAllDistrict();
		// List<Eeclassificationgrp> eglist = edataService.findAllGroup();
		// dealADR(opEegrpBO);
		// List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
		// modelMap.put("olist", olist);
		// modelMap.put("dlist", dlist);
		// modelMap.put("eglist", eglist);
		// return new ModelAndView("edata/fenxiang");
		// }
	}

	@RequestMapping(value = "getFendataDraw", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendataDraw(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findFendataDraw(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getPowerEE", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getPowerEE(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.getPowerEE(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getFendataOriTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getFendataOriTable(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findGridCountV22(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findGridV22(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		return map;
	}

	@RequestMapping(value = "getFendata2", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendata2(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findfenData(opEegrpBO);
		return list;
	}

	@RequestMapping(value = "getQitingTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getQitingTable(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findQitingTableCount(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findQitingTable(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		return map;
	}

	@RequestMapping(value = "getGriddataF", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getGridF(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.findGrid(opEegrpBO);
		return list;
	}

	// 3.处理原始上传数据Controller
	@RequestMapping(value = "yuanshi")
	public ModelAndView yuanshi(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO,HttpServletRequest request) {
		List<Deviceinfo> dlist = edataService.findAllDistrict();
		List<Eeclassificationgrp> eglist = edataService.findAllGroup();
		modelMap.put("dlist", dlist);
		modelMap.put("eglist", eglist);
		modelMap.put("testinfo", "testinfo");
//		return new ModelAndView("edata/yuanshi");
//		张智 woodareCode begin
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("edata/yuanshi");
		}else{
			ModelAndView modelAndView = new ModelAndView("woodare/edata/yuanshi");
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("leftMenuview", "3");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			List listEE = edataService.listEE();
			modelAndView.addObject("listEE", listEE);
			List<Map<String, Object>> timeList = new ArrayList<Map<String, Object>>();
			String numStr1 = "";
			String numStr2 = "";
			String numStr3 = "";
			for (int i = 1; i <= 96; i++) {
				int ivalue= i / 4;
				numStr1 = "" + ivalue;
				if(ivalue <= 9){
					numStr1 = "0" + ivalue;
				}
				Map<String, Object>  map= new HashMap<String, Object>();
				map.put("numStr1", numStr1);
				int itemp = (i%4) * (15);
				numStr2 = ""+ itemp;
				if(itemp == 0){
					numStr2 = "00";
				}
				numStr3 = ""+ i;
				if(i <= 9){
					numStr3 = "0"+i;
				}
				map.put("count", i);
				map.put("dateHm", numStr3 + "-[" + numStr1 +":" + numStr2 +"]");
				timeList.add(map);
			}
			modelAndView.addObject("timeList", timeList);
			return modelAndView;
		}
//		张智 woodareCode end
	}

	@RequestMapping(value = "getYuanshiV31", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYuanshiV31(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findYuanshiCountV31(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findYuanshiV31(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		return map;
	}

	// 4.处理原始上传阶跃数据Controller
	@RequestMapping(value = "yuanshij")
	public ModelAndView yuanshij(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO,HttpServletRequest request) {
		if (opEegrpBO.getcAddressid() == null
				&& opEegrpBO.getcChannelid() == null
				&& opEegrpBO.getcEegrpid() == null
				&& opEegrpBO.getcRecordinserttime() == null) {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			modelMap.put("testinfo", "testinfo");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
		}
//		return new ModelAndView("edata/yuanshij");
//		张智 woodareCode begin
		String action = request.getParameter("action");
		if("yes".equals(action)){//原始
			return new ModelAndView("edata/yuanshij");
		}else{
			ModelAndView modelAndView = new ModelAndView("woodare/edata/yuanshij");
			UUser token =  userService.selectByPrimaryKey(TokenManager.getToken().getId());
			modelAndView.addObject("token", token);
			modelAndView.addObject("leftMenuview", "3");//显示左侧菜单 0 个人中心 1用户中心 2 权限管理 3用电曲线数据 4设备管理 5实时监控
			List listEE = edataService.listEE();
			modelAndView.addObject("listEE", listEE);
			List<Map<String, Object>> timeList = new ArrayList<Map<String, Object>>();
			String numStr1 = "";
			String numStr2 = "";
			String numStr3 = "";
			for (int i = 1; i <= 96; i++) {
				int ivalue= i / 4;
				numStr1 = "" + ivalue;
				if(ivalue <= 9){
					numStr1 = "0" + ivalue;
				}
				Map<String, Object>  map= new HashMap<String, Object>();
				map.put("numStr1", numStr1);
				int itemp = (i%4) * (15);
				numStr2 = ""+ itemp;
				if(itemp == 0){
					numStr2 = "00";
				}
				numStr3 = ""+ i;
				if(i <= 9){
					numStr3 = "0"+i;
				}
				map.put("count", i);
				map.put("dateHm", numStr3 + "-[" + numStr1 +":" + numStr2 +"]");
				timeList.add(map);
			}
			modelAndView.addObject("timeList", timeList);
			return modelAndView;
		}
//		张智 woodareCode end
	}

	@RequestMapping(value = "getYuanshiV41", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYuanshiV41(OpEegrpBO opEegrpBO) {
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findYuanshiCountV41(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findYuanshiV41(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		return map;
	}

	// end
	// 5.算法分析Controller
	@RequestMapping(value = "suanfa")
	public ModelAndView suanfa(ModelMap modelMap, OpEegrpBO opEegrpBO) {

		if (opEegrpBO.getcEehexid() == null && opEegrpBO.getcParaid() == null) {
			List<Eeclassification> eglist = edataService.findAllEE();
			modelMap.put("eglist", eglist);
			return new ModelAndView("edata/suanfa");
		} else {
			List<Eeclassification> eglist = edataService.findAllEE();
			modelMap.put("eglist", eglist);
			return new ModelAndView("edata/suanfa");
		}
	}

	//
	@RequestMapping(value = "getV51", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getV51(OpEegrpBO opEegrpBO, String page,
			String limit) {
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		dealPage(opEegrpBO, pa, 100000);
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		opEegrpBO.setVersion11(opEegrpBO.getVersion1() + 10000);
		opEegrpBO.setVersion21(opEegrpBO.getVersion2() + 10000);

		// 测试开始，
		// HashMap<String, Object> map3 = new HashMap<String, Object>();
		//
		// map2.put("jump15", "200");
		// map2.put("jump17", "201");
		// map2.put("cDistrictbcdid", "540");
		// map2.put("cAddressid", "176");
		// map2.put("cChannelid", "3");
		// map2.put("cRecordDateBCD", "170814");
		//
		// map3.put("jump15", "200");
		// map3.put("jump17", "201");
		// map3.put("cDistrictbcdid", "2540");
		// map3.put("cAddressid", "176");
		// map3.put("cChannelid", "3");
		// map3.put("cRecordDateBCD", "170814");
		//
		//
		// List<HashMap<String, Object>> list = new ArrayList<HashMap<String,
		// Object>>();
		// list.add(map2);
		// list.add(map3);
		// 测试结束
		if (page.equals("1")) {
			List<HashMap<String, Object>> alllist = edataService
					.findSuanfaV51(opEegrpBO);
			Map<String, Object> map = new HashMap<String, Object>();
			TokenManager.setVal2Session("alllist", alllist);
			List<HashMap<String, Object>> list = new ArrayList();
			for (int i = 0; i < Integer.parseInt(limit); i++) {
				list.add(alllist.get(i));
			}
			map.put("data", list);
			map.put("code", "0");
			map.put("msg", "");
			map.put("count", alllist.size());
			return map;
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			List<HashMap<String, Object>> alllist = (List<HashMap<String, Object>>) TokenManager
					.getVal2Session("alllist");
			List<HashMap<String, Object>> list = new ArrayList();
			if (Integer.parseInt(limit) * Integer.parseInt(page) <= alllist
					.size()) {
				for (int i = Integer.parseInt(limit)
						* (Integer.parseInt(page) - 1); i < Integer
						.parseInt(limit) * Integer.parseInt(page); i++) {
					list.add(alllist.get(i));
				}
			} else {
				for (int i = Integer.parseInt(limit)
						* (Integer.parseInt(page) - 1); i < alllist.size(); i++) {
					list.add(alllist.get(i));
				}
			}
			map.put("data", list);
			map.put("code", "0");
			map.put("msg", "");
			map.put("count", alllist.size());
			return map;
		}

	}

	// 6.算法分析sqlController
	@RequestMapping(value = "suanfa2")
	public ModelAndView suanfa2(ModelMap modelMap, String sql) {
		return new ModelAndView("edata/suanfa2");

		// if (opEegrpBO.getcEehexid() == null && opEegrpBO.getcParaid() ==
		// null) {
		// List<Eeclassificationgrp> eglist = edataService.findAllEE();
		// modelMap.put("eglist", eglist);
		// return new ModelAndView("edata/suanfa2");
		// } else {
		// List<Eeclassificationgrp> eglist = edataService.findAllEE();
		// modelMap.put("eglist", eglist);
		// return new ModelAndView("edata/suanfa2");
		// }
	}

	// 6.1算法自动化sql查询得到表
	@RequestMapping(value = "getV61", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getV61(OpEegrpBO opEegrpBO, String page,
			String limit) {
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		dealPage(opEegrpBO, pa, 100000);
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		if (page.equals("1")) {
			List<LinkedHashMap<String, Object>> alllist = edataService
					.findSuanfaV61(opEegrpBO);
			Map<String, Object> map = new HashMap<String, Object>();
			TokenManager.setVal2Session("alllist", alllist);
			List<HashMap<String, Object>> list = new ArrayList();
			for (int i = 0; i < (alllist.size()); i++) {
				list.add(alllist.get(i));
			}
			map.put("data", list);
			map.put("code", "0");
			map.put("msg", "");
			map.put("count", alllist.size());
			return map;
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			List<LinkedHashMap<String, Object>> alllist = (List<LinkedHashMap<String, Object>>) TokenManager
					.getVal2Session("alllist");
			List<HashMap<String, Object>> list = new ArrayList();
			if (Integer.parseInt(limit) * Integer.parseInt(page) <= alllist
					.size()) {
				for (int i = Integer.parseInt(limit)
						* (Integer.parseInt(page) - 1); i < Integer
						.parseInt(limit) * Integer.parseInt(page); i++) {
					list.add(alllist.get(i));
				}
			} else {
				for (int i = Integer.parseInt(limit)
						* (Integer.parseInt(page) - 1); i < alllist.size(); i++) {
					list.add(alllist.get(i));
				}
			}
			map.put("data", list);
			map.put("code", "0");
			map.put("msg", "");
			map.put("count", alllist.size());
			return map;
		}

	}

	@RequestMapping(value = "listSuanfaResult", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listSuanfaResult(@RequestBody OpEegrpBO opEegrpBO) {
		//【1】处理sql语句
		String sql = opEegrpBO.getSql();
		if (sql.endsWith(";")) {
			sql = sql.substring(0, sql.length() - 2);
		}
		opEegrpBO.setSql(sql);
		//【2】执行得到结果
		List<LinkedHashMap<String, Object>> list = edataService
				.listSuanfaResult(opEegrpBO);
		//【3】分页和相关结果返回
		Integer count = list.size();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", list);
		return map;
	}

	// 6.2下载文件
	@RequestMapping(value = "/downloadfile0")
	public ResponseEntity<byte[]> downloadfile(Model model) throws Exception {
		// 下载文件路径
		String path = "";
		filename = "D:\\录波数据\\苏州夏季\\录波数据算法\\I_2-4.txt";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String(filename.getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/downloadfile1")
	public ResponseEntity<byte[]> downloadfile1(Model model) throws Exception {
		// 下载文件路径
		String path = "";
		filename = "D:\\录波数据\\苏州夏季\\录波数据算法\\P-0.txt";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String("P-0.txt".getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/downloadfile2")
	public ResponseEntity<byte[]> downloadfile2(Model model) throws Exception {
		// 下载文件路径
		String path = "";
		filename = "D:\\录波数据\\苏州夏季\\录波数据算法\\Q-0.txt";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String("Q-0.txt".getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/downloadfile3")
	public ResponseEntity<byte[]> downloadfile3(Model model, String pathSave)
			throws Exception {
		// 下载文件路径
		String path = "";
		filename = "D:\\录波数据\\苏州夏季\\录波数据算法" + "\\I_2-0.txt";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String("I_2-0.txt".getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/downloadfile4")
	public ResponseEntity<byte[]> downloadfile4(Model model) throws Exception {
		// 下载文件路径
		String path = "";
		filename = "D:\\录波数据\\苏州夏季\\录波数据算法\\I_3-0.txt";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String("I_3-0.txt".getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "getTest", method = RequestMethod.POST)
	@ResponseBody
	public String getTest(@RequestParam("file") MultipartFile file) {
		if (!file.isEmpty()) {
			try {
				// 文件存放服务端的位置
				String rootPath = "d:/tmp";
				File dir = new File(rootPath + File.separator + "tmpFiles");
				if (!dir.exists())
					dir.mkdirs();
				// 写文件到服务器
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + file.getOriginalFilename());
				file.transferTo(serverFile);
				return "You successfully uploaded file="
						+ file.getOriginalFilename();
			} catch (Exception e) {
				return "You failed to upload " + file.getOriginalFilename()
						+ " => " + e.getMessage();
			}
		} else {
			return "You failed to upload " + file.getOriginalFilename()
					+ " because the file was empty.";
		}
	}

	/**
	 * 没发现有什么用，不影响的话删除
	 * 
	 * @param opEegrpBO
	 * @param jump
	 * @return
	 */
	// @RequestMapping(value = "getV52Remote", method = RequestMethod.POST)
	// @ResponseBody
	// public List<HashMap<String, Object>> getV52Remote(
	// @RequestParam("file") MultipartFile file, Integer jump15) {
	// List<HashMap<String, Object>> v52list = edataService.dealFile(file,
	// jump15);
	// return v52list;
	// // if (!file.isEmpty()) {
	// // try {
	// // // 文件存放服务端的位置
	// // String rootPath = "d:/tmp";
	// // File dir = new File(rootPath + File.separator + "tmpFiles");
	// // if (!dir.exists())
	// // dir.mkdirs();
	// // // 写文件到服务器
	// // File serverFile = new File(dir.getAbsolutePath() + File.separator +
	// // file.getOriginalFilename());
	// // file.transferTo(serverFile);
	// // return "You successfully uploaded file=" +
	// // file.getOriginalFilename();
	// // } catch (Exception e) {
	// // return "You failed to upload " + file.getOriginalFilename() + " => "
	// // + e.getMessage();
	// // }
	// // } else {
	// // return "You failed to upload " + file.getOriginalFilename() +
	// // " because the file was empty.";
	// // }
	// }

	/**
	 * @param opEegrpBO  处理算法的BO
	 * @param jump  jumpsecond
	 * @return   画图的数据
	 */
	@RequestMapping(value = "getV52", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getV52(OpEegrpBO opEegrpBO, String jump) {
		
		String recordDate = opEegrpBO.getcRecorddatebcd();
		if(recordDate.contains("-")&&recordDate.length()==10){
		opEegrpBO.setcRecorddatebcd(recordDate.substring(2).replace("-", ""));}
		HashMap<String, Object> v52map = new HashMap();
		v52map = edataService.listChartData(opEegrpBO, jump);
		return v52map;
	}

	@RequestMapping(value = "equxian")
	public ModelAndView equxian(ModelMap modelMap, Integer pageNo,
			String findContent) {
		modelMap.put("findContent", findContent);
		Pagination<EquxianBo> boPage = edataService.findEquxianPage(modelMap,
				pageNo, pageSize);
		modelMap.put("page", boPage);
		return new ModelAndView("edata/equxian");
	}

	// 7.自比对分析
	@RequestMapping(value = "selfcompare")
	public ModelAndView selfcompare(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO) {
		// 目的：做判断是为了防止没有输入值，一开始是出于两个功能的考虑，现在好像没必要
		if (opEegrpBO.getcAddressid() == null
				&& opEegrpBO.getcChannelid() == null
				&& opEegrpBO.getcEegrpid() == null
				&& opEegrpBO.getcRecordinserttime() == null) {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			modelMap.put("testinfo", "testinfo");
			return new ModelAndView("edata/zong");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			return new ModelAndView("edata/zong");
		}
	}

	/**
	 * 级联的数据测试
	 * 
	 * @param opEegrpBO
	 * @param jump
	 * @return 返回
	 */
	// @RequestMapping(value = "listEE", method = RequestMethod.GET)
	// @ResponseBody
	//
	// public List<Object> listEE() {
	// //1.生成listEE
	// List listEE = new ArrayList<>();
	// //2.生成一个省
	// HashMap<Object, Object> hubei = new HashMap<>();
	// hubei.put("n", "湖北省");
	// ArrayList<Object> diquList = new ArrayList<>();
	// HashMap<Object, Object> diquMap = new HashMap<>();
	// HashMap<Object, Object> map3 = new HashMap<>();
	// map3.put("n", "荆州");
	// HashMap<Object, Object> map4 = new HashMap<>();
	// map4.put("n", "武汉");
	// diquList.add(map3);
	// diquList.add(map4);
	// hubei.put("s", diquList);
	//
	// HashMap<Object, Object> hunan = new HashMap<>();
	// hunan.put("n", "湖南省");
	// ArrayList<Object> diquList2 = new ArrayList<>();
	// HashMap<Object, Object> diquMap2 = new HashMap<>();
	// HashMap<Object, Object> map1 = new HashMap<>();
	// HashMap<Object, Object> map2 = new HashMap<>();
	// diquList2.add(map1.put("n", "岳阳"));
	// diquList2.add(map2.put("n", "湘潭"));
	// hunan.put("s", diquList2);
	// listEE.add(hubei);
	// listEE.add(hunan);
	//
	//
	//
	//
	//
	//
	// // [{
	// // "n":"湖北省",
	// // "s":[{"n":"荆州市"},{"n":"武汉市"}]
	// // },{"n":"湖南省",
	// // "s":[{"n":"岳阳市"},{"n":"湘潭市"}]
	// // }]
	// return listEE;
	//
	// }

	@RequestMapping(value = "listEE", method={RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public List listEE() {
		List list = edataService.listEE();
		return list;

	}

	// 【8】.sql自动化导入工具controller
	/**
	 * 跳转到sqltool页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "sqltool")
	public ModelAndView sqltool(ModelMap modelMap) {
		List<String> filelist = edataService.listFilePath();
		modelMap.put("filelist", filelist);
		return new ModelAndView("edata/sqltool");
	}

	@RequestMapping(value = "receiveSms", method = RequestMethod.POST)
	@ResponseBody
	public String receiveSms(String messageBody, String address) {
		// @RequestBody String messageBody, @RequestBody String address
		// @RequestBody String messageBody,String address
		System.out.println("messageBody:" + messageBody);
		System.out.println("address:" + address);
		return "success";

	}

	// 奇怪只能返回string，其余model则会报错
	@RequestMapping(value = "generateSql", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> generateSql(SqltoolBO sqltoolBO, Map map) {
		// Boolean isSuccess = edataService.generateSqlOp(sqltoolBO);
		// if (!isSuccess) {
		// return "fail";
		// }
		// return "success";
		Map<String, Object> msgmap = edataService.generateSqlOp(sqltoolBO);
		// if (!isSuccess) {
		// return "fail";
		// }
		return msgmap;
	}

	@RequestMapping(value = "generateSqlJ", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> generateSqlJ(SqltoolJBO sqltoolJBO, Map map) {
		Map<String, Object> msgmap = edataService.generateSqlOpj(sqltoolJBO);
		// if (!isSuccess) {
		// return "fail";
		// }
		return msgmap;

	}

	/**
	 * 导入opdata数据库
	 * 
	 * @param dbname
	 *            数据库名
	 * @param writePath
	 *            路径
	 * @return 成功信息
	 */
	@RequestMapping(value = "importTo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> importTo(SqltoolBO sqltoolBO) {
		sqltoolBO.setPrefix(sqltoolBO.getPrefix().trim());
//		Map<String, Object> msgmap =new HashMap<>();
		Map<String, Object> msgmap = edataService.importTo(sqltoolBO);
		return msgmap;
	}

	@RequestMapping(value = "importToJ", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> importToJ(ModelMap modelMap, String dbnameJ,
			String writePathJ) {
		Map<String, Object> msgmap = edataService
				.importToJ(dbnameJ, writePathJ);
		// boolean isSuccess = (boolean) msgmap.get("isSuccess");
		// if (!isSuccess) {
		// return "fail";
		// }

		// Long time = (Long) msgmap.get("timeEst");无用
		// return "success" + time;
		return msgmap;
	}

	// 【9】分项对比controller
	/**
	 * 跳转到分项对比页面
	 * 
	 * @return
	 */
	// @RequestMapping(value = "subcompare")
	// public ModelAndView subcompare() {
	//
	// return new ModelAndView("edata/subcompare");
	// }
	@RequestMapping(value = "subcompare")
	public ModelAndView subcompare(ModelMap modelMap) {
		List<Deviceinfo> dlist = edataService.findAllDistrict();
		List<HashMap<String, Object>> channellist = edataService
				.listChannelEE();
		modelMap.put("dlist", dlist);
		modelMap.put("channellist", channellist);
		List<String> filelist = edataService.listFilePath();
		modelMap.put("filelist", filelist);
		// List<Eeclassificationgrp> eglist = edataService.findAllGroup();暂时用不到
		// modelMap.put("eglist", eglist);暂时用不到
		return new ModelAndView("edata/subcompare");
	}

	// 【9.1】查询不匹配的记录
	@RequestMapping(value = "listSubcompareResult", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listSubcompareResult(
			@RequestBody SubcompareBO subcompareBO) {
		// Integer count = 20;
		dealADR(subcompareBO);
		List<LinkedHashMap<String, Object>> list = edataService
				.listSubcompareResult(subcompareBO);
		Integer count = list.size();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", list);
		return map;
	}
	// public static void main(String[] args) {
	//
	// }
	
}
