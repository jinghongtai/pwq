<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="../static/css/mycss.css" />
    <link rel="stylesheet" href="../static/css/layui2.css" />
    <link rel="stylesheet" href="../static/css/admin.css" />
    <link rel="stylesheet" href="../static/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="../static/common/hm.js"></script>
    <style>


    </style>
</head>
<body class="layui-layout-body" layadmin-themealias="default" >
<input type="hidden" id="areaId" value="${data.areaId}">
    <div class="wrapper">
        <!-- 外层的线路 -->
        <div class="wc">
            <!-- 轨道门 -->
            <div class="gdm">
                ------门------机------轨------道------
            </div>
            <div class="dch">
                ${data.areaId}堆场
            </div>
            <div class="pwqa" id="pwq1" name="pwq">
                <!-- 每一个堆场对应的每一台喷雾器对应的发送指令的id值 -->
                <input type="hidden" id="pwqid1" value="${data.pwqid1}">
                <div <c:if test="${data.pwqid1 != null && data.pwqid1 != ''}">class="flame"</c:if> >

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    1#
                </div>
            </div>
            <div class="pwqb" id="pwq2" name="pwq">
                <input type="hidden" id="pwqid2" value="${data.pwqid2}">
                <div <c:if test="${data.pwqid2 != null && data.pwqid2 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                   2#
                </div>
            </div>

            <div class="pwqh" id="pwq8" name="pwq">
                <input type="hidden" id="pwqid8" value="${data.pwqid8}">
                <div <c:if test="${data.pwqid8 != null && data.pwqid8 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    8#
                </div>
            </div>
            <div class="pwqi" id="pwq9" name="pwq">
                <input type="hidden" id="pwqid9" value="${data.pwqid9}">
                <div <c:if test="${data.pwqid9 != null && data.pwqid9 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    9#
                </div>
            </div>
            <div class="pwqc" id="pwq3" name="pwq">
                <input type="hidden" id="pwqid3" value="${data.pwqid3}">
                <div <c:if test="${data.pwqid3 != null && data.pwqid3 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    3#
                </div>
            </div>
            <div class="pwqd" id="pwq4" name="pwq">
                <input type="hidden" id="pwqid4" value="${data.pwqid4}">
                <div <c:if test="${data.pwqid4 != null && data.pwqid4 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    4#
                </div>
            </div>
            <div class="pwqe" id="pwq5" name="pwq">
                <input type="hidden" id="pwqid5" value="${data.pwqid5}">
                <div <c:if test="${data.pwqid5 != null && data.pwqid5 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    5#
                </div>
            </div>
            <div class="pwqf" id="pwq6" name="pwq">
                <input type="hidden" id="pwqid6" value="${data.pwqid6}">
                <div <c:if test="${data.pwqid6 != null && data.pwqid6 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    6#
                </div>
            </div>
            <div class="pwqg" id="pwq7" name="pwq">
                <input type="hidden" id="pwqid7" value="${data.pwqid7}">
                <div  <c:if test="${data.pwqid7 != null && data.pwqid7 != ''}">class="flame"</c:if>>

                </div>
                <div class="pwt">

                </div>
                <div class="pwti">
                    7#
                </div>
            </div>
        </div>

    </div>
