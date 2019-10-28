<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
	不以/开始的相对路径，找资源，以当前资源路径为基准，容易出问题
	以/开始的相对路径，找资源，以服务器路径为基准（HTTP://localhost:3306）；需加上项目名
		HTTP://localhost:3306/demo01
 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.min.js"></script>
<!-- 引入样式 -->
 <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_update_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      	<p class="form-control-static" id = "empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			   <label for="empName_update_input" class="col-sm-2 control-label">email</label>
			   <div class="col-sm-10">
			     <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@lyp.com">
			   		<span  class="help-block"></span>
			   </div>
			 </div>
			  <div class="form-group">
			   <label for="empName_update_input" class="col-sm-2 control-label">gender</label>
			   <div class="col-sm-10">
				   	<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="W"> 女
					</label>  
			   	</div>
			   </div>
			  <div class="form-group">
			   <label for="empName_update_input" class="col-sm-2 control-label">deptName</label>
			   <div class="col-sm-4">
			   <!-- 部门提交部门ID即可 -->
			   	<select class="form-control" name="dId">
				  	
				</select>
			   </div>
			 </div>
			
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>


	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			    	<span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			   <label for="empName_add_input" class="col-sm-2 control-label">email</label>
			   <div class="col-sm-10">
			     <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@lyp.com">
			   		<span  class="help-block"></span>
			   </div>
			 </div>
			  <div class="form-group">
			   <label for="empName_add_input" class="col-sm-2 control-label">gender</label>
			   <div class="col-sm-10">
				   	<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
					</label>  
			   	</div>
			   </div>
			  <div class="form-group">
			   <label for="empName_add_input" class="col-sm-2 control-label">deptName</label>
			   <div class="col-sm-4">
			   <!-- 部门提交部门ID即可 -->
			   	<select class="form-control" name="dId">
				  	
				</select>
			   </div>
			 </div>
			
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
		
	</div>
	<script type="text/javascript">
	
		var totalRecord , currentPage;
		
		//页面加载完成后，发送Ajax请求，要到分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
//					console.log(result);
					//解析并显示员工数据
					build_emps_table(result);
					//解析并显示分页信息
					build_page_info(result);
					//解析并显示分页条
					build_page_nav(result);
				}
			});
		}
		
		//解析并显示员工数据
		function build_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.PageInfo.list;
			$.each(emps,function(index,item){
//				alert(item.empName);
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加自定义属性表示id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加自定义属性表示id
				delBtn.attr("del-id",item.empId);
				var BtnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(BtnTd)			
				.appendTo("#emps_table tbody");
			});
		}
		//解析并显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.PageInfo.pageNum+"页,总"+
					result.extend.PageInfo.pages+"页,总"+
					result.extend.PageInfo.total+"条记录");
					totalRecord = result.extend.PageInfo.total;
					currentPage = result.extend.PageInfo.pageNum;
		}
		//解析并显示分页条
		function build_page_nav(result){
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			
			if(result.extend.PageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum -1);
				});
			}
			
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("herf","#"));

			if(result.extend.PageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.PageInfo.pages);
				});
			}
			
			$.each(result.extend.PageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.PageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				})
				//添加遍历页码
				ul.append(numLi);
			});
			//添加后一页与末页
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		function reset_form(ele){
			//清空表单数据
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，弹出新增对话框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据及样式
			reset_form("#empAddModal form");
			//$("#empAddModal form")[0].reset();
			//发送Ajax请求，查出部门信息
			getDepts("#empAddModal select");
			//弹出对话框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出部门信息并显示
		function getDepts(ele){
			//清空之前下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					//console.log(result);
					//显示信息在列表
					//$("#dept_add_select");
					//$("empAddModal select")
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验方法
		function validate_add_form(){
			//拿到数据
			//校验用户名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名需要为6-16位英文或数字组合或3-5位中文");
				show_validate_msg("#empName_add_input","error","用户名需要为6-16位英文或数字组合或3-5位中文");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			};
			//校验邮箱
			var email = $("#email_add_input").val();
			var regmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空元素之前的样式
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
			};
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if ("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//检验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送Ajax请求检验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax_va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax_va","error");
					}
				}
			});
		});
		
		//点击保存
		$("#emp_save_btn").click(function(){
			//将数据提交进行保存
			//对数据进行校验
			if(!validate_add_form()){
				return false;
			};
			//判断Ajax用户名校验是否成功
			if($(this).attr("ajax_va")=="error"){
				return false;
			}
			//发送Ajax请求保存
			//alert($("#empAddModal form").serialize());
			$.ajax({
				url:"${APP_PATH}/emps",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
					//保存成功：关闭模态框，来到添加的那一页
					$("#empAddModal").modal('hide');
					to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						if(undefined != result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							//显示名字错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		//创建按钮前绑定click,所以绑定不了
		//1、可以在创建时绑定
		//2、绑定点击.live()
		//jquery新版本没有live方法，用on替代
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			//1、查出部门信息并显示部门列表
			getDepts("#empUpdateModal select");
			//2、查出员工信息
			getEmp($(this).attr("edit-id"));
			//把员工id传递给模态框更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emps/"+id,
				type:"GET",
				success:function(result){
					console.log(result);
					var empData = result.extend.emps;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);				
					$("#empUpdateModal input[name=gender]").val([empData.gender]);				
					$("#empUpdateModal select").val([empData.dId]);				
				}
			});
		}
		
		//更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱
			var email = $("#email_update_input").val();
			var regmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空元素之前的样式
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			
			//发送Ajax请求更新员工
			$.ajax({
				url:"${APP_PATH}/emps/"+$(this).attr("edit-id"),
				//type:"POST",
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//关闭对话框
					$("#empUpdateModal").modal('hide');
					//回到页面
					to_page(currentPage);
				}
			});
		});

		//单个删除
		$(document).on("click",".delete_btn",function(){
			//弹出是否确认删除
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗?")){
				//确认，发送Ajax请求确认
				$.ajax({
					url:"${APP_PATH}/emps/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选
		$("#check_all").click(function(){
			//attr获取checked是undefined
			//alert($(this).attr("checked"));
			//dom原生属性使用prop,attr获取自定义属性
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		$(document).on("click",".check_item",function(){
			//判断是否选中五个
			//alert($(".check_item:checked").length);
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//alert($(this).parents("tr").find("td:eq(2)").text());
				//组装员工姓名字符串
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工ID字符串
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除empNames多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			//去除del_idstr多余的-
			del_idstr = del_idstr.substring(0,empNames.length-1);
			if(confirm("确认删除【"+empNames+"】吗?")){
				//发送Ajax请求
				$.ajax({
					url:"${APP_PATH}/emps/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>