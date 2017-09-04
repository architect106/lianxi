package com.kaika.service;

import java.util.List;
import com.kaika.model.User;

public interface UserService {  

	List<User> listUser(User user);

	int count(User user);

	boolean saveUserInfo(User user);

	boolean updateUserInfo(User user);

	boolean deleteUser(Integer uid);

}
