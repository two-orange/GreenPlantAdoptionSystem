<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>绿植领养列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 全局样式：京东风格 - 通栏、满屏、简洁 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f4f4f4;
            font-family: "Microsoft YaHei", "微软雅黑", sans-serif;
            font-size: 14px;
        }
        /* 顶部导航：京东红/深蓝通栏 */
        .top-nav {
            background-color: #2c3e50;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            width: 100%;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .top-nav .brand {
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            text-decoration: none;
        }
        .top-nav .user-info {
            color: #fff;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .top-nav .btn-logout {
            background-color: #e4393c; /* 京东红 */
            border: none;
            color: white;
            padding: 6px 16px;
            border-radius: 4px;
            font-size: 13px;
        }
        /* 主容器：满屏通栏，不再是窄卡片 */
        .main-container {
            width: 100%;
            padding: 20px 40px;
            background: transparent;
        }
        /* 标题栏：京东风格的标题条 */
        .page-header {
            background: white;
            padding: 15px 20px;
            border-radius: 4px;
            margin-bottom: 15px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .page-title {
            font-size: 22px;
            color: #333;
            font-weight: 600;
            margin: 0;
        }
        /* 表格容器：白色通栏背景 */
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        /* 表格：京东风格，满屏展示 */
        .plant-table {
            width: 100%;
            border-collapse: collapse;
        }
        .plant-table thead th {
            background-color: #009966; /* 京东绿风格 */
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }
        .plant-table tbody td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        .plant-table tbody tr:hover {
            background-color: #f9f9f9;
        }
        /* 状态标签 */
        .status-tag {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            color: white;
        }
        .status-pending {
            background-color: #f59e0b;
        }
        .status-adopted {
            background-color: #009966;
        }
        /* 按钮组：京东风格，通栏排列 */
        .btn-group {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 13px;
            font-weight: 500;
            color: white;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-add { background-color: #009966; }
        .btn-audit { background-color: #3b82f6; }
        .btn-knowledge { background-color: #2563eb; }
        .btn-user { background-color: #f59e0b; }
        .btn-stats { background-color: #e4393c; }
        .btn-back { background-color: #6b7280; }
        .btn-edit { background-color: #3b82f6; padding: 4px 10px; font-size: 12px; }
        .btn-delete { background-color: #e4393c; padding: 4px 10px; font-size: 12px; margin-left: 5px; }
        .btn-apply { background-color: #009966; padding: 4px 10px; font-size: 12px; }
    </style>
</head>
<body>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect(request.getContextPath() + "/user/toLogin");
        return;
    }
%>

<!-- 顶部导航：通栏满屏 -->
<div class="top-nav">
    <a class="brand" href="#">🌿 绿伴校园 - 绿植管理后台</a>
    <div class="user-info">
        <span>欢迎：${loginUser.username}</span>
        <a href="${pageContext.request.contextPath}/user/logout" class="btn-logout">注销</a>
    </div>
</div>

<!-- 主内容区：通栏满屏 -->
<div class="main-container">
    <!-- 标题栏 -->
    <div class="page-header">
        <h2 class="page-title">待领养绿植列表</h2>
    </div>

    <!-- 表格容器：白色通栏 -->
    <div class="table-container">
        <table class="plant-table">
            <thead>
            <tr>
                <th>序号</th>
                <th>名称</th>
                <th>类型</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${plantList}" var="plant" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${plant.plant_name}</td>
                    <td>${plant.plant_type}</td>
                    <td>
                        <c:choose>
                            <c:when test="${plant.current_status == '待领养'}">
                                <span class="status-tag status-pending">待领养</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-tag status-adopted">已领养</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${loginUser.role == '管理员'}">
                            <a href="${pageContext.request.contextPath}/plant/toEdit?id=${plant.plant_id}" class="btn btn-edit">编辑</a>
                            <a href="${pageContext.request.contextPath}/plant/delete?id=${plant.plant_id}" class="btn btn-delete">删除</a>
                        </c:if>
                        <c:if test="${loginUser.role == 'user'}">
                            <a href="${pageContext.request.contextPath}/adopt/toApply?plantId=${plant.plant_id}" class="btn btn-apply">申请领养</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 功能按钮 -->
        <div class="btn-group">
            <c:if test="${loginUser.role == '管理员'}">
                <a href="${pageContext.request.contextPath}/plant/toAdd" class="btn btn-add">新增绿植</a>
                <a href="${pageContext.request.contextPath}/adopt/toAdminList" class="btn btn-audit">审核领养申请</a>
                <a href="${pageContext.request.contextPath}/knowledge/toList" class="btn btn-knowledge">养护知识管理</a>
                <a href="${pageContext.request.contextPath}/userManage/toList" class="btn btn-user">用户管理</a>
                <a href="${pageContext.request.contextPath}/stats/dataCenter" class="btn btn-stats">数据统计中心</a>
            </c:if>
            <c:if test="${loginUser.role == 'user'}">
                <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-back">返回用户首页</a>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>