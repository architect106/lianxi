package com.kaika.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kaika.model.User;


public class LoginInterceptor extends HandlerInterceptorAdapter {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	String requestURI = request.getRequestURI(); 
    	
    	//用户管理数据验证
    	if(requestURI.indexOf("/user/handleUserInfo")>0){
    		String id = request.getParameter("id");
    		String name = request.getParameter("name");
    		String username = request.getParameter("username");
    		String password = request.getParameter("password");
    		if(id!=null && name!=null && username!=null && password!=null){
    			return true;
    		}else if(name!=null && username!=null && password!=null){
    			return true;
    		}else if(id!=null){
    			return true;
    		}
    	}
    	
    	//1、请求到后台登录登出放行
    	if(requestURI.indexOf("/toLogin")>0){
    		return true;
    	}
    	if(requestURI.indexOf("/login")>0){
    		return true;
    	}
    	if(requestURI.indexOf("/logout")>0){
    		return true;
    	}
    	
    	//2、如果用户已登录放行 
    	User user = (User) request.getSession().getAttribute("loginUser");
    	if(user!=null){
    		return true;
    	}
    	
		response.sendRedirect(request.getContextPath()+"/user/toLogin.do");
        return false;
        
    }

}
