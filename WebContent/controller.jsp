<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="image.*" %>
<%@ page import="notice.*" %>
<%@ page import="reply.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="users.*" %>
<%@ page import="workplace.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage="error.jsp"%>

<jsp:useBean id="ImageDAO" class="image.ImageDAO" scope="page"/>
<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO" scope="page"/>
<jsp:useBean id="ReplyDAO" class="reply.ReplyDAO" scope="page"/>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO" scope="page"/>
<jsp:useBean id="UsersDAO" class="users.UsersDAO" scope="page"/>
<jsp:useBean id="workplaceDAO" class="workplace.WorkplaceDAO" scope="page"/>
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
else if(action.equals("wpjoin"))
{
	//upload폴더에 파일 업로드
	String uploadPath=request.getRealPath("/img");
	out.print("realPath : "+uploadPath);
	int size = 10 * 1024 * 1024;

	String fileName="";
	String wpid="", wpnum="";
	MultipartRequest multi = null;
			
	try{
		multi = new MultipartRequest(
		request,
		uploadPath,
		size,
		"utf-8",
		new DefaultFileRenamePolicy()
		);
		//writer = multi.getParameter("writer");

		//첨부파일 여러개 가져온다.
		Enumeration files = multi.getFileNames();
				
		//파일의 이름만 가져온다. ->전송받은 이름
		String file=(String)files.nextElement();
		//multi에서 해당 이름을 알려주고 실제 시스템상의 이름을 알아낸다.
		fileName = multi.getFilesystemName(file);
				
	}catch(Exception e){
		throw new Exception("파일 업로드 문제 발생");
	}
}

//리스트
if(action.equals("list"))
{
	pageContext.forward("notice.jsp");
}
//글쓰기
if(action.equals("write"))
{
	//upload폴더에 파일 업로드
		String uploadPath=request.getRealPath("/upload");
		out.print("realPath : "+uploadPath);
		int size = 10 * 1024 * 1024;
		String writer="";
		String title="";
		String cont="";

		
		NoticeDTO bdto = new NoticeDTO();
		bdto.setNtitle(title);
		bdto.setUid(writer);
		bdto.setNcont(cont);

		if(NoticeDAO.insertWrite(bdto)) {
			out.println("<script>alert('등록되었습니다!'); location.href='controller.jsp?action=list';</script>");
		}
		else {
			throw new Exception("디비 등록 중 문제 발생");
		}
}


%>