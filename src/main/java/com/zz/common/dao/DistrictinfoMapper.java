package com.zz.common.dao;

import com.zz.common.model.Districtinfo;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DistrictinfoMapper {

    int deleteByPrimaryKey(String cDistrictbcdid);

    int insert(Districtinfo record);

    int insertSelective(Districtinfo record);


    Districtinfo selectByPrimaryKey(String cDistrictbcdid);



    int updateByPrimaryKeySelective(Districtinfo record);

    int updateByPrimaryKey(Districtinfo record);
}