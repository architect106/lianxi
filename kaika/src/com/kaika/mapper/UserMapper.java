package com.kaika.mapper;

import com.kaika.model.User;
import java.util.List;

public interface UserMapper {
    List<User> listByCondition(User record);

    int count(User record);

    int insertSelective(User record);

    int updateByPrimaryKeySelective(User record);

    int deleteByPrimaryKey(Integer id);
}