<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的闲置绿植</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- 登录校验 --%>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect(request.getContextPath() + "/user/toLogin");
        return;
    }
%>

<%-- 顶部导航 --%>
<div class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">绿伴校园 - 我的闲置绿植</a>
        </div>
        <div class="navbar-right">
            <p class="navbar-text">欢迎：${loginUser.username}</p>
            <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-default navbar-btn">注销</a>
        </div>
    </div>
</div>

<div class="container">
    <h2>我的闲置绿植</h2>
    <hr>
    <a href="${pageContext.request.contextPath}/idlePlant/toPublish" class="btn btn-success">发布新的闲置绿植</a>
    <a href="${pageContext.request.contextPath}/idlePlant/toList" class="btn btn-primary" style="margin-left: 10px;">返回交换广场</a>
    <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-default" style="margin-left: 10px;">返回首页</a>
    <hr>

    <div class="list-group">
        <c:choose>
            <c:when test="${empty myIdleList}">
                <div class="alert alert-info">你还没有发布闲置绿植，快去发布吧！</div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${myIdleList}" var="idle">
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading">${idle.plant_name}（${idle.plant_type}）</h4>
                        <p class="list-group-item-text">交换描述：${idle.description}</p>
                        <p class="list-group-item-text"><small>发布时间：${idle.publish_time}</small></p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>