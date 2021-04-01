<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="scripts/form-data; charset=utf-8" />
<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script><!-- 引用jquery.js -->
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script><!-- 引用jquery.js -->

<title>学生列表</title>
<script type="text/javascript">
	$(function(){
		
			query();	
		 	
			add();
			
			qingkon();//清空新增框里的值 
			

	});
	/**
	*添加
	*/
	function add(){
	$("#add").click(function(){
		getClas();
		var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
		formData.append("file",$("#head")[0].files[0]);
		//formData.append("student", JSON.stringify(student));
		//formData.append(student);
	//序列化表单不会序列化file字段.
		var student=$("#addForm").serializeObject();
		 	//把json转换成formdate
		Object.keys(student).forEach((key) => {
		formData.append(key,student[key]);	
		});   	
		$.ajax({
			url:"add",
			type:"post",
			dataType:"json",
			data:formData,
			processData: false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
            contentType: false,//这个必须有，不然会报错
			success:function(s){	
			$("#test").append("<tr><td>"+s.id+"</td><td>"+student.name+"</td><td>"+student.sex+"</td><td>"+student.age+"</td><td>"+student.eilme+"</td><td>"+student.salary+"</td><td>"+student.date+"</td><td>"+student.headPath+"</td><td>"+student.className+"</td><td><a class='update' href='update/"+s.id+"'>修改</a></td><td><a class='delete' href='dedelete/"+s.id+"'>删除</a></td></tr>");				
			$("#AddDiv").hide();//添加成功之后隐藏div 	
			query();
			},
			error:function(){
				alert("添加失败");
			}
		});
	});	
	}
	/**
	*查询
	*/
	function query(){
		 $.ajax({
			 url:"studentList",
			 dataType:"json",
			 success:function(stu){		
				 $("#test").empty();//清空
				 $("#test").append("<tr><td>id</td><td>姓名</td><td>性别</td><td>年龄</td><td>邮箱</td><td>工资</td><td>时间</td><td>图片</td><td>班级</td><td>删除</td><td>修改</td></tr>");
				for(var i = 0;i<stu.length;i++){
					$("#test").append("<tr><td>"+stu[i].id+"</td><td>"+stu[i].name+"</td><td>"+(stu[i].sex==1?'男':'女')+"</td><td>"+stu[i].age+"</td><td>"+stu[i].eilme+"</td><td>"+stu[i].salary+"</td><td>"+stu[i].date+"</td><td><img width=50 height=60 alt='头像' src='fileX?headPath="+stu[i].headPath+"'></td><td>"+stu[i].className.name+"</td><td><a class='update' href='update/"+stu[i].id+"'>修改</a></td><td><a class='delete' href='dedelete/"+stu[i].id+"'>删除</a></td></tr>");
				}
				dele();
				update();
			 },
			 error:function(){
				 alert("失败");
			 }
		});
		
	}
	/**
	 * 删除
	 */
	function dele(){
		$(".delete").click(function(){
				var id=$(this).attr("href");
				var ta=$(this).parent().parent();
				$.ajax({
					type:"delete",
					url:id,
					dataType:"text",
					success:function(student){
						ta.remove();
					},
					error:function(){
						alert("删除失败");
					}
				})
				return false;//超链接是get请求  为了不让他跳转页面
		})
	}
	//清空img
	function igm(){
		$("#bbb").attr('src'," ");
	}
	/**
	*修改
	*/
	function update(){
		$(".update").click(function(){
			getClas();
			var id = $(this).attr("href");	
			$("#updateDiv").show();//显示
			$("#AddDiv").hide();//隐藏
			//直接从界面获取值，填入到输入框当中
			//先获取tr.再通过tr获取TD集合，再获取td里的值
			//通过ID查询对要修改的对象,进行数据回显
			 $.ajax({
					type:"get",
			    	url:id,   	
			    	dataType:"json",
			    	success:function(student)
			    	{
			    		$("#id").val(student.id);//修改,是根据ID来修改
			    		$("#uname").val(student.name);
			    		$("input[name='sex']:radio[value="+student.sex+"]").prop("checked",true);
			    		$("#uage").val(student.age);
			    		$("#ueilme").val(student.eilme);   
			    		$("#usalary").val(student.salary);	
			    		$("#udate").val(student.date);
			    		var head="fileX?headPath="+student.headPath;
			    		$("#bbb").attr('src',head);
			    		$("select option[value='"+student.className.id+"']").prop("selected",true);
			    	},
			    	error:function(){
			    		alert("发生错误");
			    	}
			    });	 
				return false;
		});	
		$("#xiugai").click(function(){
			 var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
				formData.append("file",$("#uhead")[0].files[0]);
				//formData.append("student", JSON.stringify(student));
				//formData.append(student);			
				//序列化表单不会序列化file字段.
				var student=$("#updateForm").serializeObject();
				//把json转换成formdate
				 Object.keys(student).forEach((key) => {	
					formData.append(key,student[key]);
				});
				formData.append("_method","put");		
				 $.ajax({  
				    	url:"updatexg",
				    	type:"post",
				    	data:formData,
				    	dataType:"json",
						processData: false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
			            contentType: false,//这个必须有，不然会报错
				    	success:function(stu){	
				    		 //循环所有的TR里面的第一个TD
				    		$("#test tr").find("td:eq(0)").each(function(){
				    			//如果第一个TD的值正好是我们需要修改的ID值，就表示我们刚才修改的就是这行
								if($(this).text() == stu.id){
									$(this).parent().find("td:eq(1)").text(stu.name);
									$(this).parent().find("td:eq(2)").html(stu.sex ==1? '男':'女');
									$(this).parent().find("td:eq(3)").text(stu.age);					
									$(this).parent().find("td:eq(4)").text(stu.eilme);
									$(this).parent().find("td:eq(5)").text(stu.salary);
									$(this).parent().find("td:eq(6)").text(stu.date);
									$(this).parent().find("td:eq(7)").html("<img width=50 height=60 alt='头像' src='fileX?headPath="+stu.headPath+"'>");
									$(this).parent().find("td:eq(8)").text(stu.className.name);
								}
							});    
				    		$("#updateDiv").hide();//隐藏之后隐藏div
				    	},
				    	error:function(){
				    		alert("修改失败");  		
				    	}
				    });	 
			});
	}
	function getClas(){
		$("select[name='className.id']").empty();//清空
		$.ajax({
			 url:"clas",
			 dataType:"json",
			 success:function(clas){		
				for(var i = 0;i<clas.length;i++){
					$("select[name='className.id']").append("<option value="+clas[i].id+">"+clas[i].name+"<option/>");
				}
			 },
			 error:function(){
				 alert("失败");
			 }
			 });
	}
 $(function(){
	
	$("#addStudent").click(function(){
		$("#AddDiv").show();//显示
		$("#updateDiv").hide();//隐藏
	})
	
	
	$("#qxadd").click(function(){
		$("#AddDiv").hide();//隐藏
		qingkon();//清空新增框里的值
	})
	
	$("#qxxiugai").click(function(){
		$("#updateDiv").hide();//隐藏
 		qingkon();//清空新增框里的值
	});
 })
