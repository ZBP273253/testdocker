package Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import entity.Clas;
import entity.Page;
import entity.Student;
import com.service.ClasService;
import com.service.StudentService;

@SessionAttributes(value = {"locale"})
@Controller("studentController")
public class StudentController {
	@Autowired
	private StudentService studentService;

	@Autowired
	private ClasService clasService;
	/**
	 * 修改时查询对象 把没有修改的字段进行覆盖
	 * @param
	 * @param
	 */
//	@ModelAttribute
//	public void getEmployee(@RequestParam(value="id",required=false) Integer id,
//			Map<String, Object> map){
//		if(id != null){
//			map.put("student", studentService.updateById(id));
//		}
//	}
	@ResponseBody
	@RequestMapping(value="/clas")
	public List<Clas> getClasAll(){

		return clasService.ClasgetAll();
	}
	/**
	 * 查询
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/studentList")
	public List<Student> get(){
	return  studentService.getStudentAll();
	}
	/**
	 * 分页
	 * @param page
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/query",method=RequestMethod.GET)
	public Page<Student> query(Page<Student> page){
		  studentService.query(page);
		  return page;
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/dedelete/{id}", method=RequestMethod.DELETE,produces = "application/json;charset=utf-8")
	public String delete(@PathVariable("id")Integer id){
		studentService.delete(id);
		return "删除成功";
	}
	/**
	 * 修改 回显
	 * @param id
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/update/{id}", method=RequestMethod.GET)
	public Student inpua(@PathVariable("id") Integer id){
	return  studentService.updateById(id);

	}
	/**
	 * 修改
	 * @param student
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/updatexg", method=RequestMethod.PUT)
	public Student update(Student student,@RequestParam("file")MultipartFile headPath)throws Exception{
			InputStream inputStream = headPath.getInputStream();
			String headName= System.currentTimeMillis()+".jpg";
			// 输出流,保存文件的
			OutputStream out = new FileOutputStream(new File("E:\\spring-mybatis-java\\web\\abc\\"+headName));
			byte b[] = new byte[1024 * 1024 * 10];
			int i = inputStream.read(b);
			while (i != -1) {
				out.write(b, 0, i);
				i = inputStream.read(b);
			}
			  out.close();
			  inputStream.close();
			  //将文件名放入head
			student.setHeadPath(headName);
			studentService.update(student);

			return studentService.updateById(student.getId());
	}

	/**
	 * 添加
	 * @param student
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public int save(Student student,@RequestParam("file")MultipartFile headPath)throws Exception{
			InputStream inputStream = headPath.getInputStream();
			String headName= System.currentTimeMillis()+".jpg";
			// 输出流,保存文件的
			OutputStream out = new FileOutputStream(new File("E:\\spring-mybatis-java\\web\\abc\\"+headName));
			byte b[] = new byte[1024 * 1024 * 10];
			int i = inputStream.read(b);
			while (i != -1) {
				out.write(b, 0, i);
				i = inputStream.read(b);
			}
			  out.close();
			  inputStream.close();
			  //将文件名放入head
			student.setHeadPath(headName);
			studentService.add(student);
			System.out.println(student);
			return student.getId();
	}
	/**
	 * 文件下载    有限制   超出一定的m就会报错
	 * @param session
	 * @param headName
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "fileX")
	public ResponseEntity<byte[]> testResponseEntity(HttpSession session,@RequestParam("headPath") String headName) throws IOException {
		String headPath="E:\\spring-mybatis-java\\web\\abc\\"+headName;
			byte[] body = null;
			// 获取当前项目的路径
			// InputStream in = servletContext.getResourceAsStream("/files/abc.txt");
			InputStream in=new FileInputStream(new File(headPath));
			body = new byte[in.available()];
			in.read(body);
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Disposition", "attachment;filename="+headName.split("\\\\")[+headName.split("\\\\").length-1]);
			HttpStatus statusCode = HttpStatus.OK;
			ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(body, headers, statusCode);
			return response;
		}
}
