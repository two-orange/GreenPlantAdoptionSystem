<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>数据统计中心</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f4f4f4;
            font-family: "Microsoft YaHei", sans-serif;
        }
        .top-nav {
            background-color: #2c3e50;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            width: 100%;
            color: white;
        }
        .top-nav a {
            color: white !important;
            text-decoration: none;
        }
        .top-nav .btn-logout {
            background-color: #e4393c;
            border: none;
            color: white;
            padding: 6px 16px;
            border-radius: 4px;
        }
        .container-fluid {
            padding: 30px 50px;
            width: 100% !important;
        }
        .page-header {
            background: white;
            padding: 15px 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-header h2 {
            margin: 0;
            font-size: 24px;
        }
        .white-box {
            background: white;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        h3 {
            margin-top: 10px !important;
        }
        /* 确保图表容器有固定高度 */
        #trendChart {
            width: 100%;
            height: 400px;
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

<div class="top-nav">
    <a href="#">🌿 绿伴校园 - 数据统计中心</a>
    <div>
        <span>欢迎：${loginUser.username}</span>
        <a href="${pageContext.request.contextPath}/user/logout" class="btn-logout" style="margin-left:15px">注销</a>
    </div>
</div>

<div class="container-fluid">
    <div class="page-header">
        <h2>📊 数据统计中心</h2>
        <div>
            <a href="javascript:history.back()" class="btn btn-default">← 返回上一页</a>
            <a href="${pageContext.request.contextPath}/plant/list" class="btn btn-primary">返回管理首页</a>
        </div>
    </div>

    <div class="white-box">
        <div class="row">
            <div class="col-md-4">
                <div class="alert alert-success text-center">
                    <h3>总用户</h3>
                    <h1>${totalStats.userCount}</h1>
                </div>
            </div>
            <div class="col-md-4">
                <div class="alert alert-info text-center">
                    <h3>总绿植</h3>
                    <h1>${totalStats.plantCount}</h1>
                </div>
            </div>
            <div class="col-md-4">
                <div class="alert alert-warning text-center">
                    <h3>总领养申请</h3>
                    <h1>${totalStats.applyCount}</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="white-box">
        <div class="panel-heading">
            <h4>用户活跃度排行</h4>
        </div>
        <div class="panel-body">
            <table class="table table-bordered">
                <tr>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>手机号</th>
                    <th>收到通知</th>
                    <th>已读通知</th>
                </tr>
                <c:forEach items="${activeUserList}" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.username}</td>
                        <td>${u.phone}</td>
                        <td>${u.totalNotice}</td>
                        <td>${u.readNotice}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <div class="white-box">
        <div class="panel-heading">
            <h4>📈 绿植领养申请趋势</h4>
        </div>
        <div class="panel-body">
            <div id="trendChart"></div>
        </div>
    </div>
</div>

<!-- 先引入 jQuery，再引入 ECharts -->
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/echarts/5.4.3/echarts.min.js"></script>
<script>
    // 等待页面所有资源加载完成后再初始化图表
    $(document).ready(function(){
        var chartDom = document.getElementById('trendChart');
        var myChart = echarts.init(chartDom);

        var dates = [], pending = [], adopt = [], reject = [];
        <c:forEach items="${plantTrendData}" var="item">
        dates.push('${item.dateStr}');
        pending.push(${item.pendingCount});
        adopt.push(${item.adoptCount});
        reject.push(${item.rejectCount});
        </c:forEach>

        var option = {
            title: { text: '领养申请趋势（按日期）' },
            tooltip: { trigger: 'axis' },
            legend: { data: ['待审核', '已通过', '已拒绝'] },
            xAxis: { type: 'category', data: dates },
            yAxis: { type: 'value' },
            series: [
                { name: '待审核', type: 'line', data: pending, smooth: true },
                { name: '已通过', type: 'line', data: adopt, smooth: true },
                { name: '已拒绝', type: 'line', data: reject, smooth: true }
            ]
        };

        myChart.setOption(option);
        // 窗口 resize 时自动调整图表大小
        window.addEventListener('resize', function(){
            myChart.resize();
        });
    });
</script>
</body>
</html>