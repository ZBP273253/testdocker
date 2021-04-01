package com.service;


import entity.Page;
import mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import entity.Student;

import java.util.List;

@Service("studentService")
public class StudentService {
	@Autowired()
	private StudentMapper studentMapper;
	/*
	* 分页查询
	* */
	@Transactional
	public void query(Page<Student> page) {
		//总页数
		Integer sum=studentMapper.count();
		//当前页数减1乘每页多少条
		int cou=((page.getPageNo()-1))*page.getPageSize();
		page.setPagexb(cou);
		page.setSum(sum);
		List<Student> list=studentMapper.list(page);
		page.setList(list);
	}
	/*
	*查询所以
	*  */
	@Transactional
	public List<Student> getStudentAll() {
	return studentMapper.getList();
	}
	/*
	* 添加
	* */
	@Transactional()
	public int  add(Student student) {
		studentMapper.add(student);
		 return student.getId();
	}
	/*
	* 根据id删除
	* */
	@Transactional()
	public void delete(Integer id) {
		studentMapper.delete(id);
	}
	/*
	* 根据id回显
	* */
	@Transactional
	public Student updateById(int id) {
		 return studentMapper.getUpdateById(id);
	}
	/*
	* 修改
	* */
	@Transactional
	public void update(Student student) {
		student.setClssId((student.getClassName().getId()));
		System.out.println(student);
		studentMapper.update(student);
	}
}
