package com.zz.common.dao;

import com.zz.common.model.Eeclassificationgrp;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EeclassificationgrpMapper {


    int deleteByPrimaryKey(Integer cEegrpid);

    int insert(Eeclassificationgrp record);

    int insertSelective(Eeclassificationgrp record);

    List<Eeclassificationgrp> selectAllEG();//选择所有电器

    Eeclassificationgrp selectByPrimaryKey(Integer cEegrpid);



    int updateByPrimaryKeySelective(Eeclassificationgrp record);

    int updateByPrimaryKey(Eeclassificationgrp record);

	
}