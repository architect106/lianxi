package com.kaika.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kaika.model.User;


public class CardValidateInterceptor extends HandlerInterceptorAdapter {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	//当表单请求提交的时候，对该请求进行进行拦截，然后判断获取的数据，进行非空判断
    	String requestURI = request.getRequestURI();  
    	//1.card增删改
    	if(requestURI.indexOf("/card/handleCardInfo")>0){
    		String id = request.getParameter("id");
    		String number = request.getParameter("number");
    		String password = request.getParameter("password");
    		String name = request.getParameter("name");
    		String school = request.getParameter("school");
    		String mobile = request.getParameter("mobile");
    		String zipcode = request.getParameter("zipcode");
    		String region = request.getParameter("region");
    		String street = request.getParameter("street");
    		String road = request.getParameter("road");
    		String jouranl = request.getParameter("jouranl");
    		String remark = request.getParameter("remark");
    		if(id!=null && number!=null && password!=null && name!=null && school!=null 
    				&& mobile!=null && zipcode!=null && region!=null && street!=null && road!=null 
    				&& jouranl!=null && remark!=null){
    			return true;
    		}else if(number!=null && password!=null){
    			return true;
    		}else if(id!=null){
    			return true;
    		}
    	}
    	
    	//2、如果用户已登录放行 
    	User user = (User) request.getSession().getAttribute("loginUser");
    	if(user!=null){
    		return true;
    	}
    	
		response.sendRedirect(request.getContextPath()+"/card/toListCard.do");
        return false;
        
    }

}
