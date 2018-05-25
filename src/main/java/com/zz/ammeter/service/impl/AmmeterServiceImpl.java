package com.zz.ammeter.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zz.ammeter.service.AmmeterService;
import com.zz.common.dao.TAmmeterInfoMapper;
import com.zz.common.dao.TSyCityInfoMapper;
import com.zz.common.dao.TSyCodeDefimeMapper;
import com.zz.common.dao.TSyprovincesInfoMapper;
import com.zz.common.model.TAmmeterInfo;
import com.zz.common.model.TEpuInfo;
import com.zz.common.utils.LoggerUtils;
import com.zz.core.mybatis.BaseMybatisDao;
import com.zz.core.mybatis.page.Pagination;

/**
 * 
 */
@Service
public class AmmeterServiceImpl extends BaseMybatisDao<TAmmeterInfoMapper> implements AmmeterService {
	
	@Autowired
	TSyprovincesInfoMapper tSyprovincesInfoMapper;
	@Autowired
	TSyCityInfoMapper tsycityInfoMapper;
	@Autowired
	TSyCodeDefimeMapper codeDefimeMapper;
	
	@Autowired
	TAmmeterInfoMapper ammeterInfoMapper;
	
/*	
	
	
	public Map<String, Object> getEpuCodeByCode(String code) {

		TSyCodeDefimeBean epuTypeBean = codeDefimeMapper.getEpuCodeByCode(code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuTypeBean", epuTypeBean);
		return map;
	}

	public Map<String, Object> getParentEpu(String epuType) {

		List<TEpuInfo> epuParentList = epuInfoMapper.selectByEpuType(epuType);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuParentList", epuParentList);
		return map;
	}
	
	public Map<String, Object> selectDistrictId() {

		List<TEpuInfo>  epuInfoList = epuInfoMapper.selectDistrictId("");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuInfoList", epuInfoList);
		return map;
	}
	public Map<String, Object> selectDIstinctByChannelId() {

		List<TEpuInfo>  epuInfoList = epuInfoMapper.selectDIstinctByChannelId("");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuInfoList", epuInfoList);
		return map;
	}
	
	
	public Map<String, Object> selectAddressIdByDistrictId(String districtId) {

		List<TEpuInfo>  epuInfoList = epuInfoMapper.selectAddressIdByDistrictId(districtId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuInfoList", epuInfoList);
		return map;
	}
	

	

	

	 */
	public Map<String, Object> selectEpuNameByAm(String epuDistrict) {

		List<TAmmeterInfo> epuParentList = ammeterInfoMapper.selectEpuNameByAm(epuDistrict);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuParentList", epuParentList);
		return map;
	}
	
	@Override
	public Pagination<TAmmeterInfo> findByPage(Map<String, Object> resultMap,
			Integer pageNo, Integer pageSize) {
		return super.findPage(resultMap, pageNo, pageSize);
	}
	
	public Map<String, Object> updateEpuInfo(TAmmeterInfo ammeterInfo,String flag) {		
        Date d= new Date();   
        ammeterInfo.setDelFlag("0");
        int  insertInt=0;
	   if("0".equals(flag))
        {
		   ammeterInfo.setCreateTime(d);
		   ammeterInfo.setUpdateTime(d);
			insertInt= ammeterInfoMapper.insertSelective(ammeterInfo);
         }
		else
		{
			ammeterInfo.setUpdateTime(d);
			insertInt = ammeterInfoMapper.updateByPrimaryKeySelective(ammeterInfo);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", insertInt);
		return map;
	}
	
/*	public Map<String, Object> delEpuInfo(String rowId){

		int  i = ammeterInfoMapper.deleteByPrimaryKey(rowId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stauts", i);
		return map;
	}*/
	
	public Map<String, Object> delEpuInfoById(String ids) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			int count=0;
			String[] idArray = new String[]{};
			if(StringUtils.contains(ids, ",")){
				idArray = ids.split(",");
			}else{
				idArray = new String[]{ids};
			}
			
			for (String id : idArray) {
				count+=ammeterInfoMapper.deleteByPrimaryKey(id);
			}
			resultMap.put("status", 200);
			resultMap.put("count", count);
		} catch (Exception e) {
			LoggerUtils.fmtError(getClass(), e, "根据IDS删除用户出现错误，ids[%s]", ids);
			resultMap.put("status", 500);
			resultMap.put("message", "删除出现错误，请刷新后再试！");
		}
		return resultMap;
	}
	
	 public   List<TAmmeterInfo> selectEpuInfoByRowId(String rowId,String epuId)
	 {
		return   ammeterInfoMapper.selectEpuInfoByRowId(rowId,epuId);
	 }
}
