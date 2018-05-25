package com.zz.common.dao;

import com.zz.common.model.Permission;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PermissionMapper {


    int deleteByPrimaryKey(Long id);

    int insert(Permission record);

    int insertSelective(Permission record);


    Permission selectByPrimaryKey(Long id);



    int updateByPrimaryKeySelective(Permission record);

}