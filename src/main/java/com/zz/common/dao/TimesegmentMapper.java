package com.zz.common.dao;

import com.zz.common.model.Timesegment;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TimesegmentMapper {


    int deleteByPrimaryKey(Integer cTsegmentid);

    int insert(Timesegment record);

    int insertSelective(Timesegment record);

    Timesegment selectByPrimaryKey(Integer cTsegmentid);



    int updateByPrimaryKeySelective(Timesegment record);

    int updateByPrimaryKey(Timesegment record);
}