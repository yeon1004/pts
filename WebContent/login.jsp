<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>PTS - Login</title>

<script>
		function check(){
			var f = document.loginForm;
			if(!f.uid.value){
				alert("아이디를 입력하세요.");
				return;
			}
			if(!f.upw.value){
				alert("비밀번호를 입력하세요.");
				return;
			}
			f.submit();
		}
</script>
	
</head>
<body>
<table class="wrapper text-center">
	<tr><td></td><td></td><td></td></tr>
	<tr><td></td><td>
		<!-- 로그인폼 -->
		<h1>PTS</h1><br>
		<form name="loginForm" class="form-horizontal" action="./controller.jsp" method="post">
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="uid">ID</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="uid" name="uid" placeholder="아이디를 입력하세요.">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="upw">PW</label>
		    <div class="col-sm-10"> 
		      <input type="password" class="form-control" id="upw" name="upw" placeholder="비밀번호를 입력하세요.">
		    </div>
		  </div>
		  <div class="form-group"> 
		    <div class="col-sm-12 text-center">
		      <button type="button" class="btn btn-info" onclick="check();" style="width:20rem;")>로그인</button>
		    </div>
		  </div>
		  <input type="hidden" name="action" value="login"/>
		 </form>
		 <p><a href="join.jsp">회원가입</a></p>
	</td><td></td></tr>
	<tr><td></td><td></td><td></td></tr>
</table>
</body>
</html>