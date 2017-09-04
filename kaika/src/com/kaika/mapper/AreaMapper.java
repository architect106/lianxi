package com.kaika.mapper;

import com.kaika.model.Area;
import java.util.List;

public interface AreaMapper {
    List<Area> listByCondition(Area record);

    int count(Area record);

    int insertSelective(Area record);

    int updateByPrimaryKeySelective(Area record);

    int deleteByPrimaryKey(Integer id);
}