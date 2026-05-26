<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户管理 & 系统通知</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <style>
        .container { margin-top: 30px; }
        .notice-panel { margin-bottom: 30px; }
        .user-select-area { max-height: 150px; overflow-y: auto; border: 1px solid #eee; padding: 10px; }
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
            <a class="navbar-brand" href="#">绿伴校园 - 用户管理 & 系统通知</a>
        </div>
        <div class="navbar-right" style="margin-top:10px;">
            <span>欢迎：${loginUser.username}</span>
            <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-sm btn-default">注销</a>
        </div>
    </div>
</div>

<div class="container">
    <h2 class="page-header">用户管理 & 系统通知</h2>

    <!-- 1. 发送系统通知 -->
    <div class="panel panel-success notice-panel">
        <div class="panel-heading">
            <h4 class="panel-title">📢 发送系统通知</h4>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <label>选择用户（可多选）：</label>
                <div class="user-select-area">
                    <c:forEach items="${userList}" var="user">
                        <label style="display:block;margin:5px 0;">
                            <input type="checkbox" class="notice-user" value="${user.user_id}">
                                ${user.username}（${user.phone}）
                        </label>
                    </c:forEach>
                </div>
            </div>
            <div class="form-group">
                <label>通知内容：</label>
                <textarea id="noticeContent" class="form-control" rows="3"></textarea>
            </div>
            <button class="btn btn-primary" onclick="sendNotice()">发送通知</button>
            <button class="btn btn-default" onclick="selectAll()">全选</button>
            <button class="btn btn-default" onclick="unselectAll()">取消全选</button>
        </div>
    </div>

    <!-- 2. 已发送通知记录 & 撤回 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">📋 已发送通知记录（可撤回）</h4>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>通知ID</th>
                    <th>内容</th>
                    <th>发送时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${noticeList}" var="notice">
                    <tr>
                        <td>${notice.id}</td>
                        <td>${notice.content}</td>
                        <td>${notice.createTime}</td>
                        <td>
                            <button class="btn btn-danger btn-xs" onclick="rollbackNotice(${notice.id})">
                                撤回通知
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 3. 用户列表 -->
    <table class="table table-bordered">
        <tr>
            <th>用户ID</th>
            <th>用户名</th>
            <th>手机号</th>
            <th>地址</th>
            <th>角色</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${userList}" var="user">
            <tr>
                <td>${user.user_id}</td>
                <td>${user.username}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>${user.role}</td>
                <td>
                    <a href="/userManage/delete?id=${user.user_id}" class="btn btn-xs btn-danger" onclick="return confirm('确定删除？')">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    // 全选用户
    function selectAll(){
        $(".notice-user").prop("checked",true);
    }
    // 取消全选
    function unselectAll(){
        $(".notice-user").prop("checked",false);
    }
    // 发送通知
    function sendNotice(){
        var ids = [];
        $(".notice-user:checked").each(function(){
            ids.push($(this).val());
        });
        var content = $("#noticeContent").val().trim();
        if(ids.length === 0){
            alert("请选择用户");
            return;
        }
        if(!content){
            alert("请输入内容");
            return;
        }

        $.post("${pageContext.request.contextPath}/admin/notice/send", {
            userIds: ids.join(","),
            content: content
        }, function(res){
            alert(res.msg);
            if(res.code === 200){
                $("#noticeContent").val("");
                unselectAll();
                // 刷新页面以显示新通知
                window.location.reload();
            }
        });
    }

    // 撤回通知
    function rollbackNotice(id){
        if(!confirm("确定要撤回这条通知吗？撤回后用户将无法再查看！")){
            return;
        }
        $.post("${pageContext.request.contextPath}/admin/notice/rollback", {id: id}, function(res){
            alert(res.msg);
            if(res.code === 200){
                window.location.reload();
            }
        });
    }
</script>
</body>
</html>