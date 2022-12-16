package kr.or.ddit.autumn.commons.login.handler;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Inet4Address;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.ClassPathResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
	@Inject
	EmployeeService service;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		super.onAuthenticationSuccess(request, response, authentication);
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO employee = adapter.getRealUser();
		HttpSession session = request.getSession();
		service.onlineEmployee(employee.getEmpId());
		
		log.info("로그인 성공! EmployeeVO session에 저장!!");
		log.info("Session Save Data : {}", employee);
		log.info("Attribute Name : authEmp");
		
		session.setAttribute("authEmp", employee);
		session.setMaxInactiveInterval(60*60);
		
		if(employee.getEmpSign() == null) {
			
			ServletContext application = request.getServletContext();
			String filepath = application.getRealPath("/resources/groupware/icon/approval.png");
			File file = new File(filepath);
			try (
				FileInputStream fis = new FileInputStream(file);
				ByteArrayOutputStream bos = new ByteArrayOutputStream();	
			){
				log.info("\n\n\n 들어오나 ?!?!?!?!?!?!?!?!?!?!?!");
				int temp = -1;
				byte[] buffer = new byte[1024];
				byte[] defaultImg = null;
				log.info("\n\n\n stream start ?!?!?!?!?!?!?!?!?!?!?!");
				while( (temp = fis.read(buffer, 0, buffer.length)) != -1) {
					bos.write(buffer, 0, temp);
				}
				log.info("\n\n\n stream end ?!?!?!?!?!?!?!?!?!?!?!");
				defaultImg = bos.toByteArray();
				log.info("\n\n\n 들어오나 ?!?!?!?!?!?!?!?!?!?!?! {} ", defaultImg);
				employee.setEmpSign(defaultImg);
			} catch (Exception e) {
				throw new RuntimeException("img setting error : " + e.getMessage());
			}
		}
		
		LogVO log = new LogVO();
		
		log.setEmpId(employee.getEmpId());
		log.setLogIp(Inet4Address.getLocalHost().getHostAddress());
		
		service.createLoginInfo(log);
		
		
	}
}