/**
 * 序列化
 */
$(function(){
	$.fn.serializeObject = function () {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function () {
		    if (o[this.name] !== undefined) {
		        if (!o[this.name].push) {
		            o[this.name] = [o[this.name]];
		        }
		        o[this.name].push(this.value || '');
		    } else {
		        o[this.name] = this.value || '';
		    }
		});
		return o;
		};
})
/**
 * 清空新增框里的值
 */
function qingkon(){
	$("#name").val("");
	$("input[type='radio'][name='sex']").each(function(){
		$(this).prop("checked",false);
	});
	$("#age").val("");
	$("#eilme").val("");
	$("#salary").val("");
	$("#date").val("");
	$("#head").val("");
}


</script>
</head>
<body >

	<input type="button" id="addStudent" value="添加" >
	<table id="test" border="1">	
		<tr>	
				<td><fmt:message key="i18n.id"></fmt:message></td>
				<td><fmt:message key="i18n.aaa"></fmt:message></td>				
				<td><fmt:message key="i18n.sex"></fmt:message></td>
				<td><fmt:message key="i18n.age"></fmt:message></td>
				<td><fmt:message key="i18n.eilme"></fmt:message></td>
				<td><fmt:message key="i18n.salary"></fmt:message></td>
				<td><fmt:message key="i18n.time"></fmt:message></td>			
				<td><fmt:message key="i18n.headPath"></fmt:message></td>
				<td><fmt:message key="i18n.bang"></fmt:message></td>
				<td><fmt:message key="i18n.compile"></fmt:message></td>
				<td><fmt:message key="i18n.delete"></fmt:message></td>
		</tr>
	</table>
	<br>

	<div id="AddDiv" style="display: none">
	<form id="addForm" >
	姓名：<input type="text" name="name" id="name">
		<br>
	性别:<input type="radio" name="sex" value="1">男
		<input type="radio" name="sex" value="0">女
		<br>
	年龄:<input type="text" name="age" id="age" >
		<br>
	邮箱:<input type="text" name="eilme" id="eilme" >
		<br>
	  工资:<input type="text" name="salary" id="salary" >
		<br>
	时间:<input type="text" name="date" id="date" >
		<br> 
 	头像:<input type="file" name="headPath" id="head">
		<br> 
	班级：<select id="className.id" name="className.id" >
		
		</select>
		<br>
		<input  type="button" id="add" value="提交">
		<input  type="button" id="qxadd" value="取消提交">
	</form>
	</div>
	
	
	<div id="updateDiv" style="display: none">
	<img width="40" height="60" alt="" src="" id="bbb">	
	<form id="updateForm" >
	 <input type="hidden" name="id" id="id"> 
	姓名：<input type="text" name="name" id="uname">
		<br>
	性别:<input type="radio" name="sex"  value="1">男
		<input type="radio" name="sex"  value="0">女
		<br>
	年龄:<input type="text" name="age" id="uage" >
		<br>
	邮箱:<input type="text" name="eilme" id="ueilme" >
		<br>
	 工资:<input type="text" name="salary" id="usalary" >
		<br>
	时间:<input type="text" name="date" id="udate" >
		<br> 
 	头像:<input type="file" name="headPath" id="uhead">
		<br> 
	班级：<select id="uclassName.id" name="className.id" >	
		</select>
		<br>
		<input  type="button" id="xiugai" value="修改">
		<input  type="button" id="qxxiugai" value="取消修改">
	</form>
	</div>
</body>
</html>