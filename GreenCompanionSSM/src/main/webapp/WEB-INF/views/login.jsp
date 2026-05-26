<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>绿伴校园 - 登录</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-box {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2 class="text-center">绿伴校园绿植领养系统</h2>
    <!-- 登录错误提示 -->
    <div class="error">${loginError}</div>

    <form action="${pageContext.request.contextPath}/user/login" method="post">
        <div class="form-group">
            <label>用户名：</label>
            <input type="text" name="username" class="form-control" placeholder="请输入用户名" required>
        </div>
        <div class="form-group">
            <label>密码：</label>
            <input type="password" name="password" class="form-control" placeholder="请输入密码" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">登录</button>
        <div class="text-center" style="margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/index.jsp">游客访问</a>
        </div>
    </form>
</div>
</body>
</html>