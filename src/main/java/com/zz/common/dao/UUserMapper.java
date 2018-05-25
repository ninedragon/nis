package com.zz.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zz.common.model.UUser;
import com.zz.permission.bo.URoleBo;

public interface UUserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(UUser record);

    int insertSelective(UUser record);

    UUser selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UUser record);

    int updateByPrimaryKey(UUser record);

	UUser login(Map<String, Object> map);

	UUser findUserByEmail(String email);

	List<URoleBo> selectRoleByUserId(Long id);

	List<HashMap<String, Object>> selectUsersBy(UUser entity);

	Integer selectUsersByCount(UUser entity);

}