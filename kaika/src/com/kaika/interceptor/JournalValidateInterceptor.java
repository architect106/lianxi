package com.kaika.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kaika.model.User;


public class JournalValidateInterceptor extends HandlerInterceptorAdapter {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	String requestURI = request.getRequestURI(); 
    	
    	//当表单请求提交的时候，对该请求进行进行拦截，然后判断获取的数据，进行非空判断
    	String id = request.getParameter("id");
		String journal = request.getParameter("journal");
		String press = request.getParameter("press");
		String orderDate = request.getParameter("orderDate");
		String content = request.getParameter("content");
		String deleted = request.getParameter("deleted");
    	
		//journal增改
    	if(requestURI.indexOf("/journal/handleJournalInfo")>0){
    		if(id!=null && journal!=null && press!=null && orderDate!=null && content!=null){
    			return true;
    		}else if(journal!=null && press!=null && orderDate!=null && content!=null){
    			return true;
    		}
    	}
    	
    	//journal删除、使用
    	if(requestURI.indexOf("/journal/updateJournalStatus")>0){
    		if(id!=null && deleted!=null){
    			return true;
    		}
    	}
    	
    	//2、如果用户已登录放行 
    	User user = (User) request.getSession().getAttribute("loginUser");
    	if(user!=null){
    		return true;
    	}
    	
		response.sendRedirect(request.getContextPath()+"/journal/toListJournal.do");
        return false;
        
    }

}
