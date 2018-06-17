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

<%
				String dir = request.getParameter("dir");
				String s_num = request.getParameter("num");
				int i_num = 0;
				boolean apply_able = true;
				
				String f_link = "", b_link = "";
				
				Date date = new Date();
				date.setYear(2018);
				date = SchedulerDAO.GetDayAfter(date, 0);
				if(dir==null || dir.equals("") || dir == "")
				{
					f_link = "apply.jsp?dir=f&num=1";
					b_link = "apply.jsp?dir=b&num=1";
				}
				else
				{
					i_num = Integer.parseInt(s_num);
					if(dir.equals("f"))
					{
						f_link = "apply.jsp?dir=f&num=" + (i_num + 1);
						if(i_num > 1)
							b_link = "apply.jsp?dir=f&num=" + (i_num -1);
						else b_link = "apply.jsp";
						
						date = SchedulerDAO.GetDayAfter(date, i_num * 7);
						
						if(i_num > 2) apply_able = false;
					}
					else // dir.equals.("b")
					{
						b_link = "apply.jsp?dir=b&num=" + (i_num + 1);
						if(i_num > 1)
							f_link = "apply.jsp?dir=b&num=" + (i_num -1);
						else f_link = "apply.jsp";
						
						date = SchedulerDAO.GetDayAfter(date, i_num * -7);
					}
				}
				
				Date sdate = SchedulerDAO.GetFirstDayOfWeek(date);
				Date edate = SchedulerDAO.GetLastDayOfWeek(date);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String s_sdate = sdf.format(sdate);
				String s_edate = sdf.format(edate);
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
<nav class="navbar navbar-inverse bg-color1" id="navbar-custom">
  <div class="container-fluid bg-color1">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.jsp" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<li class="navbar-text" style="color: #ffffff;"><%=uid %>님</li>
      	<li><a href="./controller.jsp?action=userinfo" style="color: #ffffff;"><span class="glyphicon glyphicon-user"></span> 내정보</a></li>
        <li><a href="./controller.jsp?action=logout" style="color: #ffffff;"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
		<div class="col-sm-2 sidenav" style="position: relative; top: 0; bottom: 0; left: 0;">
			<div class="panel panel-default text-center">
				<div class="panel-body text-center">
					<%
					String fileName = ImageDAO.GetFileName("wpid", wpid);
					String filePath = "./img/"+"\\"+fileName;
					if(fileName.equals("noImage")) filePath = "./img/"+"\\"+"default.png";
					%>
					<span>
						<img class="img-circle" src="<%=filePath %>" style="width:70%;">
					</span>
					<h3><%=wpname %></h3>
				</div>
				<div class="panel-footer text-left" style="padding: 1rem;">
					근무지 코드 <font style="font-weight: bold;"><%=wpid %></font>
					<%
					String level;
					if(UsersDAO.IsManager(uid)) level="관리자";
					else level="직원";
					%>
					<br>내 권한 <font style="font-weight: bold;"><%=level %></font>
				</div>
			</div>
			<br>
			<div class="text-center" style="box-sizing: border-box;">
				<button type="button" class="btn btn-default btn-block btn-lg" style="margin: 1rem 0;" onclick="location.href='./timetable.jsp';">
				근무 일정표</button>
				<button type="button" class="btn btn-default btn-block btn-lg" style="margin: 1rem 0;" onclick="location.href='./apply.jsp';">
				근무 신청</button>
				<button type="button" class="btn btn-default btn-block btn-lg" style="margin: 1rem 0;" onclick="location.href='./apply_list.jsp';">
				신청 목록</button>
				<button type="button" class="btn btn-default btn-block btn-lg" style="margin: 1rem 0;" onclick="location.href='./notice.jsp';">
				공지사항</button>
				<button type="button" class="btn btn-default btn-block btn-lg" style="margin: 1rem 0;" onclick="location.href='./pay.jsp';">
				급여 관리</button>
				
			</div>
		</div>
		<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
	    	<!-- 컨텐츠 -->
			<br><br>
			<div class="panel panel-default">
			<div class="bg-color2 panel-heading text-left" style="padding: 2rem 5rem;">
			<h1><a href="apply.jsp" class="text-color1">근무 신청</a></h1>
			</div>
			<div class="panel-body text-center" style="padding: 5rem 8rem;">
			<div class="panel panel-default" style="padding: 1rem;">
			<form name="selectWeekForm" class="form-inline">
				<button type="button" class="btn btn-default" onclick="location.href='<%=b_link%>';">◀</button>
				<div class="form-group">
					<label class="control-label" for="sdate"></label>
		      		<input type="text" class="form-control text-center" id="sdate" name="sdate" value="<%= s_sdate%>" readonly style="background-color: white;">
				</div>
				<div class="form-group">
					<label class="control-label" for="edate">~</label>
		      		<input type="text" class="form-control text-center" id="edate" name="edate" value="<%= s_edate%>" readonly style="background-color: white;">
				</div>
				<button type="button" class="btn btn-default" onclick="location.href='<%=f_link%>';">▶</button>
			</form>
			</div>
			<table class="table applytable text-center " style="margin: 0;">
				<tr>
					<th class="time">time</th>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
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
									<td colspan = "<%=days.length%>" rowspan="<%=rowspan%>" style="vertical-align: middle;">
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
									
									ArrayList<ApplyDTO> alist = ApplyDAO.getApplyUsers(sdto.getSid(), s_sdate, s_edate);
									//String apply_uid = ApplyDAO.getApplyUsers(sdto.getSid(), s_sdate, s_edate);
									String adate = sdf.format(SchedulerDAO.GetDayAfter(sdate, dayIdx));
									String astatus = ApplyDAO.getApplyStatus(uid, sdto.getSid(), adate);
									if(alist.size() == 0 && apply_able)
									{
										//내가 신청했는지 확인
										if(astatus.equals("")) //신청안함
										{
											%>
											<td rowspan="<%=(int)diff%>" class="bg-snow" style="vertical-align: middle;">
												<form name="applyForm" method="post" action="controller.jsp?action=apply">
													<input type="hidden" name="adate" value="<%=adate%>"/>
													<input type="hidden" name="sid" value="<%=sdto.getSid()%>"/>
													<input type="hidden" name="uid" value="<%=uid%>"/>
													<input type="hidden" name="dir" value="<%=dir %>"/>
													<input type="hidden" name="num" value="<%=s_num %>"/>
													<input type="submit" value="신청하기" class="btn btn-success" style="border:0;"/> 
												</form>
											</td>
											<%
										}
										else					//신청함
										{
											%>
											<td rowspan="<%=(int)diff%>" class="bg-snow" style="vertical-align: middle;">
												<button type="button" class="btn btn-defualt" disabled>신청완료</button>
											</td>
											<%
										}
										
									}
									else //alist.size() >= 1
									{
										%>
										<td rowspan="<%=(int)diff%>" class="bg-snow" style="vertical-align: middle;">
											<% 
											for(int i = 0; i < alist.size(); i++)
											{
												ApplyDTO adto = alist.get(i);
												%><%=UsersDAO.getUserName(adto.getUid()) %><%
											}
											%>
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
			<p class="text-left">*스케쥴은 현재 기준 2주 후까지 신청 가능합니다.</p>
			
			</div>
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