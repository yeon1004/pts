<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="scheduler.*" %>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="image.*" %>
<jsp:useBean id="ImageDAO" class="image.ImageDAO"/>
<%@ page import="apply.*" %>
<jsp:useBean id="ApplyDAO" class="apply.ApplyDAO"/>
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
			<p>근무지 코드 [ <%=wpid %> ]</p>
			<hr style="border: 1px solid rgb(232, 213, 41)"><br>
			<p><a class="nav-item " href="./timetable.jsp">근무 시간표</a></p>
			<p><a class="nav-item " href="./notice.jsp">공지사항</a></p>
			<p><a class="nav-item " href="./apply.jsp">근무 신청</a></p>
			<p><a class="nav-item " href="./apply_list.jsp">신청 목록</a></p>
			<p><a class="nav-item " href="./pay.jsp">급여 관리</a></p>
		</div>
		<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
	    	<!-- 컨텐츠 -->
			<h1>근무 시간표</h1>
			<hr>
			<div class="panel panel-default">
			<div class="panel-heading text-center" style="padding: 2rem;">
			<%
				String dir = request.getParameter("dir");
				String s_num = request.getParameter("num");
				int i_num = 0;
				
				String f_link = "", b_link = "";
				
				Date date = new Date();
				date.setYear(2018);
				date = SchedulerDAO.GetDayAfter(date, 0);
				if(dir==null || dir.equals("") || dir == "")
				{
					f_link = "timetable.jsp?dir=f&num=1";
					b_link = "timetable.jsp?dir=b&num=1";
				}
				else
				{
					i_num = Integer.parseInt(s_num);
					if(dir.equals("f"))
					{
						f_link = "timetable.jsp?dir=f&num=" + (i_num + 1);
						if(i_num > 1)
							b_link = "timetable.jsp?dir=f&num=" + (i_num -1);
						else b_link = "timetable.jsp";
						
						date = SchedulerDAO.GetDayAfter(date, i_num * 7);
					}
					else // dir.equals.("b")
					{
						b_link = "timetable.jsp?dir=b&num=" + (i_num + 1);
						if(i_num > 1)
							f_link = "timetable.jsp?dir=b&num=" + (i_num -1);
						else f_link = "timetable.jsp";
						
						date = SchedulerDAO.GetDayAfter(date, i_num * -7);
					}
				}
				
				Date sdate = SchedulerDAO.GetFirstDayOfWeek(date);
				Date edate = SchedulerDAO.GetLastDayOfWeek(date);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String s_sdate = sdf.format(sdate);
				String s_edate = sdf.format(edate);
			%>
			<form name="selectWeekForm" class="form-inline">
				<button type="button" class="btn btn-default" onclick="location.href='<%=b_link%>';">◀</button>
				<div class="form-group">
					<label class="control-label" for="sdate"></label>
		      		<input type="text" class="form-control text-center" id="sdate" name="sdate" value="<%= s_sdate%>" disabled style="background-color: white;">
				</div>
				<div class="form-group">
					<label class="control-label" for="edate">~</label>
		      		<input type="text" class="form-control text-center" id="edate" name="edate" value="<%= s_edate%>" disabled style="background-color: white;">
				</div>
				<button type="button" class="btn btn-default" onclick="location.href='<%=f_link%>';">▶</button>
			</form>
			
			</div>
			<div class="panel-body text-center" style="padding-left: 5rem; padding-right: 5rem;">
			<table class="table timetable text-center " style="margin: 0;">
				<tr>
					<th class="time" style="border-top:1px solid gray;">time</th>
					<th style="border-top:1px solid gray;">일</th>
					<th style="border-top:1px solid gray;">월</th>
					<th style="border-top:1px solid gray;">화</th>
					<th style="border-top:1px solid gray;">수</th>
					<th style="border-top:1px solid gray;">목</th>
					<th style="border-top:1px solid gray;">금</th>
					<th style="border-top:1px solid gray;">토</th>
				</tr>
				<%
				ArrayList<SchedulerDTO> schList = SchedulerDAO.getMemberList(wpid);
				
				String[] days = {"일","월","화","수","목","금","토"};
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
									if(listIdx < schList.size() - 1) listIdx++;
									dayCnts[dayIdx] = (int)diff;
									
									String apply_uid = ApplyDAO.getApplyUserId(sdto.getSid(), s_sdate, s_edate);
									String adate = sdf.format(SchedulerDAO.GetDayAfter(sdate, dayIdx));
									String astatus = ApplyDAO.getApplyStatus(uid, sdto.getSid());
									
									if(apply_uid == null || apply_uid.equals(""))
									{%>
										<td rowspan="<%=(int)diff%>" class="bg-snow" style="vertical-align: middle;">
											
										</td>
									<%}
									else
									{
										%>
										<td rowspan="<%=(int)diff%>" class="bg-snow" style="vertical-align: middle;">
											<%=UsersDAO.getUserName(apply_uid) %>
										</td>
										<%
									}
								}
								else if(dayCnts[dayIdx] > 1)
								{
									dayCnts[dayIdx]--;
								}
								else{
									%><td></td><%
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
</div>

<footer class="container-fluid text-center bg-slagheap">
  <p>경기도 용인시 처인구 용인대학로 134 우.17092 TEL: 031-332-6471~6 FAX: 031-337-6749<br>
	Copyrightⓒ Department of Management Information Systems, YongInUniversity All Rights Reserved.</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./js/bootstrap.min.js"></script>

</body>
</html>