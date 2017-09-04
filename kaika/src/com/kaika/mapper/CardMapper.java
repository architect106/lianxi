package com.kaika.mapper;

import com.kaika.model.Card;
import com.kaika.model.CardVO;

import java.util.List;

public interface CardMapper {
    List<Card> listByCondition(CardVO record);

    int count1(CardVO record);

    int insertSelective(Card record);

    int updateByPrimaryKeySelective(Card record);

    int deleteByPrimaryKey(Integer id);

	void insertCardsBatch(List<Card> partCrads);
}