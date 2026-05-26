<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>闲置绿植交换</title>
    <!-- 引入 Bootstrap 样式 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 全局样式 */
        body {
            background-color: #f5f5f5; /* 更浅的背景色，更清新 */
            font-family: "Microsoft YaHei", sans-serif;
            padding-bottom: 40px;
        }
        .container {
            margin-top: 30px;
        }
        .page-title {
            color: #2d8a5a; /* 深绿色标题 */
            font-weight: bold;
            margin-bottom: 25px;
            border-left: 4px solid #2d8a5a;
            padding-left: 10px;
        }
        /* 绿植卡片样式 */
        .plant-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08); /* 柔和阴影 */
            padding: 0;
            margin-bottom: 25px;
            border: 1px solid #e8e8e8;
            transition: transform 0.2s ease-in-out;
        }
        .plant-card:hover {
            transform: translateY(-3px); /* 悬停微微上浮 */
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }
        /* 绿植图片 */
        .plant-img {
            width: 100%;
            height: 180px; /* 稍微高一点 */
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        /* 卡片内容 */
        .plant-info {
            padding: 15px 20px 20px 20px;
        }
        .plant-name {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .plant-desc {
            color: #666;
            font-size: 13px;
            margin-bottom: 5px;
        }
        .plant-status {
            color: #999;
            font-size: 12px;
            margin-bottom: 12px;
        }
        /* 按钮样式 */
        .exchange-btn {
            background-color: #2d8a5a;
            border: none;
            border-radius: 5px;
            padding: 8px 0;
            font-size: 14px;
        }
        .exchange-btn:hover {
            background-color: #246d48;
        }
        /* 底部按钮组 */
        .btn-group {
            margin-top: 20px;
        }
        .publish-btn {
            background-color: #4299e1;
            border: none;
        }
        .publish-btn:hover {
            background-color: #3182ce;
        }
        .back-btn {
            background-color: #fff;
            color: #333;
            border: 1px solid #ccc;
        }
        .back-btn:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="page-title">闲置绿植交换</h2>

    <c:if test="${empty idleList}">
        <div class="alert alert-warning text-center">
            <strong>暂无闲置绿植</strong>
        </div>
    </c:if>

    <div class="row">
        <c:forEach items="${idleList}" var="idle">
            <div class="col-md-4 col-sm-6">
                <div class="plant-card">
                    <img src="${pageContext.request.contextPath}${idle.plant_img}" class="plant-img" alt="${idle.plant_name}">
                    <div class="plant-info">
                        <h4 class="plant-name">${idle.plant_name} | ${idle.plant_type}</h4>
                        <p class="plant-desc">描述：${idle.plant_desc}</p>
                        <p class="plant-status">状态：${idle.current_status}</p>
                        <a href="${pageContext.request.contextPath}/idlePlant/toExchangeApply?idleId=${idle.plant_id}"
                           class="btn btn-success btn-block exchange-btn">申请交换</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/idlePlant/toPublish" class="btn btn-primary publish-btn">发布闲置</a>
        <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-default back-btn">返回首页</a>
    </div>
</div>
</body>
</html>