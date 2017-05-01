package project2.scmaster.rodo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import project2.scmaster.rodo.vo.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		String loginCustomer = (String) session.getAttribute("loginId");
			
		if(loginCustomer == null){
			// 리퀘스트에서 루트 경로 가져와서 뒤에 customer/login을 붙인다. 그리고 리다이렉트.
			response.sendRedirect(request.getContextPath() + "/index#login");
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
}
