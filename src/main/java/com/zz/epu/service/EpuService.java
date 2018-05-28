package com.zz.epu.service;

import java.util.List;
import java.util.Map;

import com.zz.common.model.TEpuInfo;
import com.zz.core.mybatis.page.Pagination;

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
public interface EpuService {
	Pagination<TEpuInfo> findByPage(Map<String, Object> resultMap, Integer pageNo,
			Integer pageSize);
	// 获取所有省份
		public Object getProvinces(Map<String,String> map);
		
		// 获取只有设备的省份
		public Object getProvincesByEp(Map<String,String> map);


		// 获取所有城市
		public Object getCity(Map<String, String> map);
		
		// 获取只有设备的城市
		public Object getCityByEp(Map<String,String> map);

		// 获取所有区县
		public Object getCityDistrict(String provinceId);
		
		
		// 获取只有设备的区域
	  public Object getCityDistrictByEp(String provinceId);
		
		// 获取所有查询条件
		public Map<String, Object> getAllChanceType();
		
		// 获取所有查询条件
		public Map<String, Object> getEpuCodeByCode(String code);
		
		// 获取所有查询条件
			public Map<String, Object> getParentEpu(String epuType,String epuDistrict);
			
			// 获取所有查询条件
	 public Map<String, Object> selectDistrictId();
	 
	 public Map<String, Object> selectDIstinctByChannelId(String districtId,String addressId);
	 
		// 获取所有查询条件
	 public Map<String, Object> selectAddressIdByDistrictId(String districtId);
						
	// 获取所有查询条件
	 public Map<String, Object> updateEpuInfo(TEpuInfo tEpuInfo,String flag);
	 
		// 获取所有查询条件
      public Map<String, Object> delEpuInfo(TEpuInfo tEpuInfo);
      
      public List<TEpuInfo> selectEpuInfoByRowId(String rowId);
      public   List<TEpuInfo> selectEpuInfoByMark(TEpuInfo e);
  	// 删除标记
      public Map<String, Object> delMark(String rowId);
      public Map<String, Object> checkEpName(String epuName,String epuDistrict,String epuType);
      
      public List<TEpuInfo> selectEpuInfos(TEpuInfo epuInfo);
      

}
