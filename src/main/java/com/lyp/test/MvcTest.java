package com.lyp.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.lyp.bean.Employee;

/**
 * 使用spring测试模块提供的测试请求功能，测试CRUD请求的功能
 * spring4测试时需要sevlet3.0支持
 * @author 刘
 *
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","File:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	//传入springmvc的ioc
	@Autowired 
	WebApplicationContext context;
	//虚拟MVC请求，获取结果
	MockMvc mockMvc;
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//请求成功后，请求域中有pageinfo，可以取出进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码："+pi.getPages());
		System.out.println("总记录数："+pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(" "+i);
		}
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID"+employee.getdId()+"-->name:"+employee.getEmpName());
		}
	}
}
