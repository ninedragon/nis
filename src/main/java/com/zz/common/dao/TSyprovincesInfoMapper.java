package com.zz.common.dao;

import java.util.List;
import java.util.Map;

import com.zz.common.model.TSyprovincesInfoBean;


public interface TSyprovincesInfoMapper {
	//获取当前user的省份
	List<TSyprovincesInfoBean> getProvinces(Map<String,String> map);
	List<TSyprovincesInfoBean> getProvincesByEp(Map<String,String> map);
	
	List<TSyprovincesInfoBean> getAllProvinces(Map<String,String> map);
	//获取当前省份的code码
	String getPrvinceCode(String provinceId);
}