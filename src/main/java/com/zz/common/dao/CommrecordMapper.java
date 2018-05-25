package com.zz.common.dao;

import com.zz.common.model.Commrecord;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CommrecordMapper {


    int insert(Commrecord record);

    int insertSelective(Commrecord record);




}