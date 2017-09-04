package com.kaika.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kaika.model.Card;
import com.kaika.model.CardVO;
import com.kaika.model.Journal;
import com.kaika.service.CardService;
import com.kaika.service.JournalService;
import com.kaika.util.JSONUtil;

@Controller
@RequestMapping("/active")
public class ActiveController {
	
	@Autowired
	private CardService cardService;
	
	@Autowired
	private JournalService journalService;
	
	//toActive
	@RequestMapping("/toActiveLogin")
	public String toActive(Model model, HttpServletRequest request){
		Journal journal = journalService.getUseJournal();
		request.getSession().setAttribute("journal", journal);
		return "active/login";
	}
	
	//activeLogin
	@RequestMapping("/activeLogin")
	@ResponseBody
	public String activeLogin(CardVO card, Model model, HttpServletRequest request){
		//用户名密码判断
		//是否激活判断
		if(card.getNumber()!=null && card.getPassword()!=null){
			List<Card> cards = cardService.listCard(card);
			Card dbCard = null;
			if(cards.size()>0){
				dbCard = cards.get(0);
			}
			if(dbCard!=null){
				if(dbCard.getStatus()==0){
					request.getSession().setAttribute("card", dbCard);
					return JSONUtil.getMessage(true, "登陆");
				}
				return JSONUtil.getMessage(false, "卡号已激活");
			}
			return JSONUtil.getMessage(false, "卡号或密码错误");
		}
		return JSONUtil.getMessage(false, "卡号或密码不能为空");
	}
	
	@RequestMapping("/activeCheck")
	@ResponseBody
	public String activeCheck(CardVO card, Model model, HttpServletRequest request){
		//用户名密码判断
		//是否激活判断
		if(card.getNumber()!=null && card.getPassword()!=null){
			List<Card> cards = cardService.listCard(card);
			Card dbCard = null;
			if(cards.size()>0){
				dbCard = cards.get(0);
			}
			if(dbCard!=null){
				if(dbCard.getStatus()==0){
					request.getSession().setAttribute("card", dbCard);
					return JSONUtil.getMessage(false, "卡号未激活");
				}
				String message = dbCard.getJouranl() + "<br>" +
							dbCard.getOrderDate() + "<br>" +
							dbCard.getName() + "<br>" +
							dbCard.getMobile() + "<br>" +
							dbCard.getZipcode() + "<br>" +
							dbCard.getRegionName() + "<br>" +
							dbCard.getStreetName() + "<br>" + 
							"<div class='line'></div>" + 
							"如填写有误<br>" + 
							"请致电:000-0000123<br>" + 
							"工作日:9:30-11:30<br>" + 
							"13:30-16:30";
				return JSONUtil.getMessage(false, message);
			}
			return JSONUtil.getMessage(false, "卡号或密码错误");
		}
		return JSONUtil.getMessage(false, "卡号或密码不能为空");
	}
	
	
	//toActiveCard
	@RequestMapping("/toActiveCard")
	public String toActiveCard(){
		return "active/active";
	}
	
	//activeCard
	@RequestMapping("/activeCard")
	@ResponseBody
	public String activeCard(CardVO card, HttpServletRequest request){
		Card sessionCard = (Card) request.getSession().getAttribute("card");
		request.removeAttribute("card");
		Journal sessionJournal = (Journal) request.getSession().getAttribute("journal");
		Date date = new Date();
		card.setId(sessionCard.getId());
		card.setStatus(1);
		card.setActivationTime(date);
		//设置杂志名称、定期信息
		card.setJouranl(sessionJournal.getJournal());
		card.setOrderDate(sessionJournal.getOrderDate());
		//激活
		boolean status = cardService.updateCardInfo(card);
		if(status){
			return JSONUtil.getMessage(true, "激活卡片成功...");
		}
		return JSONUtil.getMessage(false, "激活卡片失败...");
	}
	
	//activeLogout
	@RequestMapping("/activeLogout")
	public String activeLogout(HttpServletRequest request){
		request.getSession().invalidate();
		return "redirect:/active/toActiveLogin";
	}
	
}
