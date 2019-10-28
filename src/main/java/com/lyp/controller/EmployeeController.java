package com.lyp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lyp.bean.Employee;
import com.lyp.bean.Msg;
import com.lyp.services.EmployeeService;

/**
 * 处理员工CRUD请求
 * @author 刘
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 单个批量二合一
	 * 批量1-2-3
	 * 单个1
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emps/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids) {
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	
	/**
	 * 直接使用Ajax=PUT请求
	 * 封装的数据
	 * Employee 
	 * [empId=1011, empName=null, gender=null, email=null, dId=null, department=null]
	 * 
	 * 问题：
	 * 请求体中有数据
	 * employee对象没封装
	 * update tbl_emp where d_id = 1011
	 * 
	 * 原因：
	 * tomcat
	 *	将请求体中数据，封装一个map
	 *	request.getParameter("empName")就会从map中取值
	 *	springmvc封装POJO对象时，会把每个属性request.getParameter("empName")拿到
	 *
	 *要能直接支持：
	 *配置：HttpPutFormContentFilter
	 *作用：请求体中数据包装成map
	 *
	 * 员工更新
	 */
	@RequestMapping(value = "/emps/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		//System.out.println("将要更新的数据"+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emps/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emps", employee);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		//判断用户名是否合法
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名需要为6-16位英文或数字组合或2-5位中文");
		}
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 1、支持jsr303
	 * 2、导入Hibernate-Validator
	 * 
	 * 员工保存
	 * @return
	 */
	@RequestMapping(value="/emps", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if (result.hasErrors()) {
			//校验失败,返回失败，在状态框中显示
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 使用request mapping需要导入Jackson包
	 * @param pn
	 * @return
	 */
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn) {
				//这不是一个分页查询
				//引入pagehelper分页插件
				//查询之前只需要调用,传入页码以及每页大小
				PageHelper.startPage(pn,5);
				//之后的查询就是分页查询
				List<Employee> emps = employeeService.getAll();
				//使用pageinfo包装查询后的结果，只需要将PageInfo交给页面就行
				//封装了详细的分页信息，包括查询出来的数据,传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("PageInfo", page);
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn ,Model model) {
		//这不是一个分页查询
		//引入pagehelper分页插件
		//查询之前只需要调用,传入页码以及每页大小
		PageHelper.startPage(pn,5);
		//之后的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询后的结果，只需要将PageInfo交给页面就行
		//封装了详细的分页信息，包括查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
}
