package kr.co.mvc.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.mvc.user.dao.UserCardDAO;

@Component
public class UserCardService {
	
	@Autowired
	private UserCardDAO cardDAO;
}
