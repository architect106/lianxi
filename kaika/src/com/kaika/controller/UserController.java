package com.kaika.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kaika.model.User;
import com.kaika.service.UserService;
import com.kaika.util.JSONUtil;


@Controller
@RequestMapping("/user")
public class UserController{

	@Autowired
	private UserService userService;
	
	//toLogin
	@RequestMapping("/toLogin")
	public String toLogin(){
		return "user/login";
	}
	
	//login
	@RequestMapping("/login")
	public String login(User user, HttpServletRequest request) {
		//登陆数据验证
		//从数据库根据用户名密码查询数据库
		//根据获取的数据库对象做判断，如果不为空，则跳转到主页面
		//否则的话重定向到登陆页面
		if(user.getUsername()!=null && user.getPassword()!=null){
			user.setDeleted(1);
			List<User> users = userService.listUser(user);
			User loginUser = null;
			if(users.size()>0){
				loginUser = users.get(0);
			}
			if(loginUser != null){
				request.getSession().setAttribute("loginUser",loginUser);
				return "index/index";
			}else{
				return "redirect:/user/toLogin";
			}
		}
		return "redirect:/user/toLogin";
	}
	
	//logout
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	//toListUser
	@RequestMapping("/toListUser")
	public String toListUser(){
		return "user/listUser";
	}
	
	//listUser
	@RequestMapping("/listUser")
	@ResponseBody
	public String listUser(User user, Model model){
		user.setDeleted(1);
		List<User> users = userService.listUser(user);
		return JSONUtil.getAllData(users);
	}
	
	//toHandleUserInfo
	@RequestMapping("/toHandleUserInfo")
	public String toHandleUserInfo(User user, Model model) {
		if(user.getId()!=null){
			user = userService.listUser(user).get(0);
			model.addAttribute("user", user);
		}
		return "user/userInfo";
	}
	
	//handleUserInfo
	@RequestMapping("/handleUserInfo")
	@ResponseBody
	public String handleUserInfo(User user, Model model, HttpServletRequest request) {
		if(user.getId()!=null){
			if(user.getDeleted()!=null){
				//逻辑删除
				boolean status = userService.updateUserInfo(user);
				if(status){
					return JSONUtil.getMessage(true, "删除数据成功...");
				}
				return JSONUtil.getMessage(false, "删除数据失败...");
			}else{
				//更新
				boolean status = userService.updateUserInfo(user);
				if(status){
					return JSONUtil.getMessage(true, "更新数据成功...");
				}
				return JSONUtil.getMessage(false, "更新数据失败...");
			}
		}else{
			//判断是否存在相同卡号
			User u = new User();
			u.setUsername(user.getUsername());
			List<User> users = userService.listUser(u);
			User dbUser = null;
			if(users.size()>0){
				dbUser = users.get(0);
			}
			//新增
			if(dbUser==null){
				user.setDeleted(1);
				boolean status = userService.saveUserInfo(user);
				if(status){
					return JSONUtil.getMessage(true, "新增数据成功...");
				}
				return JSONUtil.getMessage(false, "新增数据失败...");
			}else{
				return JSONUtil.getMessage(false, "已存在相同的用户名...");
			}
		}
	}
	
	
}
