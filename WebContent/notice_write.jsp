<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.util.*" %>
<%@ page import="notice.*" %>

<jsp:useBean id="dao" class="notice.NoticeDAO"/>
<jsp:useBean id="dto" class="notice.NoticeDTO"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String uid = (String)session.getAttribute("uid");
String wpname = (String)session.getAttribute("wpname");
int wpid=-1;
if(uid == null || uid.equals("") || wpname == null || wpname.equals("")) response.sendRedirect("./login.jsp");
else wpid = ((Integer)(session.getAttribute("wpid"))).intValue();
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
  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	tinymce.init({ selector:'textarea' });
	function check(){
		var f = document.writeForm;
		if(!f.title.value){
			alert("제목을 입력하세요.");
			return;
		}
		if(!f.cont.value){
			alert("내용을 입력하세요.");
			return;
		}
		f.submit();
	
	}
</script>
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
			<span>
				<img class="img-circle" src="img/profile.jpg" alt="Cinque Terre" style="width:70%;">
			</span>
			<h3><%=wpname %></h3><br>
			<hr style="border: 1px solid rgb(232, 213, 41)"><br>
			<p><a class="nav-item " href="#">근무 시간표</a></p>
			<p><a class="nav-item " href="notice.jsp">공지사항</a></p>
			<p><a class="nav-item " href="#">근무 신청</a></p>
			<p><a class="nav-item " href="#">급여 관리</a></p>
		</div>
<div class="col-sm-10 text-left">
<!-- 컨텐츠 -->
<div class='wrap'>
	
		<div>
		<a href='notice.jsp'><h1>공지사항</h1></a>
		</div>
	<div class='cont'>
		<form name="writeForm" action="controller.jsp?action=write" method="post" enctype="multipart/form-data">
		<table id="tbWrite">
			<tr>
				<th>제목</th>
				<td><input type="text" id="txtTitle" name="title"></td>
			</tr>
			<tr>
				<td colspan="2"> 		  
					<!-- 내용 -->	
					<textarea id='tacont' name="cont"></textarea>
				</td>
			</tr>

		</table><br>
		<button type="button" onclick="check();" style="width: 200px; height: 60px; background-color: #e8d529; color: #000000; font-size: 15px; border: 0;">등록</button>
		<button type="reset" style="width: 200px; height: 60px; background-color: #2C3250; color: white; font-size: 15px; border: 0;">취소</button>
		<input type="hidden" name="writer" value="<%=dto.getUid()%>"/>
		</form>
	</div>
</div>
</div>
</div>
</div>
<footer class="container-fluid text-center bg-slagheap">
  <p>Footer Text</p>
</footer>

</body>
</html>