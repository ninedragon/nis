package com.zz.common.dao;

import com.zz.common.model.Eeclassification;
import com.zz.common.model.Eeclassificationgrp;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EeclassificationMapper {


    int deleteByPrimaryKey(String cEehexid);

    int insert(Eeclassification record);

    int insertSelective(Eeclassification record);


    Eeclassification selectByPrimaryKey(String cEehexid);


    int updateByPrimaryKeySelective(Eeclassification record);

    int updateByPrimaryKey(Eeclassification record);

	List<Eeclassification> selectAllEE();
}