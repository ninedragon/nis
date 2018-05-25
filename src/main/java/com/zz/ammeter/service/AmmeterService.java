package com.zz.ammeter.service;

import java.util.List;
import java.util.Map;

import com.zz.common.model.TAmmeterInfo;
import com.zz.core.mybatis.page.Pagination;


public interface AmmeterService {/*


		
		// 获取所有查询条件
		public Map<String, Object> selectEpuNameByAm();
		
		// 获取所有查询条件
		public Map<String, Object> getEpuCodeByCode(String code);
		
		// 获取所有查询条件
			public Map<String, Object> getParentEpu(String epuType);
			
			// 获取所有查询条件
	 public Map<String, Object> selectDistrictId();
	 
	 public Map<String, Object> selectDIstinctByChannelId();
	 
		// 获取所有查询条件
	 public Map<String, Object> selectAddressIdByDistrictId(String districtId);
						
	// 获取所有查询条件
	 public Map<String, Object> updateEpuInfo(TEpuInfo tEpuInfo,String flag);
	 
	
      
   

      

*/
	public Map<String, Object> selectEpuNameByAm(String epuDistrict);
	
	Pagination<TAmmeterInfo> findByPage(Map<String, Object> resultMap, Integer pageNo,
			Integer pageSize);
	
	// 获取所有查询条件
	 public Map<String, Object> updateEpuInfo(TAmmeterInfo ammeterInfo,String flag);
	 
		// 获取所有查询条件
     public Map<String, Object> delEpuInfoById(String rowIds);
     
     public List<TAmmeterInfo> selectEpuInfoByRowId(String rowId,String epuId);
     
     
}
