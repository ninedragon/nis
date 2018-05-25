package com.zz.common.dao;

import com.zz.common.model.Testdeviceinfo;
import com.zz.common.model.TestdeviceinfoKey;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TestdeviceinfoMapper {


    int deleteByPrimaryKey(TestdeviceinfoKey key);

    int insert(Testdeviceinfo record);

    int insertSelective(Testdeviceinfo record);


    Testdeviceinfo selectByPrimaryKey(TestdeviceinfoKey key);



    int updateByPrimaryKeySelective(Testdeviceinfo record);

    int updateByPrimaryKey(Testdeviceinfo record);
}