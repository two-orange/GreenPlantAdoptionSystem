<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑绿植</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="margin-top: 20px;">
    <h2>编辑待领养绿植</h2>

    <form action="${pageContext.request.contextPath}/plant/edit" method="post" onsubmit="return checkForm()">
        <input type="hidden" name="plant_id" value="${plant.plant_id}">

        <div class="form-group">
            <label>绿植名称：</label>
            <input type="text" name="plant_name" class="form-control"
                   value="${plant.plant_name}" placeholder="请输入绿植名称">
        </div>
        <div class="form-group">
            <label>绿植类型：</label>
            <input type="text" name="plant_type" class="form-control"
                   value="${plant.plant_type}" placeholder="请输入绿植类型">
        </div>
        <div class="form-group">
            <label>植物介绍：</label>
            <textarea name="plant_desc" class="form-control" rows="3" placeholder="请输入植物养护说明、特点等">${plant.plant_desc}</textarea>
        </div>

        <!-- 正常图片URL输入框 -->
        <div class="form-group">
            <label>图片URL：</label>
            <input type="text" name="plant_img" class="form-control"
                   value="${plant.plant_img}" placeholder="请输入图片网络地址">
        </div>

        <div class="form-group">
            <label>状态：</label>
            <select name="current_status" class="form-control">
                <option value="待领养" ${plant.current_status == '待领养' ? 'selected' : ''}>待领养</option>
                <option value="已领养" ${plant.current_status == '已领养' ? 'selected' : ''}>已领养</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">保存修改</button>
        <a href="${pageContext.request.contextPath}/plant/toList" class="btn btn-default">返回列表</a>
    </form>
</div>

<script>
    function checkForm() {
        let name = document.querySelector("input[name='plant_name']").value.trim();
        let type = document.querySelector("input[name='plant_type']").value.trim();
        if (name === "") { alert("绿植名称不能为空！"); return false; }
        if (type === "") { alert("绿植类型不能为空！"); return false; }
        return true;
    }
</script>
</body>
</html>