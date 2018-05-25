package com.zz.common.dao;

import com.zz.common.model.UserRole;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserRoleMapper {


    int insert(UserRole record);

    int insertSelective(UserRole record);



}