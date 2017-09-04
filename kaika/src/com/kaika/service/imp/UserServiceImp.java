package com.kaika.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kaika.mapper.UserMapper;
import com.kaika.model.User;
import com.kaika.service.UserService;


@Service
public class UserServiceImp implements UserService{

	private UserMapper userMapper;
	
	@Autowired 
	public UserServiceImp(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public List<User> listUser(User user) {
		return userMapper.listByCondition(user);
	}

	@Override
	public int count(User user) {
		return userMapper.count(user);
	}

	@Override
	public boolean saveUserInfo(User user) {
		int status = userMapper.insertSelective(user);
		if(status>0){
			return true;
		}
		return false;
	}

	@Override
	public boolean updateUserInfo(User user) {
		int status = userMapper.updateByPrimaryKeySelective(user);
		if(status>0){
			return true;
		}
		return false;
	}	

	@Override
	public boolean deleteUser(Integer uid) {
		int status = userMapper.deleteByPrimaryKey(uid);
		if(status>0){
			return true;
		}
		return false;
	}	

}	

