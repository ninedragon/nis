package com.zz.edata.service;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import com.zz.common.model.Deviceinfo;
import com.zz.common.model.Eeclassification;
import com.zz.common.model.Eeclassificationgrp;
import com.zz.common.model.Opdata;
import com.zz.core.mybatis.page.Pagination;
import com.zz.edata.bo.BaseLinkSelectBO;
import com.zz.edata.bo.EquxianBo;
import com.zz.edata.bo.FenxiangBo;
import com.zz.edata.bo.OpEegrpBO;
import com.zz.edata.bo.SqltoolBO;
import com.zz.edata.bo.SqltoolJBO;
import com.zz.edata.bo.SubcompareBO;
import com.zz.edata.bo.YuanshiBo;
import com.zz.edata.bo.YuanshijBo;
import com.zz.edata.bo.ZdBo;
import com.zz.edata.bo.ZongBo;

/**
 * @author 90807
 *
 */
/**
 * @author 90807
 *
 */
/**
 * @author 90807
 *
 */
/**
 * @author 90807
 *
 */
/**
 * @author 90807
 * 
 */
/**
 * @author 90807
 *
 */
public interface EdataService {

	Pagination<ZongBo> findRoleAndPermissionPage(ModelMap modelMap,
			Integer pageNo, int pageSize);

	Pagination<FenxiangBo> findFenxiangPage(ModelMap modelMap, Integer pageNo,
			int pageSize);

	Pagination<ZdBo> findZdPage(ModelMap modelMap, Integer pageNo, int pageSize);

	Pagination<EquxianBo> findEquxianPage(ModelMap modelMap, Integer pageNo,
			int pageSize);

	Pagination<YuanshiBo> findYuanshiPage(ModelMap modelMap, Integer pageNo,
			int pageSize);

	Pagination<YuanshijBo> findYuanshijPage(ModelMap modelMap, Integer pageNo,
			int pageSize);

	List<Deviceinfo> findAllDistrict();

	List<Eeclassificationgrp> findAllGroup();

	List<Opdata> findOpdatasByGrp(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> getZongData(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findfenData(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> getPower(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findGrid(OpEegrpBO opEegrpBO);

	Integer findGridCount(OpEegrpBO opEegrpBO);

	// fenxiang数据
	List<HashMap<String, Object>> getPowerEE(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findFendataDraw(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findGridV22(OpEegrpBO opEegrpBO);

	Integer findGridCountV22(OpEegrpBO opEegrpBO);

	Integer findYuanshiCountV31(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findYuanshiV31(OpEegrpBO opEegrpBO);

	Integer findYuanshiCountV41(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findYuanshiV41(OpEegrpBO opEegrpBO);

	Integer findSuanfaCountV51(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findSuanfaV51(OpEegrpBO opEegrpBO);

	List<Eeclassification> findAllEE();

	/**
	 * @param opEegrpBO
	 *            查询所需相关数据导入
	 * @param jump15
	 *            传入的要查询jump的jump点
	 * @return 显示算法数据不同的图所需要的map
	 */
	HashMap<String, Object> listChartData(OpEegrpBO opEegrpBO, String jump15);

	Integer findGridCountSQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findGridSQL(OpEegrpBO opEegrpBO);

	Integer findGridCountV22SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findGridV22SQL(OpEegrpBO opEegrpBO);

	Integer findYuanshiCountV31SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findYuanshiV31SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> findQitingTable(OpEegrpBO opEegrpBO);

	Integer findQitingTableCount(OpEegrpBO opEegrpBO);

	List<LinkedHashMap<String, Object>> findSuanfaV61(OpEegrpBO opEegrpBO);

	/**
	 * 返回用于联动的电器大类和小类
	 * 
	 * @return
	 */
	List listEE();
    //opdata
	Map<String, Object> generateSqlOp(SqltoolBO sqltoolBO);

	Map<String, Object> importTo(SqltoolBO sqltoolBO);
	
    //opjumpdata
	Map<String, Object> generateSqlOpj(SqltoolJBO sqltoolJBO);

	Map<String, Object> importToJ(String dbname, String writePath);

	List<LinkedHashMap<String, Object>> listSuanfaResult(OpEegrpBO opEegrpBO);


	List<HashMap<String, Object>> listChannelEE();

	List<LinkedHashMap<String, Object>> listSubcompareResult(
			SubcompareBO subcompareBO);

	List<String> listFilePath();

	List<BaseLinkSelectBO> listLSDevice();

	List<HashMap<String, Object>> listRecorddate(OpEegrpBO opEegrpBO);

}
