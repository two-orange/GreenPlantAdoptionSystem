<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发布闲置绿植</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect(request.getContextPath() + "/user/toLogin");
        return;
    }
%>

<div class="container" style="width: 600px; margin-top: 20px;">
    <h2>发布闲置绿植</h2>
    <hr>
    <form id="publishForm">
        <div class="form-group">
            <label>绿植名称：</label>
            <input type="text" id="plant_name" class="form-control" placeholder="例如：绿萝、多肉">
        </div>
        <div class="form-group">
            <label>绿植类型：</label>
            <input type="text" id="plant_type" class="form-control" placeholder="例如：观叶植物、多肉植物">
        </div>

        <div class="form-group">
            <label>绿植图片：</label>
            <input type="file" id="imgFile" accept=".jpg,.jpeg,.png,.gif" class="form-control">
            <div id="imgPreview" style="margin-top:10px;max-width:200px"></div>
        </div>

        <div class="form-group">
            <label>交换描述：</label>
            <textarea id="description" class="form-control" rows="5" placeholder="描述绿植状态、交换要求等"></textarea>
        </div>

        <button type="button" onclick="publish()" class="btn btn-success">发布</button>
        <a href="${pageContext.request.contextPath}/idlePlant/toList" class="btn btn-default" style="margin-left: 10px;">取消</a>
    </form>
</div>

<script>
    var plant_img = "";

    document.getElementById('imgFile').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (!file) return;

        const allowed = ['jpg','jpeg','png','gif'];
        const ext = file.name.split('.').pop().toLowerCase();
        if (!allowed.includes(ext)) {
            alert("仅支持 JPG、PNG、GIF 格式图片");
            e.target.value = '';
            return;
        }

        const reader = new FileReader();
        reader.onload = function() {
            document.getElementById('imgPreview').innerHTML = '<img src="'+reader.result+'" style="width:100%">';
            plant_img = reader.result;
        }
        reader.readAsDataURL(file);
    });

    function publish() {
        var plant_name = $("#plant_name").val().trim();
        var plant_type = $("#plant_type").val().trim();
        var description = $("#description").val().trim();

        if (!plant_name || !plant_type || !description) {
            alert("请填写完整信息！");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/idlePlant/publish",
            type: "POST",
            data: {
                plant_name: plant_name,
                plant_type: plant_type,
                plant_img: plant_img,
                description: description
            },
            dataType: "json",
            success: function(res) {
                alert(res.msg);
                if (res.code === 200) {
                    window.location.href = "${pageContext.request.contextPath}/idlePlant/toList";
                }
            },
            error: function() {
                alert("发布失败，请重试！");
            }
        });
    }
</script>
</body>
</html>