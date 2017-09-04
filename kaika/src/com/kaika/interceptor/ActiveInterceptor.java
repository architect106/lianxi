package com.kaika.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kaika.model.Card;


public class ActiveInterceptor extends HandlerInterceptorAdapter {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	String requestURI = request.getRequestURI();  
    	
    	//卡号激活数据验证  未通过非空验证，跳转到激活主页面
    	if(requestURI.indexOf("/active/activeCard")>0){
    		String name = request.getParameter("name");
        	String school = request.getParameter("school");
        	String mobile = request.getParameter("mobile");
        	String zipcode = request.getParameter("zipcode");
        	String region = request.getParameter("region");
        	String street = request.getParameter("street");
        	String road = request.getParameter("road");
        	if(name!=null && school!=null && mobile!=null && zipcode!=null && region!=null && 
        			street!=null && road!=null){
        		return true;
        	}
    	}
    	
    	//1、请求到卡片激活登陆
    	if(requestURI.indexOf("/toActiveLogin")>0){
    		return true;
    	}
    	if(requestURI.indexOf("/activeLogin")>0){
    		return true;
    	}
    	if(requestURI.indexOf("/activeCheck")>0){
    		return true;
    	}
    	if(requestURI.indexOf("/activeLogout")>0){
    		return true;
    	}
    	
    	//2、如果卡号成功登陆放行
    	Card card = (Card) request.getSession().getAttribute("card");
    	if(card!=null){
    		return true;
    	}
    	
    	
		response.sendRedirect(request.getContextPath()+"/active/toActiveLogin.do");
        return false;
        
    }

}
