package com.zz.common.dao;

import com.zz.common.model.Opdata;
import com.zz.common.model.OpdataKey;
import com.zz.edata.bo.OpEegrpBO;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OpdataMapper {


    int deleteByPrimaryKey(OpdataKey key);

    int insert(Opdata record);

    int insertSelective(Opdata record);


    Opdata selectByPrimaryKey(OpdataKey key);


    int updateByPrimaryKeySelective(Opdata record);

    int updateByPrimaryKey(Opdata record);

	List<Opdata> selectOpdatasByGrp(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectOpdatasForZong(OpEegrpBO opEegrpBO);
	List<HashMap<String, Object>> selectOpdatasForFen(OpEegrpBO opEegrpBO);
	List<HashMap<String, Object>> selectOpdatasPower(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectOpdatasForGrid(OpEegrpBO opEegrpBO);
	Integer selectOpdatasForGridCount(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectOpdatasPowerEE(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectFendataDraw(OpEegrpBO opEegrpBO);

	Integer selectGridCountV22(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV22(OpEegrpBO opEegrpBO);

	Integer selectGridCountV31(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV31(OpEegrpBO opEegrpBO);

	Integer selectGridCountV41(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV41(OpEegrpBO opEegrpBO);

	Integer selectOpdatasForGridCountSQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectOpdatasForGridSQL(OpEegrpBO opEegrpBO);

	Integer selectGridCountV22SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV22SQL(OpEegrpBO opEegrpBO);

	Integer selectGridCountV31SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectGridV31SQL(OpEegrpBO opEegrpBO);

	List<HashMap<String, Object>> selectQitingTable(OpEegrpBO opEegrpBO);

	Integer selectQitingTableCount(OpEegrpBO opEegrpBO);


	List<HashMap<String, Object>> listChannelEE();

	List<HashMap<String, Object>> listRecorddate(OpEegrpBO opEegrpBO);



}