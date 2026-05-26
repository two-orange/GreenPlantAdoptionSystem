<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提交领养申请</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- 登录校验：未登录自动跳登录页 --%>
<%
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect(request.getContextPath() + "/user/toLogin");
        return;
    }
%>
<div class="container" style="margin-top:30px">
    <h2>提交领养申请</h2>

    <%-- 展示选择的绿植信息 --%>
    <div class="well" style="margin-bottom: 20px;">
        <h4>你选择的绿植：</h4>
        <p><strong>名称：</strong>${plant.plant_name}</p>
        <p><strong>类型：</strong>${plant.plant_type}</p>
    </div>

    <form action="${pageContext.request.contextPath}/adopt/submit" method="post" id="applyForm">
        <input type="hidden" name="plant_id" value="${plant.plant_id}">

        <%-- 图片上传（本地选择、限制 jpg/png/gif）--%>
        <div class="form-group">
            <label>上传绿植照片（可选）：</label>
            <input type="file" id="imgFile" accept=".jpg,.jpeg,.png,.gif" class="form-control" style="padding:5px">
            <input type="hidden" name="plant_img" id="plant_img">
            <div id="imgPreview" style="margin-top:10px;max-width:200px"></div>
        </div>

        <div class="form-group">
            <label>申请理由：</label>
            <textarea name="reason" class="form-control" rows="5" required placeholder="请说明你领养绿植的原因、养护经验等"></textarea>
        </div>

        <button type="submit" class="btn btn-success">提交领养申请</button>
        <a href="${pageContext.request.contextPath}/plant/toBrowse" class="btn btn-default" style="margin-left:10px">返回选择绿植</a>
    </form>
</div>

<script>
    // 图片选择、预览、自动填入表单
    document.getElementById('imgFile').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (!file) return;

        // 限制只能选图片
        const allowed = ['jpg','jpeg','png','gif'];
        const ext = file.name.split('.').pop().toLowerCase();
        if (!allowed.includes(ext)) {
            alert("仅支持 JPG、PNG、GIF 格式图片");
            e.target.value = '';
            return;
        }

        // 预览图片
        const reader = new FileReader();
        reader.onload = function() {
            document.getElementById('imgPreview').innerHTML =
                '<img src="'+reader.result+'" style="width:100%">';
            // 把图片base64放入隐藏域提交到后端
            document.getElementById('plant_img').value = reader.result;
        }
        reader.readAsDataURL(file);
    });
</script>
</body>
</html>