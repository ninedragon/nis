package com.zz.epu.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zz.common.dao.TEpuInfoMapper;
import com.zz.common.dao.TSyCityInfoMapper;
import com.zz.common.dao.TSyCodeDefimeMapper;
import com.zz.common.dao.TSyprovincesInfoMapper;
import com.zz.common.model.TEpuInfo;
import com.zz.common.model.TSyCityInfoBean;
import com.zz.common.model.TSyCodeDefimeBean;
import com.zz.common.model.TSyprovincesInfoBean;
import com.zz.core.mybatis.BaseMybatisDao;
import com.zz.core.mybatis.page.Pagination;
import com.zz.epu.service.EpuService;

/**
 * 
 */
@Service
public class EpuServiceImpl extends BaseMybatisDao<TEpuInfoMapper> implements EpuService {
	
	@Autowired
	TSyprovincesInfoMapper tSyprovincesInfoMapper;
	@Autowired
	TSyCityInfoMapper tsycityInfoMapper;
	@Autowired
	TSyCodeDefimeMapper codeDefimeMapper;
	
	@Autowired
	TEpuInfoMapper epuInfoMapper;
	@Override
	public Pagination<TEpuInfo> findByPage(Map<String, Object> resultMap,
			Integer pageNo, Integer pageSize) {
		return super.findPage(resultMap, pageNo, pageSize);
	}
	
	@Override
	public List<TSyprovincesInfoBean> getProvinces(Map<String,String> map) {
		List<TSyprovincesInfoBean> provinces = tSyprovincesInfoMapper
				.getProvinces(map);
		return provinces;
	}
	
	@Override
	public List<TSyCityInfoBean> getCity(Map<String, String> map) {
		// TODO Auto-generated method stub
		List<TSyCityInfoBean> city = tsycityInfoMapper
				.getCity(map);
		return city;
	}
	@Override
	public List<TSyCityInfoBean> getCityDistrict(String provinceId) {
		// TODO Auto-generated method stub
		
		List<TSyCityInfoBean> cityDistrict = tsycityInfoMapper
				.getCityDistrict(provinceId);
		return cityDistrict;
	}
	
	
	@Override
	public List<TSyprovincesInfoBean> getProvincesByEp(Map<String,String> map) {
		List<TSyprovincesInfoBean> provinces = tSyprovincesInfoMapper
				.getProvincesByEp(map);
		return provinces;
	}
	
	@Override
	public List<TSyCityInfoBean> getCityByEp(Map<String, String> map) {
		// TODO Auto-generated method stub
		List<TSyCityInfoBean> city = tsycityInfoMapper
				.getCityByEp(map);
		return city;
	}
	@Override
	public List<TSyCityInfoBean> getCityDistrictByEp(String provinceId) {
		// TODO Auto-generated method stub
		
		List<TSyCityInfoBean> cityDistrict = tsycityInfoMapper
				.getCityDistrictByEp(provinceId);
		return cityDistrict;
	}
	
	public Map<String, Object> getAllChanceType() {

		List<TSyCodeDefimeBean> epuTypeBean = codeDefimeMapper.getCodeByCodeType("D0001");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuTypeBean", epuTypeBean);
		return map;
	}
	
	public Map<String, Object> getEpuCodeByCode(String code) {

		TSyCodeDefimeBean epuTypeBean = codeDefimeMapper.getEpuCodeByCode(code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("epuTypeBean", epuTypeBean);
		return map;
	}

	public Map<String, Object> getParentEpu(String epuType,String epuDistrict) {

		List<TEpuInfo> epuParentList = epuInfoMapper.selectByEpuType(epuType, epuDistrict);
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
	public Map<String, Object> selectDIstinctByChannelId(String districtId,String addressId) {

		List<TEpuInfo>  epuInfoList = epuInfoMapper.selectDIstinctByChannelId(districtId,addressId);
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
	
	public Map<String, Object> updateEpuInfo(TEpuInfo tEpuInfo,String flag) {		
        Date d= new Date();   
        tEpuInfo.setDelFlag("0");
        int  insertInt=0;
	   if("0".equals(flag))
        {
			tEpuInfo.setCreateTime(d);
			tEpuInfo.setUpdateTime(d);
			insertInt= epuInfoMapper.insertSelective(tEpuInfo);
         }
		else
		{
			tEpuInfo.setUpdateTime(d);
			insertInt = epuInfoMapper.updateByPrimaryKeySelective(tEpuInfo);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", insertInt);
		return map;
	}
	
	public Map<String, Object> delEpuInfo(String rowId){

		int  i = epuInfoMapper.deleteByPrimaryKey(rowId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stauts", i);
		return map;
	}
	
	 public   List<TEpuInfo> selectEpuInfoByRowId(String rowId)
	 {
		return   epuInfoMapper.selectEpuInfoByRowId(rowId);
	 }
	 
	 public   List<TEpuInfo> selectEpuInfoByMark(TEpuInfo e)
	 {
		return   epuInfoMapper.selectEpuInfoByMark(e);
	 }
	 
	 	// 删除标记
     public Map<String, Object> delMark(String rowId)
     {
    	 int  i = epuInfoMapper.delMarkByRowId(rowId);
 		Map<String, Object> map = new HashMap<String, Object>();
 		map.put("stauts", i);
 		return map;
     }
     

	 public   List<TEpuInfo> selectEpuInfos(TEpuInfo epuInfo)
	 {
		return   epuInfoMapper.selectEpuInfos(epuInfo);
	 }
	 
	 public Map<String, Object> checkEpName(String epuName,String epuDistrict,String epuType)
     {
		 List<TEpuInfo> list = epuInfoMapper.checkEpName(epuName,epuDistrict,epuType);
 		Map<String, Object> map = new HashMap<String, Object>();
 		
 		map.put("stauts", list.size());
 		return map;
     }
     
	 
}
