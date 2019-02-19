<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>天津港射雾器远程管理平台</title>
    <%@include file="WEB-INF/jsp/common.jsp"%>
    <style>
        *{
            margin: 0 0;
        }
        body{
            margin: 0 auto;
            background-image: url("<%=basePath%>static/image/loginbackground.jpg") ;
            background-repeat: no-repeat;
            background-size: 100% 100%;
        }
        .loginDiv{
            width:500px;
            height:150px;
            /* border:1px #ccc solid;*/
            position: absolute;
            right:80px;
            top:200px;
            display: block;
        }

        .fontp{
            width: 90%;
            margin: 0 80px;
            font-size: 50px;
            text-shadow: 5px 5px 5px black, 0px 0px 2px red, 2px 2px 3px green;
        }

        .boxDiv{
            width: 70px;
            letter-spacing: 1px;
            font-size:16px;
            font-weight: 800;
            color: #f9ffed;
            word-spacing:9px;
            font-family: cursive;
            text-align: right;
        }
        .blockDiv{
            display: inline-block;
        }
        .blockDiv div{
            display: inline-block;
        }
        .inputDiv input{
            width:200px;
            height:26px;
            line-height: 26px;
            border-radius: 5px;
            opacity: 0.4;
        }
    </style>
</head>

<body >
<div class="layui-layout layui-layout-admin">
    <div class="fontp">
        天津港远程控制管理平台
    </div>
    <div class="loginDiv">
        <div class="blockDiv">
            <div class="boxDiv">用户名：</div>
            <div class="inputDiv"><input type="text" name="username" value="" id="username" placeholder="请输入用户名"/></div>
        </div>
        <div class="blockDiv" style="margin-top:10px;">
            <div class="boxDiv">密    码：</div>
            <div class="inputDiv"><input type="password" name="password" value="" id="password" placeholder="请输入密码" />
            </div>
        </div>
        <div class="blockDiv" style="margin-top:10px;">
            <div class="boxDiv"> </div>
            <button class="layui-btn layui-btn-xs layui-btn-radius " data-type="login" style="width:200px">登录</button>
        </div>

    </div>
</div>
<script>
    var table;
    var layer;
    var  form;
    var $2;


    if(self.location != top.location){
        top.location = self.location;
    }

    layui.use(['table','layer','form','laydate'], function(){
        table = layui.table;
        layer = layui.layer;
        form = layui.form;
        $2 = layui.$;
        var  laydate = layui.laydate;

        //监听提交
        form.on('submit(*)', function(data){
            return false;
        });





        var $ = layui.$, active = {


            login:function(){
                var username = $2("#username").val();
                var pwd = $2("#password").val();
                if(!username){
                    tip("用户名不能为空",$("#username"));
                    return ;
                }
                if(!pwd){
                    tip("密码不能为空",$("#password"));
                    return ;
                }
                $.post("userAction/login",{"username":username,"pwd":pwd},function(res){
                    if(res.status=="success"){
                       window.location.href="<%=basePath%>/main"
                    }else
                        msg(res.message);
                },"json")
            },

        };


        $('.loginDiv .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });



    });



    function tip(content,position){
        layer.tips(content, $2(position)); //在元素的事件回调体中，follow直接赋予this即可
    }


    function msg(content){
        layer.msg(content, {
            time: 2000
        });
    }

</script>
</body>
</html>
