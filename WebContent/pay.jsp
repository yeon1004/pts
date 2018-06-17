<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.*,java.util.Date, java.lang.*" %>
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

//검색
String search_name = request.getParameter("s_name");
if(search_name == null || search_name.equals("")) search_name = "";

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
			<div class="bg-color2 panel-heading text-left" style="padding: 2rem 5rem;">
			<h1><a href="pay.jsp" class="text-color1">급여 관리</a></h1>
			</div>
			<div class="panel-body text-center" style="padding: 5rem 8rem;">
			
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
				f_link = "pay.jsp?dir=f&num=1";
				b_link = "pay.jsp?dir=b&num=1";
			}
			else
			{
				i_num = Integer.parseInt(s_num);
				if(dir.equals("f"))
				{
					f_link = "pay.jsp?dir=f&num=" + (i_num + 1);
					if(i_num > 1)
						b_link = "pay.jsp?dir=f&num=" + (i_num -1);
					else b_link = "pay.jsp";
					
					date = SchedulerDAO.GetDayAfter(date, i_num * 7);
				}
				else // dir.equals.("b")
				{
					b_link = "pay.jsp?dir=b&num=" + (i_num + 1);
					if(i_num > 1)
						f_link = "pay.jsp?dir=b&num=" + (i_num -1);
					else f_link = "pay.jsp";
					
					date = SchedulerDAO.GetDayAfter(date, i_num * -7);
				}
			}
			
			Date sdate = SchedulerDAO.GetFirstDayOfWeek(date);
			Date edate = SchedulerDAO.GetLastDayOfWeek(date);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String s_sdate = sdf.format(sdate);
			String s_edate = sdf.format(edate);
			%>
			
			<%
				ArrayList<PayDTO> pList;
				String search_info="";
				if(!search_name.equals("")) 
				{
					pList = ApplyDAO.GetPayList(wpid, s_sdate, s_edate, search_name);
					search_info = "'"+search_name+"'(으)로 검색한 내용입니다.";
				}
				//검색X
				else pList = ApplyDAO.GetPayList(wpid, s_sdate, s_edate);
			%>
			<div class="panel panel-default" style="padding: 2rem;">
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
			<p><%=search_info %></p>
				<table class="table text-center">
				<tr style="font-weight: bold; color: #ffffff;" class="bg-color1 text-white"><td></td><td>직원명</td><td>총 근무시간</td><td>시급</td><td>주휴수당</td><td>총급여</td>
				
				<%
				
				if(pList.size() == 0)
				{
					%>
					<tr><td colspan="6">근무 내역이 없습니다.</td></tr>
					<%
				}
				
				DecimalFormat df = new DecimalFormat("#"); 

				double wp_workhour = 0;
				double wp_pay = 0;
				double wp_overtime = 0;
				double wp_total = 0;
				for(int i = 0; i < pList.size(); i++)
				{
					PayDTO pdto = pList.get(i);
					
					String uname = pdto.getUname();
					double workhour = pdto.getWorkhour();
					double pay = pdto.getPay();
					double overtimePay = 0; //주휴수당
					if(pdto.getWorkhour() >= 15)
					{
						overtimePay = pdto.getWorkhour() / 40 * 8 * pdto.getPay();
					}
					double total = workhour * pay + overtimePay;
					
					wp_workhour += workhour;
					wp_pay += pay;
					wp_overtime += overtimePay;
					wp_total += total;
					%>
					<tr>
						<td></td>
						<td><%= uname%></td>
						<td><%= workhour%></td>
						<td><%= df.format(pay)%></td>
						<td><%= df.format(overtimePay)%></td>
						<td><%= df.format(total)%></td>
					</tr>
					<%
				}
				%>
					<tr class="info">
						<td colspan="2">합계</td>
						<td><%= wp_workhour%></td>
						<td><%= df.format(wp_pay)%></td>
						<td><%= df.format(wp_overtime)%></td>
						<td><%= df.format(wp_total)%></td>
					</tr>
				</table>
				<div class="panel panel-default text-right" style="padding: 1rem;">
					<form name="paySearchForm" class="form-inline" action="./pay.jsp" method="post">
						<div class="form-group">
					    <input type="text" class="form-control" placeholder="직원 이름" name="s_name" id="s_name"/>
					  </div>
					  <div class="form-group">
					      <button class="btn btn-default btn-info" type="submit">
					        <i class="glyphicon glyphicon-search"></i>
					      </button>
					  </div>
					</form>
				</div>
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