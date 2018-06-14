<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="image.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="users.*" %>
<%@ page import="workplace.*" %>
<%@ page import="notice.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO" scope="page"/>
<jsp:useBean id="ImageDAO" class="image.ImageDAO" scope="page"/>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO" scope="page"/>
<jsp:useBean id="UsersDAO" class="users.UsersDAO" scope="page"/>
<jsp:useBean id="WorkplaceDAO" class="workplace.WorkplaceDAO" scope="page"/>

<%
request.setCharacterEncoding("UTF-8");

String action = request.getParameter("action");

if(action == "login" || action.equals("login"))
{
	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	String wpid = UsersDAO.Login(uid, upw);
	
	if(wpid == "" || wpid.equals(""))
	{
		//로그인 실패
		out.println("<script> alert(' 아이디 또는 비밀번호를 확인하세요!'); history.go(-1); </script>");
	}
	else{
		out.println("로그인 성공<br>");
		
		//세션등록
		session.setAttribute("uid", uid);
		session.setAttribute("wpid", wpid);
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
	String realFolder="";
	String saveFolder="img";
	String encType="utf-8";
	int maxSize=5*1024*1024;
	ServletContext context = this.getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	//upload폴더에 파일 업로드
	String uploadPath = request.getRealPath("./img");
	out.print("realPath : "+uploadPath);
	int size = 10 * 1024 * 1024;

	WorkplaceDTO wdto = new WorkplaceDTO();
	
	String file="", filename="", originFile="";
	String wpname="", wpnum="", stime="", etime="";
	
	MultipartRequest multi = null;
			
	try{
		multi = new MultipartRequest(
		request,
		realFolder,
		maxSize,
		encType,
		new DefaultFileRenamePolicy()
		);
		wpname = multi.getParameter("wpname");
		wpnum = multi.getParameter("wpnum1") + "-" + multi.getParameter("wpnum2") + "-" + multi.getParameter("wpnum3");
		stime = multi.getParameter("stime");
		etime = multi.getParameter("etimr");
		
		wdto.setWpname(wpname);
		wdto.setWpnum(wpnum);
		wdto.setOpentime(Double.parseDouble(stime));
		wdto.setClosetime(Double.parseDouble(etime));
		
		//첨부파일 여러개 가져온다.
		Enumeration files = multi.getFileNames();
				
		file=(String)files.nextElement();
		filename = multi.getFilesystemName(file);
		originFile = multi.getOriginalFileName(file);
		
	}catch(Exception e){
		throw new Exception("파일 업로드 문제 발생");
	}
	
	try{
		//workplace 등록
		String wpid = WorkplaceDAO.InsertWp(wdto);
		//이미지 등록
		if(Integer.parseInt(wpid) >= 0)
		{
			ImageDTO idto = new ImageDTO();
			idto.setWpid(wpid);
			idto.setFilename(filename);
			ImageDAO.InsertImage(idto);
		}
		out.println("<br>wpid: " + wpid + "<br>wpname: " + wpname + "<br>wpnum:" + wpnum);
	}catch(Exception e){
		throw new Exception("디비 문제 발생");
	}
	
	response.sendRedirect("join.jsp?level=1&step=3");
}
else if(action.equals("userjoin"))
{
	String wpid = request.getParameter("wpid");
	if(!WorkplaceDAO.CheckWpid(wpid))
	{
		//근무지틀림
		out.println("<script> alert('근무지 번호를 확인하세요!'); history.go(-1); </script>");
	}
	else{
		UsersDTO udto = new UsersDTO();
		String uid = request.getParameter("uid");
		udto.setUid(uid);
		udto.setUpw(request.getParameter("upw"));
		udto.setUname(request.getParameter("uname"));
		udto.setUphone(request.getParameter("uphone"));
		udto.setUaddr(request.getParameter("uaddr"));
		udto.setUlevel(request.getParameter("ulevel"));
		udto.setWpid(wpid);
		
		UsersDAO.InsertNewUser(udto);
		
		//세션등록
		session.setAttribute("uid", uid);
		session.setAttribute("wpid", new Integer(wpid));
		session.setAttribute("wpname", UsersDAO.getWpname(wpid));
		
		out.println("<script> alert('가입이 완료되었습니다!'); location.href='index.jsp';</script>");
	}
}
else if(action.equals("newsche"))
{
	String sday = request.getParameter("selectedday");
	String stime_hour = request.getParameter("stime_hour");
	String stime_minute = request.getParameter("stime_minute");
	String etime_hour = request.getParameter("etime_hour");
	String etime_minute = request.getParameter("etime_minute");
	String wpid = request.getParameter("wpid");
	
	Double d_stime = Double.parseDouble(stime_hour);
	if(stime_minute.equals("30")) d_stime += 0.5;
	Double d_etime = Double.parseDouble(etime_hour);
	if(etime_minute.equals("30")) d_etime += 0.5;
	
	SchedulerDTO sdto = new SchedulerDTO();
	sdto.setSday(sday);
	sdto.setStime(d_stime);
	sdto.setEtime(d_etime);
	sdto.setWpid(wpid);
	
	SchedulerDAO.InsertNewSchedule(sdto);
	
	response.sendRedirect("./newtimetable.jsp");
}

//리스트
else if(action.equals("list"))
{
	pageContext.forward("notice.jsp");
}

//글쓰기
else if(action.equals("write"))
{
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