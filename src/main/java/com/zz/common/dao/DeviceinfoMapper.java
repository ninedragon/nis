package com.zz.common.dao;

import com.zz.common.model.Deviceinfo;
import com.zz.common.model.DeviceinfoKey;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DeviceinfoMapper {


    int deleteByPrimaryKey(DeviceinfoKey key);

    int insert(Deviceinfo record);

    int insertSelective(Deviceinfo record);

    List<Deviceinfo> selectAllDeviceDis();

    Deviceinfo selectByPrimaryKey(DeviceinfoKey key);



    int updateByPrimaryKeySelective(Deviceinfo record);

    int updateByPrimaryKey(Deviceinfo record);

	List<Deviceinfo> listDevcieInfo();
}