<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	int result = (Integer) request.getAttribute("result");
	
	out.println("<script type='text/javascript'>");
	if (result == 1) {
		out.println("alert('게시글이 삭제되었습니다.');");	
		out.println("location.href='/petpark.do';");		
	} else {
		out.println("alert('게시글 수정 실패');");
		out.println("history.back();");
	}
	out.println("</script>");
%>
