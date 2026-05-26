<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>${knowledge.title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f7f9fa;
      font-family: "Microsoft YaHei", sans-serif;
      padding: 30px 0;
    }
    .container {
      max-width: 860px;
      background: #fff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .title {
      font-size: 28px;
      font-weight: bold;
      color: #2d8a5a;
      margin-bottom: 12px;
    }
    .time {
      color: #999;
      font-size: 14px;
      margin-bottom: 25px;
    }
    .content {
      font-size: 16px;
      line-height: 1.9;
      color: #333;
      text-align: justify;
    }
    .back-btn {
      margin-top: 30px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="container">
  <h2 class="title">${knowledge.title}</h2>
  <p class="time">发布时间：${knowledge.create_time}</p>
  <hr style="margin: 0 0 25px 0;">
  <div class="content">${knowledge.content}</div>

  <div class="back-btn">
    <a href="${pageContext.request.contextPath}/knowledge/toList" class="btn btn-success">返回养护知识列表</a>
  </div>
</div>
</body>
</html>