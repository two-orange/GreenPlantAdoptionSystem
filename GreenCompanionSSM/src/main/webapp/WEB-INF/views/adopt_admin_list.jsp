<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>领养申请审核</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- 双重校验：未登录跳登录页 + 非管理员禁止访问 --%>
<%
    Object loginUser = session.getAttribute("loginUser");
    if (loginUser == null || !"管理员".equals(((com.yang.entity.User)loginUser).getRole())) {
        response.sendRedirect(request.getContextPath() + "/user/toLogin");
        return;
    }
%>

<div class="container" style="margin-top: 30px;">
    <h2>📋 领养申请审核列表</h2>
    <table class="table table-bordered table-hover">
        <thead>
        <tr style="background-color: #f8f9fa;">
            <th>申请ID</th>
            <th>绿植ID</th>
            <th>申请人ID</th>
            <th>申请时间</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%-- 遍历所有领养申请 --%>
        <c:forEach items="${applyList}" var="apply">
            <tr>
                <td>${apply.apply_id}</td>
                <td>${apply.plant_id}</td>
                <td>${apply.user_id}</td>
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
                <td>
                        <%-- 仅待审核的申请可操作 --%>
                    <c:if test="${apply.status == '待审核'}">
                        <a href="${pageContext.request.contextPath}/adopt/audit?applyId=${apply.apply_id}&status=已通过"
                           class="btn btn-sm btn-success">通过</a>
                        <a href="${pageContext.request.contextPath}/adopt/audit?applyId=${apply.apply_id}&status=已拒绝"
                           class="btn btn-sm btn-danger">拒绝</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <%-- 无申请时提示 --%>
        <c:if test="${empty applyList}">
            <tr>
                <td colspan="6" style="text-align: center; color: #999;">暂无领养申请待审核</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/plant/toList" class="btn btn-default">返回绿植管理后台</a>
</div>
</body>
</html>