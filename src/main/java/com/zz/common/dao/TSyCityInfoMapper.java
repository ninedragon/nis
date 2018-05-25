package com.zz.common.dao;

import java.util.List;
import java.util.Map;

import com.zz.common.model.TSyCityInfoBean;


public interface TSyCityInfoMapper {
	
	
	// 根据省获取市
		List<TSyCityInfoBean> getCity(Map<String, String> map);
		
    // 根据省获取市
    List<TSyCityInfoBean> getCityByEp(Map<String, String> map);

	// 根据省获取市
	List<TSyCityInfoBean> getAllCity(Map<String, String> map);

	// 根据市获取区
	List<TSyCityInfoBean> getCityDistrict(String provinceId);
	
	// 根据市获取区
	List<TSyCityInfoBean> getCityDistrictByEp(String provinceId);

	// 获取当前市的code码
	String getCityInfocode(String citycode);

	// 获取区域城市规划图
	TSyCityInfoBean getReport(String citycode);
}