<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>绿伴校园 - 待领养绿植</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .plant-card {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            margin: 15px;
            width: 300px;
            display: inline-block;
            vertical-align: top;
        }
        .plant-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .comment-box {
            margin-top: 10px;
            display: none;
        }
        .comment-list {
            max-height: 120px;
            overflow-y: auto;
            margin-bottom: 8px;
            border: 1px solid #eee;
            padding: 6px;
            border-radius: 4px;
        }
        .comment-item {
            margin-bottom: 4px;
            padding-bottom: 4px;
            border-bottom: 1px dotted #eee;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
        }
        .search-box {
            display: flex;
            gap: 5px;
            align-items: center;
        }
        .search-box input {
            width: 250px;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .user-info {
            display: flex;
            gap: 10px;
            align-items: center;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>🌿 绿伴校园 - 待领养绿植</h2>
        <div class="user-info">
            <span>欢迎：${loginUser.username}</span>
            <a href="${pageContext.request.contextPath}/collect/myList" class="btn btn-warning">我的收藏</a>
            <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-default">注销</a>
        </div>
    </div>

    <div class="search-box" style="margin-bottom:20px;">
        <input type="text" id="searchInput" placeholder="搜索植物名称...">
        <button class="btn btn-primary" onclick="searchPlant()">搜索</button>
        <button class="btn btn-default" onclick="resetSearch()">重置</button>
    </div>

    <div class="row" id="plantContainer">
        <c:forEach items="${plantList}" var="plant">
            <div class="plant-card" data-name="${plant.plant_name}">
                <img src="${plant.plant_img}" class="plant-img" alt="${plant.plant_name}">
                <h4>${plant.plant_name}</h4>
                <p>${plant.plant_desc}</p>
                <p>序号: ${plant.plant_id}</p>

                <a href="${pageContext.request.contextPath}/adopt/toApply?plantId=${plant.plant_id}"
                   class="btn btn-success btn-block">我要领养</a>
                <button class="btn btn-default btn-block collectBtn" data-pid="${plant.plant_id}">☆ 收藏</button>
                <button class="btn btn-default btn-block msgBtn" data-pid="${plant.plant_id}">▶ 留言板</button>

                <div class="comment-box" id="msgBox-${plant.plant_id}">
                    <div class="comment-list" id="list-${plant.plant_id}"></div>
                    <textarea class="form-control" rows="2" placeholder="输入留言"></textarea>
                    <button class="btn btn-primary btn-sm" style="margin-top:5px" onclick="send(${plant.plant_id})">提交</button>
                </div>
            </div>
        </c:forEach>
    </div>

    <div style="text-align:center; margin:20px;">
        <!-- 这里已经改成正确的用户首页地址 -->
        <a href="${pageContext.request.contextPath}/user/toUserIndex" class="btn btn-default">← 返回用户首页</a>
        <a href="${pageContext.request.contextPath}/adopt/toMyApplies" class="btn btn-info">查看我的领养申请 →</a>
    </div>
</div>

<script>
    $(document).ready(function(){
        var userId = "${loginUser.user_id}";
        if(!userId) return;

        $(".collectBtn").each(function(){
            var btn = $(this);
            var pid = btn.data("pid");

            $.get("${pageContext.request.contextPath}/collect/isCollect", {userId:userId, plantId:pid}, function(res){
                if(res === true){
                    btn.html("★ 已收藏").removeClass("btn-default").addClass("btn-danger");
                }
            });
        });
    });

    $(".collectBtn").click(function(){
        var btn = $(this);
        var pid = btn.data("pid");
        $.post("${pageContext.request.contextPath}/collect/toggle", {plantId:pid}, function(res){
            if(res.status === 1){
                btn.html("★ 已收藏").removeClass("btn-default").addClass("btn-danger");
                alert(res.msg);
            }else if(res.status === 0){
                btn.html("☆ 收藏").removeClass("btn-danger").addClass("btn-default");
                alert(res.msg);
            }else{
                alert(res.msg);
            }
        });
    });

    $(".msgBtn").click(function(){
        var pid = $(this).data("pid");
        var box = $("#msgBox-"+pid);
        var list = $("#list-"+pid);
        if(box.is(":hidden")){
            $.get("${pageContext.request.contextPath}/comment/list?plantId="+pid, function(res){
                list.empty();
                $.each(res, function(i,c){
                    list.append('<div class="comment-item"><strong>'+c.username+'</strong>：'+c.content+'</div>');
                });
            });
        }
        box.toggle();
        $(this).html(box.is(":visible") ? "▼ 留言板" : "▶ 留言板");
    });

    function send(pid){
        var content = $("#msgBox-"+pid+" textarea").val().trim();
        if(!content){ alert("请输入内容"); return; }
        $.post("${pageContext.request.contextPath}/comment/add", {
            plantId: pid, content: content
        }, function(res){
            alert("提交成功！");
            location.reload();
        });
    }

    function searchPlant() {
        var keyword = $("#searchInput").val().trim().toLowerCase();
        $(".plant-card").each(function(){
            var name = $(this).data("name").toLowerCase();
            $(this).toggle(name.includes(keyword));
        });
    }

    function resetSearch() {
        $("#searchInput").val("");
        $(".plant-card").show();
    }
</script>
</body>
</html>