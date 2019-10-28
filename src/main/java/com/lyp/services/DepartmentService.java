package com.lyp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyp.bean.Department;
import com.lyp.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDepts() {
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
