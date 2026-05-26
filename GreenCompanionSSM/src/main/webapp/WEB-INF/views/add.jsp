<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增绿植</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .input-file-box {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }
        .input-file-box input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        .input-file-text {
            display: block;
            width: 100%;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            cursor: pointer;
        }
        #imgPreview {
            margin-top: 10px;
            max-width: 200px;
            border: 1px solid #eee;
            border-radius: 4px;
        }
        /* 🔥 还原你原来的布局样式 */
        .container {
            max-width: 800px;
            margin: 20px auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: normal;
            margin-bottom: 5px;
            display: inline-block;
        }
        .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container" style="margin-top: 20px;">
    <h2>新增待领养绿植</h2>
    <form action="${pageContext.request.contextPath}/plant/add" method="post" onsubmit="return checkForm()">
        <div class="form-group">
            <label>绿植名称：</label>
            <input type="text" name="plant_name" class="form-control" placeholder="请输入绿植名称" required>
        </div>
        <div class="form-group">
            <label>绿植类型：</label>
            <input type="text" name="plant_type" class="form-control" placeholder="请输入绿植类型（如观叶植物/多肉/开花植物）" required>
        </div>
        <div class="form-group">
            <label>植物介绍：</label>
            <textarea name="plant_desc" class="form-control" rows="3" placeholder="请输入植物养护说明、生长特点等"></textarea>
        </div>

        <div class="form-group">
            <label>绿植图片：</label>
            <div class="input-file-box">
                <input type="text" class="input-file-text" id="fileText" placeholder="点击选择本地图片（仅支持jpg/png/gif）" readonly>
                <input type="file" id="imgFile" accept=".jpg,.jpeg,.png,.gif">
            </div>
            <input type="hidden" name="plant_img" id="plant_img">
            <img id="imgPreview" style="display: none;">
        </div>

        <div class="form-group">
            <label>状态：</label>
            <input type="text" name="current_status" class="form-control" value="待领养" readonly>
        </div>
        <button type="submit" class="btn btn-success">提交</button>
        <a href="${pageContext.request.contextPath}/plant/toList" class="btn btn-default">返回列表</a>
    </form>
</div>

<script>
    function checkForm() {
        let name = document.querySelector("input[name='plant_name']").value.trim();
        let type = document.querySelector("input[name='plant_type']").value.trim();
        let img = document.querySelector("input[name='plant_img']").value.trim();

        if (!name) {
            alert("绿植名称不能为空！");
            return false;
        }
        if (!type) {
            alert("绿植类型不能为空！");
            return false;
        }
        if (!img) {
            alert("请选择绿植图片！");
            return false;
        }
        return true;
    }

    const fileInput = document.getElementById('imgFile');
    const fileText = document.getElementById('fileText');
    const imgPreview = document.getElementById('imgPreview');
    const plantImgInput = document.getElementById('plant_img');

    fileText.addEventListener('click', () => fileInput.click());

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (!file) return;

        // 限制大小 2MB，防止服务器崩溃
        if (file.size > 2 * 1024 * 1024) {
            alert("图片不能超过 2MB！");
            e.target.value = "";
            return;
        }

        const allowedExts = ['jpg','jpeg','png','gif'];
        const ext = file.name.split('.').pop().toLowerCase();
        if (!allowedExts.includes(ext)) {
            alert("仅支持 JPG、PNG、GIF 格式的图片！");
            e.target.value = '';
            return;
        }

        fileText.value = file.name;

        const reader = new FileReader();
        reader.onload = function(e) {
            // 压缩图片，解决连接重置问题
            let img = new Image();
            img.src = e.target.result;
            img.onload = function() {
                let canvas = document.createElement("canvas");
                let ctx = canvas.getContext("2d");
                canvas.width = 300;
                canvas.height = 180;
                ctx.drawImage(img, 0, 0, 300, 180);
                let smallBase64 = canvas.toDataURL("image/jpeg", 0.6);

                imgPreview.src = smallBase64;
                imgPreview.style.display = "block";
                plantImgInput.value = smallBase64;
            };
        };
        reader.readAsDataURL(file);
    });
</script>
</body>
</html>