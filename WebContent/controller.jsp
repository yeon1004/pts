<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="apply.*" %>
<%@ page import="image.*" %>
<%@ page import="notice.*" %>
<%@ page import="reply.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="users.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage="error.jsp"%>
    
<jsp:useBean id="ApplyDAO" class="apply.ApplyDAO" scope="page"/>
<jsp:useBean id="ImageDAO" class="image.ImageDAO" scope="page"/>
<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO" scope="page"/>
<jsp:useBean id="ReplyDAO" class="reply.ReplyDAO" scope="page"/>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO" scope="page"/>
<jsp:useBean id="UsersDAO" class="users.UsersDAO" scope="page"/>
<%
String action = request.getParameter("action");

if(action.equals("login"))
{
	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	String uname = UsersDAO.Login(uid, upw);
	
	if(uname.equals("") || uname == "")
	{
		%>
		<script>
			//alert(" 아이디 또는 비밀번호를 확인하세요!");
			//history.go(-1);
		</script>
		<%
		out.println(uid + "<br>" + upw + "<br>");
		out.println("실패 "+uname);
	}
	else
	{
		out.println(uid + "<br>" + upw + "<br>");
		out.println("성공 "+uname);
		//세션등록
		//session.setAttribute("uid", uid);
		//session.setAttribute("uname", uname);
		
		//메인으로
		//response.sendRedirect("./index.jsp");
	}
}
%>