<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="scheduler.*" %>
<%@ page import="notice.*" %>
<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="image.*" %>
<jsp:useBean id="ImageDAO" class="image.ImageDAO"/>
<jsp:useBean id="dao" class="notice.NoticeDAO"/>
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
if(!UsersDAO.IsManager(uid))
{
	out.println("<script>alert('권한이 없습니다.'); history.go(-1);</script>");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap core CSS -->
<link href="./css/bootstrap.min.css" rel="stylesheet">
    
<!-- Custom CSS -->
<link href="./css/pts.css" rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script>
	tinymce.init({ selector:'textarea' });
	function check(){
		var f = document.writeForm;
		if(!f.ntitle.value){
			alert("제목을 입력하세요.");
			return;
		}
		if(!f.ncont.value){
			alert("내용을 입력하세요.");
			return;
		}
		
		f.submit();
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
			<div class="bg-color2 panel-heading text-left" style="padding: 2rem 5rem;">
			<h1><a href="notice.jsp" class="text-color1">공지사항</a></h1>
			</div>
			<div class="panel-body text-center" style="padding: 5rem 8rem;">
				<div class="panel panel-defualt">
				 	<h3 class="text-left">글 작성하기</h3>
					<form name="writeForm" action="controller.jsp?action=write" method="post">
						<table id="tbWrite" class="table talbe-striped" style="text-align: center; border: 1px solid #dddddd">
								<tr>
									<td><input type="text" class="form-control" placeholder="글 제목" name="ntitle" maxlength="50"></td>
								</tr>	
								<tr>
									<td><textarea class="form-control" placeholder="글 내용" name="ncont" maxlength="2048" style="height:350px;"></textarea></td>
								</tr>
						</table> 
					<button type="button" onclick="check();" style="width: 200px; height: 60px; background-color: #e8d529; color: #000000; font-size: 15px; border: 0;">등록</button>
					<button type="reset" style="width: 200px; height: 60px; background-color: #2C3250; color: white; font-size: 15px; border: 0;">취소</button>
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