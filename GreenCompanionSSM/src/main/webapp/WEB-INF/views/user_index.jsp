<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>绿伴校园 - 首页</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: "Microsoft YaHei", sans-serif;
        }

        .navbar {
            background-color: #2c3e50 !important;
            border: none !important;
            margin-bottom: 0;
        }
        .navbar-brand, .navbar-text {
            color: white !important;
        }
        .navbar-btn {
            background-color: #e4393c !important;
            color: white !important;
            border: none;
        }

        .header {
            background: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 26px;
            margin: 0;
        }
        .header p {
            margin: 5px 0 0;
            font-size: 14px;
        }

        .container {
            max-width: 1200px;
        }

        /* 卡片放大但不拉长 */
        .menu-card {
            background: #fff;
            border-radius: 10px;
            padding: 25px 15px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            height: 220px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .menu-card .icon {
            font-size: 36px;
            margin-bottom: 10px;
        }
        .menu-card h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .menu-card a {
            font-size: 15px;
            color: #337ab7;
            text-decoration: none;
        }
        .tips {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        /* 个人信息紧凑 */
        .info-form {
            text-align: left;
            margin-top: 10px;
        }
        .info-form .form-item {
            margin: 8px 0;
        }
        .info-form label {
            width: 70px;
            display: inline-block;
            text-align: right;
            font-size: 13px;
        }
        .info-form input {
            width: calc(100% - 80px);
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .info-form button {
            width: 100%;
            padding: 6px;
            background: #5cb85c;
            color: white;
            border: none;
            border-radius: 4px;
            margin-top: 5px;
        }

        /* ========== 修复通知样式 ========== */
        .notice-badge {
            position: relative;
            display: inline-block;
            margin-left: 10px;
            cursor: pointer;
            vertical-align: middle;
            color: white;
        }
        .notice-badge .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: red;
            color: #fff;
            border-radius: 10px;
            padding: 2px 5px;
            font-size: 12px;
        }
        .notice-panel {
            position: absolute;
            right: 0;
            top: 30px;
            width: 320px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 9999;
            padding: 10px;
            display: none;
            text-align: left;
            color: #333; /* 文字黑色 */
        }
        .notice-item {
            padding: 8px 5px;
            border-bottom: 1px dashed #eee;
            font-size: 13px;
            position: relative;
            color: #333; /* 文字黑色 */
        }
        .notice-item.unread {
            background: #fef8e7;
            color: #333;
        }
        .notice-item .del {
            position: absolute;
            right: 5px;
            top: 3px;
            color: #999;
            cursor: pointer;
        }
        .notice-bar {
            margin-top: 8px;
            text-align: right;
            font-size: 12px;
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
            <a class="navbar-brand" href="${pageContext.request.contextPath}/user/toUserIndex">绿伴校园绿植领养系统</a>
        </div>
        <div class="navbar-right" style="position:relative;">
            <p class="navbar-text">欢迎：${loginUser.username}</p>

            <div class="notice-badge" id="noticeBadge">
                <span class="glyphicon glyphicon-bell"></span>
                <span class="badge" id="noticeCount">0</span>
                <div class="notice-panel" id="noticePanel">
                    <div style="font-weight:bold; margin-bottom:5px; color:#333;">系统通知</div>
                    <div id="noticeList"></div>
                    <div class="notice-bar">
                        <button class="btn btn-xs btn-default" onclick="markAllRead()">全部已读</button>
                        <button class="btn btn-xs btn-danger" onclick="clearAllNotice()">清空全部</button>
                    </div>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-default navbar-btn">注销</a>
        </div>
    </div>
</div>

<div class="header">
    <h1>绿伴校园 · 让绿植陪伴校园生活</h1>
    <p>闲置绿植交换 · 免费领养 · 养护知识分享</p>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="menu-card">
                <div class="icon">🌿</div>
                <h3>待领养绿植</h3>
                <a href="${pageContext.request.contextPath}/plant/toBrowse">查看可领养绿植</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="menu-card">
                <div class="icon">📝</div>
                <h3>领养申请</h3>
                <a href="${pageContext.request.contextPath}/plant/toList">提交领养申请</a>
                <div class="tips">先选绿植再申请</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="menu-card">
                <div class="icon">📚</div>
                <h3>绿植养护知识</h3>
                <a href="${pageContext.request.contextPath}/knowledge/toList">查看养护指南</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="menu-card">
                <div class="icon">♻️</div>
                <h3>闲置绿植交换</h3>
                <a href="${pageContext.request.contextPath}/idlePlant/toList">进入交换广场</a>
                <div class="tips">可查看/发布绿植</div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top:20px;">
        <div class="col-md-4">
            <div class="menu-card">
                <div class="icon">👤</div>
                <h3>个人信息管理</h3>
                <div class="info-form">
                    <div class="form-item">
                        <label>用户名：</label>
                        <input type="text" id="username" disabled>
                    </div>
                    <div class="form-item">
                        <label>手机号：</label>
                        <input type="text" id="phone">
                    </div>
                    <div class="form-item">
                        <label>校区地址：</label>
                        <input type="text" id="address">
                    </div>
                    <button onclick="saveUserInfo()">保存修改</button>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="menu-card">
                <div class="icon">📋</div>
                <h3>我的领养申请</h3>
                <a href="${pageContext.request.contextPath}/adopt/toMyApplies">查看申请记录</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="menu-card">
                <div class="icon">📤</div>
                <h3>发布闲置绿植</h3>
                <a href="${pageContext.request.contextPath}/idlePlant/toPublish">发布我的绿植</a>
                <div class="tips">展示在交换广场</div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        loadUserInfo();
        loadNotice();
    });

    function loadUserInfo() {
        $.ajax({
            url: "${pageContext.request.contextPath}/user/getUserInfo",
            type: "GET",
            dataType: "json",
            success: function(res) {
                if (res.code === 200) {
                    $("#username").val(res.data.username);
                    $("#phone").val(res.data.phone);
                    $("#address").val(res.data.address);
                } else {
                    alert(res.msg);
                    location.href = "${pageContext.request.contextPath}/user/toLogin";
                }
            },
            error: function() { alert("查询个人信息失败！"); }
        });
    }

    function saveUserInfo() {
        var phone = $("#phone").val().trim();
        var address = $("#address").val().trim();
        if (!phone) { alert("手机号不能为空！"); return; }
        $.ajax({
            url: "${pageContext.request.contextPath}/user/updateUserInfo",
            type: "POST",
            data: { phone: phone, address: address },
            dataType: "json",
            success: function(res) {
                alert(res.msg);
                if (res.code === 200) loadUserInfo();
            },
            error: function() { alert("修改失败！"); }
        });
    }

    $("#noticeBadge").click(function(){ $("#noticePanel").toggle(); });

    function loadNotice(){
        $.get("${pageContext.request.contextPath}/notice/list", function(res){
            var html = "";
            var unread = 0;
            $.each(res, function(i,n){
                var cls = n.readStatus == 0 ? 'unread' : '';
                if(n.readStatus == 0) unread++;
                html += '<div class="notice-item '+cls+'" data-id="'+n.id+'">'
                    + n.content
                    + '<span class="del" onclick="delNotice('+n.id+')">×</span>'
                    + '</div>';
            });
            $("#noticeList").html(html);
            $("#noticeCount").text(unread);
        });
    }

    function delNotice(id){
        $.post("${pageContext.request.contextPath}/notice/delete", {id:id}, function(){ loadNotice(); });
    }
    function clearAllNotice(){
        if(!confirm("确定清空所有通知？")) return;
        $.post("${pageContext.request.contextPath}/notice/clearAll", function(){ loadNotice(); });
    }
    function markAllRead(){
        $.post("${pageContext.request.contextPath}/notice/markAllRead", function(){ loadNotice(); });
    }
</script>
</body>
</html>