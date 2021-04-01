package entity;

import java.util.Date;


import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;


public class Student {
	private int id;//id
	private String name;//姓名
	private int sex;//
	private int age;//
	private String eilme;//
	@NumberFormat(pattern = "#,###,###.##")
	private Float salary;//
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date date;//
	private String headPath;//
	private int clssId;
	private Clas className;//

	public int getClssId() {
		return clssId;
	}

	public void setClssId(int clssId) {
		this.clssId = clssId;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEilme() {
		return eilme;
	}
	public void setEilme(String eilme) {
		this.eilme = eilme;
	}
	public Float getSalary() {
		return salary;
	}
	public void setSalary(Float salary) {
		this.salary = salary;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getHeadPath() {
		return headPath;
	}
	public void setHeadPath(String headPath) {
		this.headPath = headPath;
	}
	
	public Clas getClassName() {
		return className;
	}
	public void setClassName(Clas className) {
		this.className = className;
	}

	@Override
	public String toString() {
		return "Student{" +
				"id=" + id +
				", name='" + name + '\'' +
				", sex=" + sex +
				", age=" + age +
				", eilme='" + eilme + '\'' +
				", salary=" + salary +
				", date=" + date +
				", headPath='" + headPath + '\'' +
				", clssId=" + clssId +
				", className=" + className +
				'}';
	}
}
