package com.zz.edata2.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import com.zz.common.utils.Page;
import com.zz.core.mybatis.page.Pagination;
import com.zz.core.shiro.token.manager.TokenManager;
import com.zz.edata.bo.EquxianBo;
import com.zz.edata.bo.OpEegrpBO;
import com.zz.edata.service.EdataService;
import com.zz.uaop.MultipleDataSource;

@Controller
@Scope(value = "prototype")
@RequestMapping("edata2")
public class EdataController2 extends BaseController {

	@Autowired
	EdataService edataService;

	/**
	 * 
	 * @param modelMap
	 * @param pageNo
	 * @param findContent
	 * @return
	 */
	// 1.处理总体用电数据controller
	@RequestMapping(value = "zong")
	public ModelAndView zong(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
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
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/zong");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/zong");
		}
	}

	@RequestMapping(value = "getZongdata", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getZongdata(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.getZongData(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	@RequestMapping(value = "getPower", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getPower(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.getPower(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	@RequestMapping(value = "getFendata", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendata(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findfenData(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	@RequestMapping(value = "getGriddata", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getGrid(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		// 1.处理adress为了把界面不符合规范的查询条件处理
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findGridCountSQL(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService.findGridSQL(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
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
		String cr=opEegrpBO.getcRecorddatebcd().replace("-", "").substring(2);
		opEegrpBO.setcRecorddatebcd(cr);
	}

	// //2.处理分项能耗数据controller
	@RequestMapping(value = "fenxiang")
	public ModelAndView fenxiang(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		if (opEegrpBO.getcAddressid() == null
				&& opEegrpBO.getcChannelid() == null
				&& opEegrpBO.getcEegrpid() == null
				&& opEegrpBO.getcRecordinserttime() == null) {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			modelMap.put("testinfo", "testinfo");
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/fenxiang");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/fenxiang");
		}
	}

	@RequestMapping(value = "getFendataDraw", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendataDraw(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findFendataDraw(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	@RequestMapping(value = "getPowerEE", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getPowerEE(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.getPowerEE(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	@RequestMapping(value = "getFendataOriTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getFendataOriTable(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findGridCountV22SQL(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findGridV22SQL(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return map;
	}

	@RequestMapping(value = "getFendata2", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getFendata2(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService
				.findfenData(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}
	@RequestMapping(value = "getQitingTable", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getQitingTable(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		List<HashMap<String, Object>> list = edataService
				.findQitingTable(opEegrpBO);
		Integer count =list.size();
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
		MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return map;
	}

	@RequestMapping(value = "getGriddataF", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> getGridF(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		List<HashMap<String, Object>> list = edataService.findGrid(opEegrpBO);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return list;
	}

	// 3.处理原始上传数据Controller
	@RequestMapping(value = "yuanshi")
	public ModelAndView yuanshi(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		if (opEegrpBO.getcAddressid() == null
				&& opEegrpBO.getcChannelid() == null
				&& opEegrpBO.getcEegrpid() == null
				&& opEegrpBO.getcRecordinserttime() == null) {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			modelMap.put("testinfo", "testinfo");
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/yuanshi");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/yuanshi");
		}
	}

	@RequestMapping(value = "getYuanshiV31", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYuanshiV31(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		dealADR(opEegrpBO);
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		Integer count = edataService.findYuanshiCountV31SQL(opEegrpBO);
		dealPage(opEegrpBO, pa, count);
		List<HashMap<String, Object>> list = edataService
				.findYuanshiV31SQL(opEegrpBO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("data", list);
		map.put("code", "0");
		map.put("msg", "");
		map.put("count", count);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return map;
	}

	// 4.处理原始上传阶跃数据Controller
	@RequestMapping(value = "yuanshij")
	public ModelAndView yuanshij(ModelMap modelMap, Integer pageNo,
			String findContent, OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		if (opEegrpBO.getcAddressid() == null
				&& opEegrpBO.getcChannelid() == null
				&& opEegrpBO.getcEegrpid() == null
				&& opEegrpBO.getcRecordinserttime() == null) {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
			modelMap.put("testinfo", "testinfo");
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/yuanshij");
		} else {
			List<Deviceinfo> dlist = edataService.findAllDistrict();
			List<Eeclassificationgrp> eglist = edataService.findAllGroup();
			dealADR(opEegrpBO);
			List<Opdata> olist = edataService.findOpdatasByGrp(opEegrpBO);
			modelMap.put("olist", olist);
			modelMap.put("dlist", dlist);
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/yuanshij");
		}
	}

	@RequestMapping(value = "getYuanshiV41", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getYuanshiV41(OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
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
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return map;
	}

	// end
	// 5.算法分析Controller
	@RequestMapping(value = "suanfa")
	public ModelAndView suanfa(ModelMap modelMap, OpEegrpBO opEegrpBO) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");

		if (opEegrpBO.getcEehexid() == null && opEegrpBO.getcParaid() == null) {
			List<Eeclassification> eglist = edataService.findAllEE();
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/suanfa");
		} else {
			List<Eeclassification> eglist = edataService.findAllEE();
			modelMap.put("eglist", eglist);
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return new ModelAndView("edata2/suanfa");
		}
	}

	//
	@RequestMapping(value = "getV51", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getV51(OpEegrpBO opEegrpBO, String page,
			String limit) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		// 1.处理address完毕
		// 2.返回总页数
		// 目的：为了得到分页后再次查询，得到相关结果
		Page pa = new Page();
		dealPage(opEegrpBO, pa, 100000);
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		opEegrpBO.setVersion11(opEegrpBO.getVersion1()+10000);
		opEegrpBO.setVersion21(opEegrpBO.getVersion2()+10000);
		
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
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return map;
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			List<HashMap<String, Object>> alllist = (List<HashMap<String, Object>>) TokenManager
					.getVal2Session("alllist");
			List<HashMap<String, Object>> list = new ArrayList();
			if(Integer.parseInt(limit)*Integer.parseInt(page)<=alllist.size())
			{
			for (int i =Integer.parseInt(limit)*(Integer.parseInt(page)-1) ; i < Integer.parseInt(limit)*Integer.parseInt(page); i++) {
				list.add(alllist.get(i));
			}
			}else{
				for (int i =Integer.parseInt(limit)*(Integer.parseInt(page)-1) ; i < alllist.size(); i++) {
					list.add(alllist.get(i));
				}
			}
			map.put("data", list);
			map.put("code", "0");
			map.put("msg", "");
			map.put("count", alllist.size());
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
			return map;
		}

	}

	// 接收文件，数据处理，传出作图文件
	// 目的，文件为txt，必须先变成json字符串再进行
	@RequestMapping(value = "getTest", method = RequestMethod.POST)
	@ResponseBody
	public String getTest(@RequestParam("file") MultipartFile file) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
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

//	@RequestMapping(value = "getV52Remote", method = RequestMethod.POST)
//	@ResponseBody
//	public List<HashMap<String, Object>> getV52Remote(
//			@RequestParam("file") MultipartFile file, Integer jump15) {
//        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
//		List<HashMap<String, Object>> v52list = edataService.dealFile15(new OpEegrpBO(),
//				jump15);
//        MultipleDataSource.setDataSourceKey("mySqlDataSource");
//		return v52list;
//		// if (!file.isEmpty()) {
//		// try {
//		// // 文件存放服务端的位置
//		// String rootPath = "d:/tmp";
//		// File dir = new File(rootPath + File.separator + "tmpFiles");
//		// if (!dir.exists())
//		// dir.mkdirs();
//		// // 写文件到服务器
//		// File serverFile = new File(dir.getAbsolutePath() + File.separator +
//		// file.getOriginalFilename());
//		// file.transferTo(serverFile);
//		// return "You successfully uploaded file=" +
//		// file.getOriginalFilename();
//		// } catch (Exception e) {
//		// return "You failed to upload " + file.getOriginalFilename() + " => "
//		// + e.getMessage();
//		// }
//		// } else {
//		// return "You failed to upload " + file.getOriginalFilename() +
//		// " because the file was empty.";
//		// }
//	}

	@RequestMapping(value = "getV52", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getV52(OpEegrpBO opEegrpBO, String jump) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		HashMap<String, Object> v52map = new HashMap();
		v52map = edataService.listChartData(opEegrpBO, jump);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return v52map;
		// if (!file.isEmpty()) {
		// try {
		// // 文件存放服务端的位置
		// String rootPath = "d:/tmp";
		// File dir = new File(rootPath + File.separator + "tmpFiles");
		// if (!dir.exists())
		// dir.mkdirs();
		// // 写文件到服务器
		// File serverFile = new File(dir.getAbsolutePath() + File.separator +
		// file.getOriginalFilename());
		// file.transferTo(serverFile);
		// return "You successfully uploaded file=" +
		// file.getOriginalFilename();
		// } catch (Exception e) {
		// return "You failed to upload " + file.getOriginalFilename() + " => "
		// + e.getMessage();
		// }
		// } else {
		// return "You failed to upload " + file.getOriginalFilename() +
		// " because the file was empty.";
		// }
	}

	@RequestMapping(value = "equxian")
	public ModelAndView equxian(ModelMap modelMap, Integer pageNo,
			String findContent) {
        MultipleDataSource.setDataSourceKey("sqlServerDataSource");
		modelMap.put("findContent", findContent);
		Pagination<EquxianBo> boPage = edataService.findEquxianPage(modelMap,
				pageNo, pageSize);
		modelMap.put("page", boPage);
        MultipleDataSource.setDataSourceKey("mySqlDataSource");
		return new ModelAndView("edata2/equxian");
	}

}
