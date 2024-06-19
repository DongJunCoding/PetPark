<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	int result = (Integer) request.getAttribute("result");
	String boardNo = (String)request.getAttribute("boardNo");	

	out.println("<script type='text/javascript'>");
	if (result == 1) {
		out.println("alert('댓글 수정 완료');");	
		out.println("location.href='/boardView.do?board_id=" + boardNo +"';");		
	} else {
		out.println("alert('댓글 수정 실패');");
		out.println("history.back();");
	}
	out.println("</script>");
%>
