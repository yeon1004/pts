<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String uid = (String)session.getAttribute("uid");
if(uid == null || uid.equals("")) response.sendRedirect("./login.jsp");
else response.sendRedirect("./timetable.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PTS - Part time Scheduler</title>
</head>
<body>

</body>
</html>