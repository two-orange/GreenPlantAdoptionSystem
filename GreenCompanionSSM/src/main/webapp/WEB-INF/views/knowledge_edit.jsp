<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑养护知识</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <style>
        body {
            background-color: #f7f9fa;
            font-family: "Microsoft YaHei", sans-serif;
            padding: 30px 0;
        }
        .edit-box {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .edit-box h2 {
            color: #2d8a5a;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 6px;
            box-shadow: none;
        }
        label {
            font-weight: 500;
            margin-bottom: 8px;
        }
        .btn-group {
            margin-top: 25px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="edit-box">
    <h2>编辑养护知识</h2>
    <hr>
    <input type="hidden" id="knowledgeId" value="${knowledge.knowledge_id}">

    <div class="form-group">
        <label>标题：</label>
        <input type="text" id="title" class="form-control" value="${knowledge.title}">
    </div>

    <div class="form-group">
        <label>内容：</label>
        <textarea id="content" class="form-control" rows="12">${knowledge.content}</textarea>
    </div>

    <div class="btn-group">
        <button type="button" onclick="saveUpdate()" class="btn btn-primary">保存修改</button>
        <a href="${pageContext.request.contextPath}/knowledge/toList" class="btn btn-default">返回列表</a>
    </div>
</div>

<script>
    function saveUpdate() {
        var id = $("#knowledgeId").val();
        var title = $("#title").val().trim();
        var content = $("#content").val().trim();

        if (!title || !content) {
            alert("标题和内容不能为空！");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/knowledge/update",
            type: "POST",
            data: { id: id, title: title, content: content },
            dataType: "json",
            success: function(res) {
                alert(res.msg);
                if (res.code === 200) {
                    window.location.href = "${pageContext.request.contextPath}/knowledge/toList";
                }
            },
            error: function() {
                alert("网络错误，更新失败！");
            }
        });
    }
</script>
</body>
</html>