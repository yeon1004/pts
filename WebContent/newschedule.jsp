<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="scheduler.*" %>
<jsp:useBean id="ScheduleDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="workplace.*" %>
<jsp:useBean id="WorkplaceDAO" class="workplace.WorkplaceDAO"/>
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

<script>
	function finish(){
		var result = confirm('근무 일정은 다시 수정할 수 없습니다. 나가시겠습니까?');
		if(result) location.href='index.jsp';
	}
</script>
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
			<div class="panel-heading text-left" style="padding: 2rem 5rem;">
			<h1><a href="#" class="text-color1">근무 일정표</a></h1>
			</div>
			<div class="panel-body text-center" style="padding: 5rem 8rem;">
			<div class="panel panel-default" style="padding: 1rem;">
			<%
			ArrayList<SchedulerDTO> schList = ScheduleDAO.getMemberList(wpid);
			double opentime = WorkplaceDAO.getOpenTime(wpid);
			double closetime = WorkplaceDAO.getCloseTime(wpid);
			%>
			<form name="ScheduleForm" class="form-inline" action="controller.jsp?action=newsche" method="post">
				<div class="form-group">
					<label for="selectedday">요일</label>
					  <select class="form-control" id="selectedday" name="selectedday">
					    <option>월</option>
					    <option>화</option>
					    <option>수</option>
					    <option>목</option>
					    <option>금</option>
					    <option>토</option>
					    <option>일</option>
					  </select>
				</div>
				<div class="form-group">
					<label for="stime_hour">시작시간</label>
					<select class="form-control" id="stime_hour" name="stime_hour">
					    <%
					    for(int i = (int)opentime; i <= (int)closetime ; i++)
					    {
					    	%><option><%=i %></option><%
					    }
					    %>
					  </select>
				</div>
				<div class="form-group">
				<label for="stime_minute">:</label>
					<select class="form-control" id="stime_minute" name="stime_minute">
					    <option>00</option>
					    <option>30</option>
					</select>
				</div>
				<div class="form-group">
					<label for="etime_hour">종료시간</label>
					<select class="form-control" id="etime_hour" name="etime_hour">
					    <%
					    for(int i = (int)opentime; i <= (int)closetime ; i++)
					    {
					    	%><option><%=i %></option><%
					    }
					    %>
					  </select>
				</div>
				<div class="form-group">
					<label for="etime_minute">:</label>
					<select class="form-control" id="etime_minute" name="etime_minute">
					    <option>00</option>
					    <option>30</option>
					</select>
				</div>
				<input type="hidden" name="wpid" value="<%=wpid%>"/>
				<button type="submit" class="btn btn-info">추가</button>
				<button type="button" class="btn btm-default" onclick="finish();">완료</button>
			</form>
			</div>
			<table class="timetable text-center col-sm-12">
				<tr><th class="time">time</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th></tr>
				<%
				String[] days = {"월","화","수","목","금","토","일"};
				int[] dayCnts = { 0, 0, 0, 0, 0, 0, 0};
				int listIdx = 0;
				for(double time = opentime; time < closetime; time += 0.5f)
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
								if(dayIdx == 0 && time == opentime)
								{
									double rowspan = (closetime-opentime) * 2;
									%>
									<td colspan = "<%=days.length%>" rowspan="<%=rowspan%>">
										등록된 근무 일정이 없습니다.
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
									%><td rowspan="<%=(int)diff%>"></td><%
								}
								else if(dayCnts[dayIdx] > 1)
								{
									dayCnts[dayIdx]--;
								}
								else{
									%><td class="bg-gray"></td><%
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
</div>

<footer class="container-fluid text-center bg-slagheap">
  <p>경기도 용인시 처인구 용인대학로 134 우.17092 TEL: 031-332-6471~6 FAX: 031-337-6749<br>
	Copyrightⓒ Department of Management Information Systems, YongInUniversity All Rights Reserved.</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./js/bootstrap.min.js"></script>

</body>
</html>