<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="scheduler.*" %>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="image.*" %>
<jsp:useBean id="ImageDAO" class="image.ImageDAO"/>
<%
request.setCharacterEncoding("UTF-8");
%>   

<%
String uid = (String)session.getAttribute("uid");
String wpname = (String)session.getAttribute("wpname");
String wpid = (String)session.getAttribute("wpid");
if(uid == null || uid.equals("") || wpname == null || wpname.equals("")) response.sendRedirect("./login.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap core CSS -->
<link href="./css/bootstrap.min.css" rel="stylesheet">
    
<!-- Custom CSS -->
<link href="./css/pts.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<title>PTS - Part time Scheduler</title>
</head>
<body>
<nav class="navbar navbar-inverse bg-ombra" id="navbar-custom">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.jsp" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<p class="navbar-text" style="color: #ffffff;"><%=uid %>님</p>
      	<li><a href="./controller.jsp?action=userinfo" style="color: #ffffff;"><span class="glyphicon glyphicon-user"></span> 내정보</a></li>
        <li><a href="./controller.jsp?action=logout" style="color: #ffffff;"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
		<div class="col-sm-2 sidenav bg-snow" style="height: 100%; min-height: 100rem;">
			<%
			String fileName = ImageDAO.GetFileName("wpid", wpid);
			String filePath = "./img/"+"\\"+fileName;
			%>
			<span>
				<img class="img-circle" src="<%=filePath %>" style="width:70%;">
			</span>
			<h3><%=wpname %></h3><br>
			<p>근무지 코드 : <%=wpid %></p>
			
			<hr style="border: 1px solid rgb(232, 213, 41)"><br>
			<p><a class="nav-item " href="./timetable.jsp">근무 시간표</a></p>
			<p><a class="nav-item " href="./notice.jsp">공지사항</a></p>
			<p><a class="nav-item " href="./apply.jsp">근무 신청</a></p>
			<p><a class="nav-item " href="./pay.jsp">급여 관리</a></p>
		</div>
		<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
	    	<!-- 컨텐츠 -->
			<h1>근무시간표</h1>
			<hr>
			<table class="timetable text-center col-sm-10">
				<tr><th class="time">time</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th></tr>
				<%
				ArrayList<SchedulerDTO> schList = SchedulerDAO.getMemberList(wpid);
				
				String[] days = {"월","화","수","목","금","토","일"};
				int[] dayCnts = { 0, 0, 0, 0, 0, 0, 0};
				int listIdx = 0;
				double openTime = 9.0f;
				double closeTime = 18.0f;
				for(double time = openTime; time < closeTime; time += 0.5f)
				{
					Double time2 = time;
					String stime, etime;
					if((time * 2) % 2 != 0)
					{
						stime = time2.toString().replace(".5", ":30");
						time2 = time + 0.5;
						etime = time2.toString().replace(".0", ":00");
					}
					else{
						time2 = time;
						stime = time2.toString().replace(".0", ":00");
						time2 = time + 0.5;
						etime = time2.toString().replace(".5", ":30");
					}
					%>
					<tr>
					<td><%=stime %> ~ <%=etime %></td><%
						for(int dayIdx = 0; dayIdx < days.length; dayIdx++)
						{
							if(schList.size() == 0) 
							{
								if(dayIdx == 0 && time == openTime)
								{
									double rowspan = (closeTime-openTime) * 2;
									%>
									<td colspan = "<%=days.length%>" rowspan="<%=rowspan%>">
										등록된 근무 일정이 없습니다.
										<%
										if(UsersDAO.IsManager(uid))
										{
											%>
											<br><br><a href="newschedule.jsp">시간표 등록</a>
											<%
										}
										%>
									</td>
									<%
								}
							}
							else{
								SchedulerDTO sdto = schList.get(listIdx);
								if(sdto.getSday().equals(days[dayIdx]) && sdto.getStime() == time)
								{
									double diff = (schList.get(listIdx).getEtime() - schList.get(listIdx).getStime()) * 2;
									String applyUserName = SchedulerDAO.getApplyUserName(sdto.getSid());
									if(listIdx < schList.size() - 1) listIdx++;
									dayCnts[dayIdx] = (int)diff;
									%><td rowspan="<%=(int)diff%>"><%=applyUserName %></td><%
								}
								else if(dayCnts[dayIdx] > 1)
								{
									dayCnts[dayIdx]--;
								}
								else{
									%><td class="bg-coldbreeze"></td><%
								}
							}
						}
					
					%>
					</tr>
					<%
				}
				%>
			</table>
		</div>
	</div>
</div>

<footer class="container-fluid text-center bg-slagheap">
  <p>경기도 용인시 처인구 용인대학로 134 우.17092 TEL: 031-332-6471~6 FAX: 031-337-6749<br>
	Copyrightⓒ Department of Management Information Systems, YongInUniversity All Rights Reserved.</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./js/bootstrap.min.js"></script>

</body>
</html>