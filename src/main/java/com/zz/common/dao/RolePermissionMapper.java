package com.zz.common.dao;

import com.zz.common.model.RolePermission;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RolePermissionMapper {

    int insert(RolePermission record);

    int insertSelective(RolePermission record);


}