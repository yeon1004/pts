<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="image.*" %>
<%@ page import="notice.*" %>
<%@ page import="reply.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="users.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage="error.jsp"%>

<jsp:useBean id="ImageDAO" class="image.ImageDAO" scope="page"/>
<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO" scope="page"/>
<jsp:useBean id="ReplyDAO" class="reply.ReplyDAO" scope="page"/>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO" scope="page"/>
<jsp:useBean id="UsersDAO" class="users.UsersDAO" scope="page"/>
<%
String action = request.getParameter("action");

if(action == "login" || action.equals("login"))
{
	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	int wpid = UsersDAO.Login(uid, upw);
	
	if(wpid < 0)
	{
		//로그인 실패
		out.println("<script> alert(' 아이디 또는 비밀번호를 확인하세요!'); history.go(-1); </script>");
	}
	else{
		out.println("로그인 성공<br>");
		
		//세션등록
		session.setAttribute("uid", uid);
		session.setAttribute("wpid", new Integer(wpid));
		session.setAttribute("wpname", UsersDAO.getWpname(wpid));
		
		out.println("uid : " + session.getAttribute("uid") +"<br>");
		out.println("wpid : " + session.getAttribute("wpid") +"<br>");
		out.println("wpname : " + session.getAttribute("wpname") +"<br>");
		//메인으로
		response.sendRedirect("./index.jsp");
	}
}
else if(action.equals("logout"))
{
	session.invalidate(); //세션 종료
	out.println("<script> alert('로그아웃 되었습니다!'); location.href='login.jsp';</script>");
}
%>