package com.zz.common.dao;

import com.zz.common.model.Opalarmdata;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OpalarmdataMapper {


    int insert(Opalarmdata record);

    int insertSelective(Opalarmdata record);



}