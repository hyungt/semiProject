<%@ page pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userLogin") == null) {
		//로그인 완료 후 되돌아갈 url 가져오기
		String url = (String) pageContext.getAttribute("url");
		
		String path = "/profile/userLogin.jsp?deny=1&returnUrl="+url;
		response.sendRedirect(path);
		
		return;
	}
%>