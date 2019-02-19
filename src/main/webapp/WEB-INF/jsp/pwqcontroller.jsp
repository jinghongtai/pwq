<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>监控页面</title>
    <%@include file="common.jsp"%>
    <script src="<%=basePath%>static/echarts/echarts.min.js"></script>
    <link rel="stylesheet" href="static/corn/iconfont.css" media="all"/>
</head>
<style>
    .ztreeEdit{
        margin-top: 2px;
    }
    .inputHeight{
        line-height:25px;
        height:25px;
    }
    .myFirstFont{
        font-style: normal;
        font-size: 30px;
        font-weight: 300;
        color: #009688;
    }
    #myCite{
        color: #000000;
    }
    .showNameDiv dl{
        font-size: 12px;
        width: 95%;
        height: 55px;
        line-height: 55px;
        /*margin-top: -12px;*/
    }
    .showNameDiv dl>div{
        height:50px;
        text-align: center !important;
        margin-bottom:4px;
        width: 33%;
        float: left;
    }
    .showNameDiv dl>div i{
        color:red;
        font-size:16px;
        font-weight: bold;
    }
    #myEcharts{
        width: 90%;
        height: 400px;
        margin-left:15px;
    }
</style>
<body>
<body>
<div class="main_top">

</div>

<div class="ztreeEdit layui-fluid">
    <div class="layui-col-md12">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md6">
                <div class="layui-card">
                    <div class="layui-card-header">喷雾器性能监测</div>
                    <div class="layui-card-body">

                        <div class="layui-carousel layadmin-carousel layadmin-shortcut" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 280px;">
                            <div carousel-item="" id="pwdShowDiv">


                            </div>

                            <script>

                                $(function(){

                                    headPer();


                                    $("body").on('mouseover','li.myMourseEvent',function(){
                                        $(".myMourseEvent").removeClass("layui-this");
                                        var showId = $(this).attr("showId");
                                        $("ul.firstdiv").removeClass("layui-this");
                                        $("ul.firstdiv[showId="+showId+"]").addClass("layui-this");
                                        $(this).addClass("layui-this");
                                    });


                                })

                                function headPer(){
                                    $.post("staticAction/queryConkOut",function(res){
                                        $("#pwdShowDiv").empty();
                                        $("#cictDiv").empty();
                                        // 处理返回的数据
                                        if(res){
                                            var html = [];
                                            var htm2 = [];
                                            for(var i=0;i<res.length;i++){
                                                var varData = res[i];
                                                var varHtml1 = '<ul class="layui-row layui-col-space10 ';
                                                var varHtml2 = '<li class="myMourseEvent';
                                                if(i==0){
                                                    varHtml1 += ' layui-this';
                                                    varHtml2 += ' layui-this';
                                                }
                                                varHtml1 += ' firstdiv" showId="'+i+'">';
                                                varHtml2 += ' " showId="'+i+'"></li>';
                                                for(var k=0;k<varData.length;k++){
                                                    varHtml1 += '<li class="layui-col-xs3"> <a lay-href="home/homepage1.html">' +
                                                            mes(varData[k])+
                                                            '<cite id=myCite>'+varData[k].name+'</cite> </a> </li>';
                                                }
                                                varHtml1 += "</ul>";
                                                html.push(varHtml1);
                                                htm2.push(varHtml2);
                                            }
                                            $("#pwdShowDiv").append(html.join(""));
                                            $("#cictDiv").append(htm2.join(""));

                                        }
                                    },"json");


                                }

                                function mes(data){
                                    var returnStr = '<div class="layui-icon showNameDiv"><dl>';
                                    if(data.communication == '0'){
                                        returnStr += '<div><i class="iconfont icon-tongyongku-gongjutubiao-tongxunyichang" title="通讯异常"></i></div>';
                                    }
                                    if(data.fjGzMark == '1'){
                                        returnStr += '<div><i class="iconfont icon-tongfengjitubiao" title="风机故障"></i></div>';
                                    }
                                    if(data.pwGzMark == '1'){
                                        returnStr += '<div><i class="iconfont icon-penwu" title="喷雾故障"></i></div>';
                                    }
                                    returnStr += '</dl></div>';
                                    return returnStr;
                                }

                            </script>
                            <div class="layui-carousel-ind">
                                <ul id="cictDiv">

                                </ul>
                            </div>
                            <button class="layui-icon layui-carousel-arrow" lay-type="sub"></button>
                            <button class="layui-icon layui-carousel-arrow" lay-type="add"></button>
                        </div>

                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-card">
                    <div class="layui-card-header">待办事项</div>
                    <div class="layui-card-body">

                        <div class="layui-carousel layadmin-carousel layadmin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 280px;">
                            <div carousel-item="">
                                <ul class="layui-row layui-col-space10 layui-this">
                                    <li class="layui-col-xs6">
                                        <a lay-href="app/content/comment.html" class="layadmin-backlog-body">
                                            <h3>命令发送</h3>
                                            <p><cite>66</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <a lay-href="app/forum/list.html" class="layadmin-backlog-body">
                                            <h3>成功执行</h3>
                                            <p><cite>12</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <a lay-href="template/goodslist.html" class="layadmin-backlog-body">
                                            <h3>执行失败</h3>
                                            <p><cite>99</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                                            <h3>通信异常</h3>
                                            <p><cite>20</cite></p>
                                        </a>
                                    </li>
                                </ul>
                                <ul class="layui-row layui-col-space10">
                                    <li class="layui-col-xs6">
                                        <a href="javascript:;" class="layadmin-backlog-body">
                                            <h3>待审友情链接</h3>
                                            <p><cite style="color: #FF5722;">5</cite></p>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="layui-carousel-ind"><ul><li class="layui-this"></li><li></li></ul></div><button class="layui-icon layui-carousel-arrow" lay-type="sub"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font></button><button class="layui-icon layui-carousel-arrow" lay-type="add"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font></button></div>
                    </div>
                </div>
            </div>
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-header">数据概览</div>
                    <div class="layui-card-body"  >
                        <div id="myEcharts"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>

