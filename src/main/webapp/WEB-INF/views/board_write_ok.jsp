<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	int result = (Integer) request.getAttribute("result");
	
	out.println("<script type='text/javascript'>");
	if (result == 1) {
		out.println("alert('게시글이 업로드 되었습니다.');");
		out.println("history.go(-2)");
	} else {
		out.println("alert('게시글 업로드 실패');");
		out.println("history.back();");
	}
	out.println("</script>");
%>
