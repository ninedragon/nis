package com.zz.common.dao;

import com.zz.common.model.Opjumpdata;
import com.zz.edata.bo.OpEegrpBO;
import com.zz.edata.bo.SubcompareBO;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OpjumpdataMapper {


    int insert(Opjumpdata record);

    int insertSelective(Opjumpdata record);

	Integer selectGridCountV51(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV51(OpEegrpBO opEegrpBO);

	List<LinkedHashMap<String, Object>> selectBySql(OpEegrpBO opEegrpBO);


	List<LinkedHashMap<String, Object>> listSubcompareResult(
			SubcompareBO subcompareBO);



}