<script type="text/javascript" src="../static/js/jquery.js"></script>
<script src="../static/layui/layui.js" charset="utf-8"></script>
<script src="../static/layui/lay/modules/layer.js" charset="utf-8"></script>
<script>
    <!-- 给每一个喷雾器添加一个点击事件 用于发送指令 -->
    //获取所有的pwq并绑定onclick事件
    $(function() {// 初始化内容
        var areaId = $("#areaId").val();
        $("[name='pwq']").each(function(index,element){
            var aa = $(element);
            $(element).bind("click",function () {
                //

                var id = $(element).context.id;
                var orderNo = "1";
                if(typeof(id) != "undefined"){
                    orderNo = id.substr(3,1);
                }
                var aa = $("#pwqid"+id.substr(3,1)).val();
                console.log('sendOrder/sendOrderPage?areaId='+areaId+"&orderNo="+orderNo+"&id=111");
                //弹出窗口，里面设置相关的指令
                layer.open({
                    type: 2,
                    title:orderNo+"#  喷雾器管理界面",
                    area: ['300px', '500px'],
                    closeBtn:1,
                    content: 'sendOrder/sendOrderPage?areaId='+areaId+"&orderNo="+orderNo+"&id="+aa,
                    end: function(){
                        window.location.reload();
                    }
                });

              //  alert("绑定成功"+id)
            })
        })

        //根据存的值设置喷雾器的方向即摆动幅度
        //回去后台返回的值，根据数据库中存的值初始化喷雾器的方向以及摆动幅度
        var sendOrders = ${sendOrders}
        for(var i=0;i<sendOrders.length;i++){
            var orderNo = sendOrders[i].orderNo;
            var fanOperation = sendOrders[i].fanOperation;
            var sprayOperation = sendOrders[i].sprayOperation;
            var galeStrategy = sendOrders[i].galeStrategy;
            var swingOperation = sendOrders[i].swingOperation;
            var galeclFx = sendOrders[i].galeclFx;
            var swingFd = sendOrders[i].swingFd;
            if(fanOperation === '0103'){
                //加上class样式 flame
                $("#pwq"+orderNo).children("div")[0].classList.add("flame")

            }else{
                $("#pwq"+orderNo).children("div")[0].classList.remove("flame")
            }
            //喷雾操作 改变喷雾的颜色
            if(sprayOperation === '0105'){

            }else{
                //以前的颜色
            }

            //调整方向
            var classd = "pwqa";
            if("1" === orderNo){
                classd = "pwqa"
            }else if("2" === orderNo){
                classd = "pwqb"
            }else if("3" === orderNo){
                classd = "pwqc"
            }else if("4" === orderNo){
                classd = "pwqd"
            }else if("5" === orderNo){
                classd = "pwqe"
            }else if("6" === orderNo){
                classd = "pwqf"
            }else if("7" === orderNo){
                classd = "pwqg"
            }else if("8" === orderNo){
                classd = "pwqh"
            }else if("9" === orderNo){
                classd = "pwqi"
            }
            if(swingFd != null && swingFd != ''){
               //$("."+classd).css("animation", classd+" 2s linear infinite 0s alternate;");
                //调整方向多少度
                var style = document.getElementById("pwq"+orderNo);
                var style1 = '';
                if(swingFd != null && swingFd != ''){
                    style1 = '@-webkit-keyframes '+classd+'{50%,100% {transform: rotate('+swingFd+'deg);'
                }

                //这是一个数组

                var style = document.styleSheets[0].cssRules;
                var num = style.length;                //
                for(var j =0 ;j<num;j++){
                    if(style[j].name === classd){
                        document.styleSheets[0].deleteRule(j)
                        document.styleSheets[0].insertRule(style1,0)
                        //修改样式
                     /*  var aas = style[i].cssText
                        console.log(style[i].cssText)*/
                        break;

                    }
                }

                //style.insertRule(style1,0)
               // var aaa = $("."+classd).css(style)
                //var aaa = $("."+classd)[0].css(style)//.addClass(style);
               // console.log(style1);
                console.log(style);
            }else{
                $("."+classd).css("animation","initial");
                //调增东西南北方向
                if(galeclFx != null && galeclFx != ''){
                    if(galeclFx === '0'){
                        //东 90度
                        $("#pwq"+orderNo).css("transform","rotate(90deg)");
                    }else if(galeclFx === '1'){
                        //西
                        $("#pwq"+orderNo).css("transform","rotate(270deg)");
                    }else if(galeclFx === '2'){
                        $("#pwq"+orderNo).css("transform","rotate(180deg)");
                    }else{
                        $("#pwq"+orderNo).css("transform","rotate(0deg)");
                    }
                }
            }

            //调整摆动幅度



          //  alert(orderNo)

        }

    });


</script>

</body>
</html>
