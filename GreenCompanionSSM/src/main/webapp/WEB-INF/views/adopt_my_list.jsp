<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>我的领养申请</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- 登录校验：未登录跳登录页 --%>
<%
  if (session.getAttribute("loginUser") == null) {
    response.sendRedirect(request.getContextPath() + "/user/toLogin");
    return;
  }
%>

<div class="container" style="margin-top: 30px;">
  <h2>📋 我的领养申请记录</h2>

  <%-- 无申请时友好提示 --%>
  <c:if test="${empty myApplies}">
    <div class="alert alert-info" style="margin: 20px 0;">
      你还没有提交任何领养申请，快去<a href="${pageContext.request.contextPath}/plant/toBrowse" style="color: #5cb85c;">选择绿植</a>提交申请吧～
    </div>
  </c:if>

  <%-- 有申请时展示列表 --%>
  <table class="table table-bordered table-hover" style="margin-top: 20px;">
    <thead>
    <tr style="background-color: #f8f9fa;">
      <th>申请ID</th>
      <th>绿植ID</th>
      <th>申请时间</th>
      <th>审核状态</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${myApplies}" var="apply">
      <tr>
        <td>${apply.apply_id}</td>
        <td>${apply.plant_id}</td>
        <td>${apply.apply_time}</td>
        <td>
          <c:choose>
            <c:when test="${apply.status == '待审核'}">
              <span style="color: orange; font-weight: bold;">待审核</span>
            </c:when>
            <c:when test="${apply.status == '已通过'}">
              <span style="color: green; font-weight: bold;">已通过</span>
            </c:when>
            <c:when test="${apply.status == '已拒绝'}">
              <span style="color: red; font-weight: bold;">已拒绝</span>
            </c:when>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
  <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-default">返回用户首页</a>
</div>
</body>
</html>