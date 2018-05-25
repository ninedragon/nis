package com.zz.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zz.common.model.TSyCodeDefimeBean;
public interface TSyCodeDefimeMapper {
	// 获取code码值
	TSyCodeDefimeBean getCode(String record);

	// 获取商圈类型name
	List<TSyCodeDefimeBean> getTradezone();

	// 获取聚客点类型name
	List<TSyCodeDefimeBean> getChanceType();

	// 获取品牌类型name
	List<TSyCodeDefimeBean> getBrand();

	// 获取物业类型name
	List<TSyCodeDefimeBean> getProperty();

	// 是否新城市name
	List<TSyCodeDefimeBean> getNewCity();

	// 获取商圈类型name
	List<TSyCodeDefimeBean> getAssets();
	
	//获取商业体量
	List<TSyCodeDefimeBean> getVolume();
	
	//获取城市等级
	List<TSyCodeDefimeBean> getCityGrade();
	
	//获取餐厅类型
	List<TSyCodeDefimeBean> getStoreType();
	
	//获取kiosk类型
	List<TSyCodeDefimeBean> getKioskType();

	//获取项目类型
	List<TSyCodeDefimeBean> getProjectType();

	//获取上报类型
	List<TSyCodeDefimeBean> getReportType();
	//获取SP审核状态
	List<TSyCodeDefimeBean> getIsComplete();
	
	//获取审批结论
	List<TSyCodeDefimeBean> getVerifyType();
	
	//获取开发阶段
	List<TSyCodeDefimeBean> getDevStages();
	
	//获取价格梯次
	List<TSyCodeDefimeBean> getArrangement();
	/**
	 * 
	 * 根据code type 查询字典
	 * 
	 * @param codeType
	 * @return
	 */
	public List<TSyCodeDefimeBean> getCodeByCodeType(@Param("codeType") String codeType);

	

	/**
	 * 
	 * 根据code  查询字典
	 * 
	 * @param code
	 * @return
	 */
	public TSyCodeDefimeBean getCodeByCode(@Param("code") String code);


	/**
	 * 
	 * 根据code 查询字典
	 * 
	 * @param code
	 * @return
	 */
	public TSyCodeDefimeBean getEpuCodeByCode(@Param("code") String code);


}