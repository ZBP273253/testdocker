package mapper;

import entity.Page;
import entity.Student;

import java.util.List;

public interface StudentMapper {
	 List<Student> list(Page<Student> page);

	List<Student> getList();

	Integer count();

	 void add(Student student);
	
	 void delete(Integer id);
	
	 Student getUpdateById(int id);
	
	 void update(Student student);



//	/**
//	 * @param page
//	 */
//	public void getList(Page<Student> page){
//		String sqlCount="select count(s) from Student s";//查询总条数
//		Query query=(Query) getSession().createQuery(sqlCount);
//		Long sum=(Long) query.uniqueResult();//必须使用long类型  否则无法接住
//
//		int start=(page.getPageNo() - 1) * page.getPageSize();
//		String sql="select s from Student s left join fetch s.className";
//		Query queryList=(Query) getSession().createQuery(sql);
//		queryList.setFirstResult(start);
//		queryList.setMaxResults(page.getPageSize());
//		List<Student> list=queryList.list();
//		page.setList(list);
//		page.setSum(sum);
//	}
	}

