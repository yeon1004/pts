<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="scheduler.*" %>

<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="image.*" %>
<jsp:useBean id="ImageDAO" class="image.ImageDAO"/>
<%@ page import="notice.*" %>
<jsp:useBean id="dao" class="notice.NoticeDAO"/>

<%
request.setCharacterEncoding("UTF-8");
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String uid = (String)session.getAttribute("uid");
String wpname = (String)session.getAttribute("wpname");
String wpid = (String)session.getAttribute("wpid");
if(uid == null || uid.equals("") || wpname == null || wpname.equals("")) response.sendRedirect("./login.jsp");
%>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	NoticeDTO dto = dao.getNoticeView(idx);	
	dao.UpdateHit(idx);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap core CSS -->
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
    
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
		<div class="col-sm-10 text-left">
	    	<!-- 컨텐츠 -->
	    	
		<div><h1>공지사항</h1></a></div>
	<div class='cont'>
		<table id="tbView">
		<tr id="btitle">
			<td width="5%"><%=idx%><!--글번호--></td>
			<th width="auto" style="text-align: center; font-size: 20px; font-style: bolder;"><%=dto.getNtitle()%><!--제목--></th>
			<td style="width: 8em;" align="right"><font style="color:gray;">조회수 : </font><%=dto.getNhit()%><!--조회수--></td>
		</tr>
		<tr id="binfo">
			<td colspan="3" align="right" style=" border-top: 2px solid #2C3250;">
				<font style="color:gray;">작성자 : </font><%=dto.getUid()%><!--작성자-->
				<font style="color:gray;">&nbsp;&nbsp;작성일 : </font><%=dto.getNdate()%><!--작성일-->
			</td>
		</tr>
		<tr id="bcont">
			<td colspan="3" style="padding: 20px 5%;">
				<%=dto.getNcont()%><!--내용-->
			</td>
		</tr>
	
		</table>
		<input type="button" id="btnMyItem"  value="목록" onClick="location.href='controller.jsp?action=list';"/>
	
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