<%@ page pageEncoding="UTF-8"%>
<% 
	if(session.getAttribute("loginReporter") == null) {
		//로그인 완료 후 되돌아갈 url가져오기
		String url = (String) pageContext.getAttribute("url");
		String path = "/reporter/profile/login.jsp?deny=1&returnUrl="+url;
		response.sendRedirect(path);
		
		return;
	}
%>