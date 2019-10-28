package com.lyp.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lyp.bean.Department;
import com.lyp.bean.Employee;
import com.lyp.dao.DepartmentMapper;
import com.lyp.dao.EmployeeMapper;

/*
 * 测试dao层工作
 * 
 * spring 项目测试使用spring单元测试，可以自动注入
 * 
 * 导入spring单元测试模块
 * @ContextConfiguration指定spring配置文件位置
 * 直接auto wired要使用的组件即可
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	/*
	 * 测试DepartmentMappper
	 * 
	 * */

	private EmployeeMapper mapper;
	
	@Test
	public void TestCRUD() {
//		//创建springioc容器
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//从容器中获取Mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		
		//插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//生成员工数据
//		employeeMapper.insertSelective(new Employee(null, "Bob", "M", "Bob@lyp.com", 1));
//		employeeMapper.insertSelective(new Employee(null, "Jery", "W", "Jery@lyp.com", 2));
		
		//批量插入
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@lyp.com", 1));
		}
	}
}
