<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的收藏</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="margin-top:20px;">
    <h3>我的收藏</h3>
    <div class="row">

        <c:forEach items="${plantList}" var="plant">
            <div class="col-md-4">
                <div class="thumbnail">

                    <!-- ✅ 这里！！！显示数据库真实图片 -->
                    <img src="${plant.plant_img}" class="img-responsive" alt="${plant.plant_name}">

                    <div class="caption">
                        <h4>${plant.plant_name}</h4>
                        <p>${plant.plant_desc}</p>
                        <p>
                            <a href="${pageContext.request.contextPath}/adopt/toApply?plantId=${plant.plant_id}" class="btn btn-success">我要领养</a>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty plantList}">
            <div class="col-md-12">
                <div class="alert alert-warning">你还没有收藏任何绿植~</div>
            </div>
        </c:if>
    </div>

    <a href="${pageContext.request.contextPath}/plant/toBrowse" class="btn btn-default">返回浏览页</a>
</div>
</body>
</html>