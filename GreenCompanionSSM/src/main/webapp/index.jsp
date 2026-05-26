<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>跳转中...</title>
</head>
<body>
<%
    // 直接跳登录页
    response.sendRedirect(request.getContextPath() + "/user/toLogin");
%>
</body>
</html>