<script>
    var myChart = echarts.init(document.getElementById('myEcharts'));
    $.post("staticAction/queryInfo",function(res){
        if(res){
            option = {
                title: {
                    text: '喷雾器历史数据',
                    subtext: '实时监测'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    // data:['最高气温','最低气温']
                    data:['风机故障', '喷雾故障','通讯异常']
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        dataView: {readOnly: false},
                        magicType: {type: ['line', 'bar']},
                        restore: {},
                        saveAsImage: {}
                    }
                },
                xAxis:  {
                    type: 'category',
                    boundaryGap: false,
                    data: res.times
                },
                yAxis: {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value}次'
                    }
                },
                series: [
                    {
                        name:'风机故障',
                        type:'line',
                        data:res.FJ,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    },
                    {
                        name:'喷雾故障',
                        type:'line',
                        data:res.PW,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    },
                    {
                        name:'通讯异常',
                        type:'line',
                        data: res.TX,
                        markPoint: {
                            data: [
                                {name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'},
                                [{
                                    symbol: 'none',
                                    x: '90%',
                                    yAxis: 'max'
                                }, {
                                    symbol: 'circle',
                                    label: {
                                        normal: {
                                            position: 'start',
                                            formatter: '最大值'
                                        }
                                    },
                                    type: 'max',
                                    name: '最高点'
                                }]
                            ]
                        }
                    }
                ]
            };



            myChart.setOption(option);
        }else{
            option = {
                title: {
                    text: '喷雾器历史数据',
                    subtext: '实时监测'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    // data:['最高气温','最低气温']
                    data:['风机故障', '喷雾故障','通讯异常']
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        dataView: {readOnly: false},
                        magicType: {type: ['line', 'bar']},
                        restore: {},
                        saveAsImage: {}
                    }
                },
                xAxis:  {
                    type: 'category',
                    boundaryGap: false,
                    data: ['周一','周二','周三','周四','周五','周六','周日']
                },
                yAxis: {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} °C'
                    }
                },
                series: [
                    {
                        name:'风机故障',
                        type:'line',
                        data:[11, 15, 15, 23, 14, 13, 11],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    },
                    {
                        name:'喷雾故障',
                        type:'line',
                        data:[11, 11, 15, 13, 12, 13, 10],
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }
                    },
                    {
                        name:'通讯异常',
                        type:'line',
                        data:[1, -2, 22, 51, 13, 2, 10],
                        markPoint: {
                            data: [
                                {name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
                            ]
                        },
                        markLine: {
                            data: [
                                {type: 'average', name: '平均值'},
                                [{
                                    symbol: 'none',
                                    x: '90%',
                                    yAxis: 'max'
                                }, {
                                    symbol: 'circle',
                                    label: {
                                        normal: {
                                            position: 'start',
                                            formatter: '最大值'
                                        }
                                    },
                                    type: 'max',
                                    name: '最高点'
                                }]
                            ]
                        }
                    }
                ]
            };



            myChart.setOption(option);
        }
    },'json');

</script>
</body>
</html>
