<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
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

<script>
		function wpcheck(){
			var wf = document.WpJoinForm;
			if(!wf.wpname.value){
				alert("상호명을 입력하세요.");
				return;
			}
			if(!wf.wpnum1.value || !wf.wpnum2.value || !wf.wpnum2.value){
				alert("사업자번호를 입력하세요.");
				return;
			}
			if(!wf.wpimg.value){
				alert("이미지를 등록해주세요.");
				return;
			}
			wf.submit();
		}
		
		function usercheck(){
			var uf = document.UserJoinForm;
			if(!uf.uid.value){
				alert("아이디를 입력하세요.");
				return;
			}
			if(!uf.upw.value){
				alert("비밀번호를 입력하세요.");
				return;
			}
			if(!uf.uname.value){
				alert("이름을 입력하세요.");
				return;
			}
			if(!uf.wpid.value){
				alert("근무지 번호를 입력하세요.");
				return;
			}
			uf.submit();
		}
</script>
<%
String step = request.getParameter("step");
String ulevel = request.getParameter("level");
%>

</head>
<body>
<nav class="navbar navbar-inverse bg-color1" id="navbar-custom">
  <div class="container-fluid bg-color1">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.jsp" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
  	<div class="col-sm-2 sidenav bg-gray" style="height: 100%; min-height: 100rem; "></div>
	<div class="col-sm-8 text-left" style="height: 100%; min-height: 100rem;">
		<br><br>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h1>회원가입</h1>
			</div>
			<div class="panel-body">
				<div class="text-left">
					<%
					if(step == null || step.equals("") || step.equals("1"))
					{
						//가입 유형 선택
						%><br>
						<p> 환영합니다! <br>
						가입 유형을 선택해주세요.</p><hr>
						<p class="text-center">
							<button type="button" class="btn btn-primary btn-lg" onclick="location.href='join.jsp?level=1&step=2';">관리자</button>
							<button type="button" class="btn btn-primary btn-lg" onclick="location.href='join.jsp?level=2&step=3';">일반직원</button>
						</p>
						<%
					}
					else if(step.equals("2") && ulevel.equals("1"))
					{
						//근무지 정보 입력
						%>
						<p>근무지 정보를 입력해주세요. </p><hr>
						<p class="text-right" style="color: #b01818;">*필수입력항목</p>
						<form name="WpJoinForm" action="./controller.jsp?action=wpjoin" method="post" enctype="multipart/form-data" >
							<div class="form-group">
								<label for="wpname">*상호명</label>
								<input name="wpname" id="wpname" type="text" class="form-control">
							</div><br>
							<div class="form-group">
								<label for="wpnum1">*사업자번호</label>
								<input name="wpnum1" id="wpnum1" type="text" maxlength="3" width="3rem" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>-
								<input name="wpnum2" id="wpnum2" type="text" maxlength="2" width="2rem" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>-
								<input name="wpnum3" id="wpnum3" type="text" maxlength="5" width="5rem" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>
							</div><br>
							<div class="form-group">
								<label for="wpimg">*메인 이미지</label>
								<input name="wpimg" id="wpimg" type="file" class="form-control">
							</div><br>
							<div class="form-group">
								<label for="stime">*오픈시간</label>
								<select class="form-control" id="stime" name="stime">
								<%
								for(int i = 0; i <= 24 ; i++)
								{
									if(i==9)
							    	{
							    		%><option selected><%=i %></option><%
							    	}
							    	else{
							    		%><option><%=i %></option><%
							    	}
								}
								%>
								</select>
							</div>
							<div class="form-group">
								<label for="etime">*마감시간</label>
								<select class="form-control" id="etime" name="etime">
								<%
								for(int i = 0; i <= 24 ; i++)
								{
									if(i==18)
							    	{
							    		%><option selected><%=i %></option><%
							    	}
							    	else{
							    		%><option><%=i %></option><%
							    	}
								}
								%>
								</select>
							</div><br>
							<input type="hidden" name="action" value="wpjoin"/>
							<button type="button" class="btn btn-info" onclick="wpcheck();">확인</button>
							<button type="button" class="btn btn-default" onclick="history.go(-1)">취소</button><br><br>
							<a href="join.jsp?level=1&step=3">이미 등록된 근무지가 있습니다.</a>
						</form>
						<%
					}
					else if(step.equals("3"))
					{
						if(ulevel.equals("1")) ulevel = "관리자";
						else ulevel = "직원";
						
						String wpid = request.getParameter("wpid");
						if (wpid==null || wpid.equals("") || wpid.equals("0")) wpid="";
						//유저 정보 입력
						%>
						<p class="text-right" style="color: #b01818;">*필수입력항목</p>
						<form name="UserJoinForm" action="./controller.jsp?action=userjoin" method="post">
							<div class="form-group">
								<label for="ulevel">가입 유형</label>
								<input id="ulevel" type="text" class="form-control" value="<%=ulevel%>" disabled>
								<input type="hidden" name="ulevel" value="<%=ulevel%>"/>
							</div>
							<div class="form-group">
								<label for="uid">*아이디</label>
								<input name="uid" id="uid" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="upw">*비밀번호</label>
								<input name="upw" id="upw" type="password" class="form-control">
							</div>
							<div class="form-group">
								<label for="uname">*이름</label>
								<input name="uname" id="uname" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="uphone">전화번호</label>
								<input name="uphone" id="uphone" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="uaddr">주소</label>
								<input name="uaddr" id="uaddr" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="wpid">*근무지 번호</label>
								<input name="wpid" id="wpid" type="text" class="form-control" value="<%=wpid%>">
							</div>
							<button type="button" class="btn btn-info" onclick="usercheck();">가입하기</button>
							<button type="button" class="btn btn-default" onclick="history.go(-1)">취소</button>
						</form>
						<%
					}
					%>
					</div>
			</div>
		</div>
	
	
	</div>
	<div class="col-sm-2 sidenav bg-gray" style="height: 100%; min-height: 100rem; "></div>
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