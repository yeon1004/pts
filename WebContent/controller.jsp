<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="image.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="users.*" %>
<%@ page import="workplace.*" %>
<%@ page import="notice.*" %>
<%@ page import="apply.*" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO"/>
<jsp:useBean id="ImageDAO" class="image.ImageDAO" scope="page"/>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO" scope="page"/>
<jsp:useBean id="UsersDAO" class="users.UsersDAO" scope="page"/>
<jsp:useBean id="WorkplaceDAO" class="workplace.WorkplaceDAO" scope="page"/>
<jsp:useBean id="ApplyDAO" class="apply.ApplyDAO" scope="page"/>
<%
request.setCharacterEncoding("UTF-8");
String action = request.getParameter("action");
if(action.equals("login"))
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
	String uploadPath = request.getRealPath("img");
	out.print("realPath : "+uploadPath);
	int size = 10 * 1024 * 1024;
	WorkplaceDTO wdto = new WorkplaceDTO();
	
	String file="", filename="", originFile="";
	String wpname="", wpnum="", stime="", etime="", wpcode="";
	
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
		etime = multi.getParameter("etime");
		
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
		e.printStackTrace();
	}
	
	String wpid = "0";
	try{
		
		//workplace 등록
		//wpid = WorkplaceDAO.InsertWp(wdto);
		if(WorkplaceDAO.InsertWp(wdto))
		{
			wpid = WorkplaceDAO.getWpid(wpname, wpnum);
			ImageDTO idto = new ImageDTO();
			idto.setWpid(wpid);
			idto.setFilename(filename);
			ImageDAO.InsertImage(idto);
		}
		out.println("<br>wpid: " + wpid + "<br>wpname: " + wpname + "<br>wpnum:" + wpnum + "<br>stime:" + stime + "<br>etime:" + etime);
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("join.jsp?level=1&step=3&wpid="+wpid);
	
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
		session.setAttribute("wpid", wpid);
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
	
	if(d_stime == d_etime || d_stime > d_etime) out.println("<script> alert('잘못된 시간 입력입니다.'); history.go(-1); </script>");
	
	SchedulerDTO sdto = new SchedulerDTO();
	sdto.setSday(sday);
	sdto.setStime(d_stime);
	sdto.setEtime(d_etime);
	sdto.setWpid(wpid);
	
	if(SchedulerDAO.CheckSchedule(sdto))
	{
		SchedulerDAO.InsertNewSchedule(sdto);
		response.sendRedirect("./newschedule.jsp");
	}
	else
	{
		out.println("<script> alert('기존 근무 시간과 겹칩니다.'); history.go(-1); </script>");
	}
}
//리스트
else if(action.equals("list"))
{
	response.sendRedirect("notice.jsp");
}
//글쓰기
else if(action.equals("write"))
{
		String writer = (String)session.getAttribute("uid");
		String ntitle = request.getParameter("ntitle");
		String ncont = request.getParameter("ncont");
		
		//out.println(writer+"<br>"+ntitle+"<br>"+ncont);
		
		NoticeDTO ndto = new NoticeDTO();
		ndto.setNtitle(ntitle);
		ndto.setNcont(ncont.replace("\r\n","<br>"));
		ndto.setUid(writer);
		
		if(NoticeDAO.insertWrite(ndto)) {
			out.println("<script>alert('등록되었습니다!'); location.href='controller.jsp?action=list';</script>");
		}
		else {
			out.println("<script>alert('등록 실패');</script>");
		}
}
else if(action.equals("apply"))
{
	String adate = request.getParameter("adate");
	String sid = request.getParameter("sid");
	String uid = request.getParameter("uid");
	
	String dir = request.getParameter("dir");
	String num = request.getParameter("num");
	
	ApplyDTO adto = new ApplyDTO();
	adto.setAdate(adate);
	adto.setSid(sid);
	adto.setUid(uid);
	
	if(ApplyDAO.InsertApply(adto))
	{
		if(dir==null || dir.equals("") || dir == "" || dir.equals("null"))
			out.println("<script>alert('신청되었습니다!'); location.href='apply.jsp';</script>");
		else
			out.println("<script>alert('신청되었습니다!'); location.href='apply.jsp?dir=" + dir + "&num=" + num +  "';</script>");
	}
	else
	{
		out.println("<script>alert('신청 실패');</script>");
	}
	
	
}
else if(action.equals("apply_ok")){
	int[] idx = new int[10];
	String temp;
	for(int i = 0; i <= 5; i++)
	{
		temp = "idx" + Integer.toString(i);
		if(request.getParameter(temp)!=null)
		{
			idx[i] = Integer.parseInt(request.getParameter(temp));
		}
		else idx[i] = 0;
	}
	for(int x : idx){
		if(x!=0)
		{
			if(!ApplyDAO.ApplySetOk(x))
				out.println("<script>alert('승인에 실패했습니다! 이미 승인된 다른 신청이 있는지 확인해주세요.');</script>");;
		}
	}
	out.println("<script>alert('승인 처리 되었습니다!'); location.href='apply_list.jsp';</script>");
}
else if(action.equals("apply_no")){
	int[] idx = new int[10];
	String temp;
	for(int i = 0; i <= 5; i++)
	{
		temp = "idx" + Integer.toString(i);
		if(request.getParameter(temp)!=null)
		{
			idx[i] = Integer.parseInt(request.getParameter(temp));
		}
		else idx[i] = 0;
	}
	for(int x : idx){
		if(x!=0)
		{
			if(!ApplyDAO.ApplySetNo(x))
				out.println("<script>alert('거절에 실패했습니다.');</script>");;
		}
	}
	out.println("<script>alert('거절 처리 되었습니다!'); location.href='apply_list.jsp';</script>");
}
else
{
	response.sendRedirect("./index.jsp");
}
%>