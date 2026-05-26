<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>绿植养护知识</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f7f9fa;
      font-family: "Microsoft YaHei", sans-serif;
      font-size: 15px;
    }
    .navbar {
      margin-bottom: 30px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .container {
      max-width: 960px;
    }
    .page-title {
      font-size: 26px;
      font-weight: bold;
      color: #2d8a5a;
      margin-bottom: 20px;
    }
    .list-group-item {
      background: #fff;
      border-radius: 8px !important;
      margin-bottom: 12px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 18px 20px;
      border: none;
      transition: all 0.2s;
    }
    .list-group-item:hover {
      transform: translateY(-2px);
      box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    }
    .knowledge-info h4 {
      font-size: 18px;
      font-weight: 500;
      color: #2d8a5a;
      margin: 0 0 6px 0;
    }
    .knowledge-info p {
      color: #777;
      margin: 0;
      font-size: 13px;
    }
    .knowledge-actions {
      gap: 8px;
      display: flex;
    }
    .header-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 25px;
    }
  </style>
</head>
<body>
<%
  if (session.getAttribute("loginUser") == null) {
    response.sendRedirect(request.getContextPath() + "/user/toLogin");
    return;
  }
%>

<div class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/user/toUserIndex">绿伴校园</a>
    </div>
    <div class="navbar-right">
      <p class="navbar-text">欢迎：${loginUser.username}</p>
      <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-default navbar-btn">注销</a>
    </div>
  </div>
</div>

<div class="container">
  <div class="header-bar">
    <h2 class="page-title">绿植养护知识</h2>
    <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-default">返回首页</a>
  </div>

  <div class="list-group">
    <c:forEach items="${knowledgeList}" var="knowledge">
      <div class="list-group-item">
        <div class="knowledge-info">
          <a href="${pageContext.request.contextPath}/knowledge/toDetail?id=${knowledge.knowledge_id}">
            <h4>${knowledge.title}</h4>
          </a>
          <p>发布时间：${knowledge.create_time}</p>
        </div>
        <div class="knowledge-actions">
          <a href="${pageContext.request.contextPath}/knowledge/toDetail?id=${knowledge.knowledge_id}" class="btn btn-sm btn-success">查看</a>
          <c:if test="${loginUser.role == '管理员'}">
            <a href="${pageContext.request.contextPath}/knowledge/toEdit?id=${knowledge.knowledge_id}" class="btn btn-sm btn-primary">编辑</a>
          </c:if>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>