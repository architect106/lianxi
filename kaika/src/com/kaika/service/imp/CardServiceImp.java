package com.kaika.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kaika.mapper.CardMapper;
import com.kaika.model.Card;
import com.kaika.model.CardVO;
import com.kaika.service.CardService;


@Service
public class CardServiceImp implements CardService{

	private CardMapper cardMapper;
	
	@Autowired 
	public CardServiceImp(CardMapper cardMapper) {
		this.cardMapper = cardMapper;
	}

	@Override
	public List<Card> listCard(CardVO card) {
		return cardMapper.listByCondition(card);
	}

	@Override
	public int count(CardVO card) {
		return cardMapper.count1(card);
	}

	@Override
	public boolean saveCardInfo(Card card) {
		int status = cardMapper.insertSelective(card);
		if(status>0){
			return true;
		}
		return false;
	}

	@Override
	public boolean updateCardInfo(Card card) {
		int status =  cardMapper.updateByPrimaryKeySelective(card);
		if(status>0){
			return true;
		}
		return false;
	}	

	@Override
	public boolean deleteCard(Integer uid) {
		int status = cardMapper.deleteByPrimaryKey(uid);
		if(status>0){
			return true;
		}
		return false;
	}

	@Override
	public void saveCardsBatch(List<Card> partCrads) {
		cardMapper.insertCardsBatch(partCrads);
	}	

}	

