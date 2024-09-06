package com.springmvc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.domain.child;
import com.springmvc.domain.childinfo;
import com.springmvc.repository.childrepository;

@Service
public class childServiceImpl implements childService{
   @Autowired
   private childrepository childRepository;

   @Override
   public void create(child baby,HttpServletRequest request) {
      // TODO Auto-generated method stub
      
      childRepository.create(baby,request);
      System.out.println(baby.getBirth());
      
   }

	@Override
	public List<child> readAll() {
		System.out.println("readall");
		return childRepository.readAll();
	}

	@Override
	public child readone(int num) {
		System.out.println("read one 서비스");
		child childserviceone = childRepository.readone(num);
		return childserviceone;
	}

	@Override
	public void update(child baby) {
		System.out.println("update 서비스");
		childRepository.update(baby);
	}

	@Override
	public void delete(int num) {
		System.out.println("delete 서비스");
		childRepository.delete(num);
	}

	
	//childinfo crud 시작 
	@Override
	public List<childinfo> allread() {
		System.out.println("childinfo allread 서비스");
		
		return childRepository.allread();
	}

	@Override
	public childinfo oneinfo(String age_info) {
		System.out.println("oneinfo service");
		return childRepository.oneinfo(age_info);
	}

	@Override
	public List<child> readAllByMemberId(String id) {
		return childRepository.readAllByMemberId(id);
	}
	
}	