<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>绿植交换申请</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f7fa;
      font-family: "Microsoft YaHei", sans-serif;
      padding: 20px;
    }
    .container {
      max-width: 600px;
      margin: 50px auto;
      background: #ffffff;
      padding: 35px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      border: 1px solid #eee;
    }
    h2 {
      color: #2d8a5a !important;
      font-weight: bold;
      margin-bottom: 25px;
      text-align: center;
    }
    .form-group {
      margin-bottom: 22px;
    }
    label {
      font-weight: 500;
      color: #444;
      margin-bottom: 6px;
      display: block;
    }
    .form-control {
      border-radius: 6px;
      height: 42px;
      border: 1px solid #ddd;
    }
    textarea.form-control {
      height: auto;
      min-height: 100px;
    }
    .btn-success {
      background-color: #2d8a5a;
      border-color: #2d8a5a;
    }
  </style>
</head>
<body>
<%
  if (session.getAttribute("loginUser") == null) {
    response.sendRedirect(request.getContextPath() + "/user/toLogin");
    return;
  }
%>

<div class="container">
  <h2>绿植交换申请</h2>
  <hr>

  <div class="well" style="margin-bottom: 20px; border-radius: 8px;">
    <h4>你申请交换的绿植：</h4>
    <p><strong>名称：</strong>${idle.plant_name}</p>
    <p><strong>类型：</strong>${idle.plant_type}</p>
    <p><strong>描述：</strong>${idle.plant_desc}</p>
  </div>

  <!-- 只加 id，action 不动，兼容原有代码 -->
  <form id="exchangeForm">
    <input type="hidden" name="idleId" value="${idle.plant_id}">
    <input type="hidden" name="plant_type" value="交换绿植">

    <div class="form-group">
      <label>我的绿植名称：</label>
      <input type="text" name="myPlantName" class="form-control" required>
    </div>

    <div class="form-group">
      <label>我的绿植描述：</label>
      <textarea name="myPlantDesc" class="form-control" rows="3" required></textarea>
    </div>

    <div class="form-group">
      <label>上传绿植照片：</label>
      <input type="file" id="imgFile" accept=".jpg,.jpeg,.png,.gif" class="form-control">
      <input type="hidden" name="myPlantImg" id="plant_img">
      <div id="imgPreview" style="margin-top:10px;max-width:200px"></div>
    </div>

    <button type="submit" class="btn btn-success btn-block">提交交换申请</button>
    <a href="${pageContext.request.contextPath}/idlePlant/toList" class="btn btn-default btn-block" style="margin-top:10px">返回列表</a>
  </form>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
  // 图片上传（你原来的代码，不动）
  document.getElementById('imgFile').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function() {
      document.getElementById('imgPreview').innerHTML = '<img src="'+reader.result+'" style="width:100%">';
      document.getElementById('plant_img').value = reader.result;
    }
    reader.readAsDataURL(file);
  });

  // 🔥 新增：AJAX提交 + 弹窗提示
  $("#exchangeForm").submit(function(e){
    e.preventDefault(); // 禁止跳转到JSON页面

    $.post("${pageContext.request.contextPath}/idlePlant/exchangeApply", $(this).serialize(),
            function(res){
              if(res.code == 200){
                alert("✅ 提交成功！等待管理员审核");
                window.location.href = "${pageContext.request.contextPath}/idlePlant/toList";
              }else{
                alert("❌ 提交失败：" + res.msg);
              }
            });
  });
</script>
</body>
</html>