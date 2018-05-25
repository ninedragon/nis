package com.zz.common.dao;

import com.zz.common.model.Testopdata;

import java.util.List;

public interface TestopdataMapper {



    int insert(Testopdata record);

    int insertSelective(Testopdata record);





    int updateByPrimaryKeySelective(Testopdata record);

    int updateByPrimaryKey(Testopdata record);
}