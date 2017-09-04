package com.kaika.mapper;

import com.kaika.model.Journal;
import java.util.List;

public interface JournalMapper {
    Journal getUseJournal();

	List<Journal> listByCondition(Journal record);

    int count(Journal record);

    int insertSelective(Journal record);

    int updateByPrimaryKeySelective(Journal record);

    int deleteByPrimaryKey(Integer id);
    
    int updateUseStatus(Journal record);
    
    int updateOtherStatus(Journal record);
    
}