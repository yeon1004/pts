<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.util.*" %>
<%@ page import="notice.*" %>

<jsp:useBean id="dao" class="notice.NoticeDAO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String uid = (String)session.getAttribute("uid");
String wpname = (String)session.getAttribute("wpname");
int wpid=-1;
if(uid == null || uid.equals("") || wpname == null || wpname.equals("")) response.sendRedirect("./login.jsp");
else wpid = ((Integer)(session.getAttribute("wpid"))).intValue();
%>

<%	
	int total = dao.count();
	ArrayList<NoticeDTO> boardList = dao.getBoardMemberList();
	int size = boardList.size();
	int size2 = size;
	
	final int ROWSIZE = 10;
	final int BLOCK = 5;
	int indent = 0;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	
	if(endPage > allPage) {
		endPage = allPage;
	}
	
	size2 -= end;
	if(size2 < 0) {
		end = size;
	}
	
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
			<p><a class="nav-item " href="timetable.jsp">근무 시간표</a></p>
			<p><a class="nav-item " href="notice.jsp">공지사항</a></p>
			<p><a class="nav-item " href="#">근무 신청</a></p>
			<p><a class="nav-item " href="#">급여 관리</a></p>
		</div>
		
<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
		<div><a href='notice.jsp'><h1>공지사항</h1></a></div>
	<div class='cont'>
		<br><br>
		<table id="boardList">
			<tr>
				<th width="10%">글번호</th>
				<th width="50%">제목</th>
				<th width="15%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">조회수</th>
			</tr>
			<%
			if(total==0) {
				%>
				<tr>
				<td colspan="5" style="padding: 30px 0;">등록된 글이 없습니다.</td>
				</tr>
				<%
			} else {
				for(int i=ROWSIZE*(pg-1); i<end; i++){
					NoticeDTO dto = boardList.get(i);
					int idx = dto.getNid();
			%>
					<tr class="blist" align="center">
						<td align="center"><%=idx%></td>
						<td align="left">&nbsp;&nbsp;&nbsp;
							<a href="notice_view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=dto.getNtitle()%></a>
						</td>
						<td align="center"><%=dto.getUid()%></td>
						<td align="center"><%=dto.getNdate()%></td>
						<td align="center"><%=dto.getNhit()%></td>
					</tr><%
				}
			} 
			%>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td align="center" colspan="5">
					<%
						if(pg>BLOCK) {
					%>
						[<a href="notice.jsp?pg=1">◀◀</a>]
						[<a href="notice.jsp?pg=<%=startPage-1%>">◀</a>]
					<%
						}
					%>
					
					<%
						for(int i=startPage; i<= endPage; i++){
							if(i==pg){
					%>
								<u><b>[<%=i %>]</b></u>
					<%
							}else{
					%>
								[<a href="notice.jsp?pg=<%=i %>"><%=i %></a>]
					<%
							}
						}
					%>
					
					<%
						if(endPage<allPage){
					%>
						[<a href="notice.jsp?pg=<%=endPage+1%>">▶</a>]
						[<a href="notice.jsp?pg=<%=allPage%>">▶▶</a>]
					<%}
					%>
				</td>
			</tr>
			
			<tr align="right">
				<td colspan="5"><button type="button" onclick="window.location='notice_write.jsp'" style="width: 100px; height: 30px; background-color: #2C3250; color: #FFFFFF; margin-right: 5%; border: 0;">글쓰기</button></td>
			</tr>
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