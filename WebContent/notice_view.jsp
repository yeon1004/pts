<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.util.*" %>
<%@ page import="notice.*" %>
<jsp:useBean id="dao" class="notice.NoticeDAO"/>
<jsp:useBean id="dto" class="notice.NoticeDTO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("utf-8");

    String uid = (String)session.getAttribute("uid");
	
	boolean bLogin = !(uid==null || uid.equals(""));
%>

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
      <a class="navbar-brand" href="#" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<p class="navbar-text" style="color: #ffffff;">000님</p>
      	<li><a href="#" style="color: #ffffff;"><span class="glyphicon glyphicon-user"></span> 정보수정</a></li>
        <li><a href="#" style="color: #ffffff;"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
		<div class="col-sm-2 sidenav bg-snow" id="sideNav">
			<span>
				<img class="img-circle" src="img/profile.jpg" alt="Cinque Terre" style="width:70%;">
			</span>
			<h3>상호명</h3>
			매니저 000<br>
			<hr style="border: 0.7px solid rgb(232, 213, 41)"><br>
			<p><a class="nav-item " href="#">근무시간표</a></p>
			<p><a class="nav-item " href="#">공지사항</a></p>
			<p><a class="nav-item " href="#">근무신청</a></p>
			<p><a class="nav-item " href="#">일정관리</a></p>
			<p><a class="nav-item " href="#">급여관리</a></p>
		</div>
		<div class="col-sm-10 text-left">
	    	<!-- 컨텐츠 -->
	    	
		<div><a href='notice.jsp'><h1>공지사항</h1></a></div>
	<div class='cont'>
		<table id="tbView">
		<tr id="btitle">
			<td width="5%"><%=dto.getNid()%><!--글번호--></td>
			<th width="auto" style="text-align: left; font-size: 20px; font-style: bolder;"><%=dto.getNtitle()%><!--제목--></th>
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
		<input type="button" id="btnMyItem" value="목록" onClick="location.href='controller.jsp?action=list';"/>
	</div>
</div>	
</div>
</div>
<footer class="container-fluid text-center bg-slagheap">
  <p>Footer Text</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./js/bootstrap.min.js"></script>

</body>
</html>