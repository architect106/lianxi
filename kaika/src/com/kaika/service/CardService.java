package com.kaika.service;

import java.util.List;
import com.kaika.model.Card;
import com.kaika.model.CardVO;

public interface CardService {  

	List<Card> listCard(CardVO card);

	int count(CardVO card);

	boolean saveCardInfo(Card card);

	boolean updateCardInfo(Card card);

	boolean deleteCard(Integer uid);

	void saveCardsBatch(List<Card> partCrads);

}
