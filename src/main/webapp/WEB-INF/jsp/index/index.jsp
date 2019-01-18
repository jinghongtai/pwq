<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="static/css/layui2.css" />
    <link rel="stylesheet" href="static/css/admin.css" />
    <script type="text/javascript" src="static/common/hm.js"></script>
    <style>
        .wc{
            border-bottom:1px solid #000000;
           /* background: #00F7DE;*/
            width: 80%;
            height: 80%;
            margin: 30px auto;
            text-align: center;
        }
        .gdm{
            border-bottom:2px solid #40AFFE;
            border-top:2px solid #40AFFE;
            text-align: center;
            background-color: #93D1FF;
        }
        .dch{
            margin: 0px auto;
        }
        .pwq{
            position: relative;
            animation: pwq 2s linear infinite 0s alternate;
            width: 20px;
            transform-origin: bottom center;
        }
        #pwq1 {
            margin-top: 50px;
        }

        @-webkit-keyframes pwq {
            /*10% {
                transform: rotate(90deg);
            }
            20% {
                transform: rotate(-90deg);
            }
            30% {
                transform: rotate(90deg);
            }
            40% {
                transform: rotate(-90deg);
            }*/
            50%,100% {
                /*左右摇摆的时候直接调整这个就行*/
               transform: rotate(0deg);
            }
        }


        .flame {
            position:relative;
            width: 10px;
            height: 10px;
            background: linear-gradient(-45deg, red, orange);
            border-radius: 10px 10px 0px 10px;
            -webkit-transform: rotate(-135deg);
            transform: rotate(-135deg);
            -webkit-animation: .1s flame infinite;
            animation: .1s flame infinite;
            -webkit-filter: blur(10px);
            filter: blur(10px);
            position: relative;
            box-shadow: 10px 5px 2px #CCCCCC;
            border: 5px solid #ff5b1e;
            border-left-width: 5px;
            border-top-width: 5px;
        }
        .flame:after, .flame:before {
            content: '';
            width: 10px;
            height: 10px;
            display: block;
            position: absolute;
            background: linear-gradient(-45deg, red, orange);
            -webkit-animation: .2s flame infinite;
            animation: .2s flame infinite;
            -webkit-transform: scale(0.8) rotate(20deg);
            transform: scale(0.8) rotate(20deg);
            border-radius: 10px 10px 0px 10px;
            top: 20px;
        }
        .flame:before {
            top: 0;
            -webkit-animation-duration: .09s;
            animation-duration: .09s;
            -webkit-transform: scale(0.9) rotate(-15deg) translate(10px, 0px);
            transform: scale(0.9) rotate(-15deg) translate(10px, 0px);
        }

        @-webkit-keyframes flame {
            0% {
                height: 10px;
                width: 10px;
            }
            50% {
                height: 10px;
                width: 10px;
            }
            100% {
                height: 10px;
                width: 10px;
            }
        }

        @keyframes flame {
            0% {
                height: 10px;
                width: 10px;
            }
            50% {
                height: 10px;
                width: 11px;
            }
            100% {
                height: 10px;
                width: 20px;
            }
        }
        .pwt{
            position:relative;
            border-bottom: 19px solid #ff8e59;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            height: 0;
            width: 10px;
            background: -webkit-radial-gradient(0% 0%, farthest-corner, red, #ff5b1e, #ff8e59);
        }
        .pwti{
            position:relative;
            width: 20px;
            height: 40px;
            background: -webkit-radial-gradient(50% 0%, farthest-corner, red, #ff5b1e, #ff8e59);
            box-shadow: 1px 3px 6px #888888;
        }
        #pwq2 {
            margin-top: 150px;
        }
        /*#pwq9,#pwq8{
            float: right;
            margin-top: -100px;
        }*/
        #pwq9{
            float: right;
            margin-top: -300px;
            margin-right: 50px;
        }
        #pwq8{
            float: right;
            margin-top: -100px;
            margin-right: 50px;
        }
        #pwq3,#pwq4,#pwq5,#pwq6,#pwq7{
            float: left;
            margin-left: 130px;
            margin-bottom: 0px;
            margin-top: 50px;
        }
       /* #pwq4{
            float: left;
            margin-left: 100px;
        }
        #pwq5{
            float: left;
            margin-left: 100px;
        }
        #pwq6{
            float: left;
            margin-left: 100px;
        }
        #pwq7{
            float: left;
            margin-left: 100px;
        }
*/

    </style>
</head>
<body class="layui-layout-body" layadmin-themealias="default" >
    <div class="wrapper">
        <!-- 外层的线路 -->
        <div class="wc">
            <!-- 轨道门 -->
            <div class="gdm">
                ------门------机------轨------道------
            </div>
            <div class="dch">
                F堆场
            </div>
            <div class="pwq" id="pwq1">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    1#
                </div>
            </div>
            <div class="pwq" id="pwq2">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                   2#
                </div>
            </div>

            <div class="pwq" id="pwq8">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    8#
                </div>
            </div>
            <div class="pwq" id="pwq9">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    9#
                </div>
            </div>
            <div class="pwq" id="pwq3">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    3#
                </div>
            </div>
            <div class="pwq" id="pwq4">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    4#
                </div>
            </div>
            <div class="pwq" id="pwq5">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    5#
                </div>
            </div>
            <div class="pwq" id="pwq6">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    6#
                </div>
            </div>
            <div class="pwq" id="pwq7">
                <div class="flame">

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    7#
                </div>
            </div>
        </div>

    </div>
<script type="text/javascript" src="static/js/jquery.js"></script>
<script src="../static/layui/layui.js" charset="utf-8"></script>
<script src="../static/layui/lay/modules/layer.js" charset="utf-8"></script>
<script>
    <!-- 给每一个喷雾器添加一个点击事件 用于发送指令 -->
    //获取所有的pwq并绑定onclick事件
    $(function() {// 初始化内容
        $(".pwq").each(function(index,element){
            var aa = $(element);
            $(element).bind("click",function () {
                //
                var id = $(element).context.id;
                var num = "#1";
                if(typeof(id) != "undefined"){
                    num = id.substr(3,1)+"#";
                }

                //弹出窗口，里面设置相关的指令
                layer.open({
                    type: 2,
                    title:num+"  喷雾器管理界面",
                    area: ['300px', '500px'],
                    closeBtn:1,
                    content: '/sendOrder/sendOrderPage'
                });

              //  alert("绑定成功"+id)
            })
        })
    });


</script>

</body>
</html>
