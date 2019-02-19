<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>修改密码</title>
    <%@include file="common.jsp"%>
    <script src="static/js/jquery.form.js"></script>
    <link rel="stylesheet" href="static/corn/iconfont.css" media="all"/>
</head>
<style>
    .ztreeEdit{
        margin-top: 12px;
    }
    .inputHeight{
        line-height:25px;
        height:25px;
    }

    .layui-input {
        width: 50%;
    }
    .layui-upload-img {
        width: 92px;
        height: 92px;
        margin: 0 10px 10px 0;
        border: 0px;
    }

    .inputIng{
        margin-left: 110px;
        margin-top: -20px;
        opacity: 0;
        position: relative;
        top: -50px;
        width: 80px;
    }
    .layui-form-item{
        margin-left: 100px;
    }
    .layui-upload{
        margin-left: 100px;
        margin-top: 20px;
        border: solid 0px #0C0C0C;
    }
    img {
        max-width:100%;max-height:100%;
    }

    #personDiv{
        width:700px;
        margin: 0 auto;

    }
</style>
<body>
<body>
<div class="main_top">

</div>

<div class="ztreeEdit layui-fluid">

    <div>
        <div id="updateOrInsert" class="layui-form"  style="margin-top: 20px;" >
            <div class="layui-form-item ">
                <label class="layui-form-label">旧密码</label>
                <div class="layui-input-block"  >
                    <input type="password" id="pwd" name="pwd" value="" class="layui-input   "  >
                </div>

            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">新密码：</label>
                <div class="layui-input-block">
                    <input type="password" name="newpwd" id="newpwd" value="" lay-verify="title" autocomplete="off" placeholder="请输入新密码" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">确认新密码：</label>
                <div class="layui-input-block">
                    <input type="password" name="repwd"id="repwd" value=""  placeholder="请再次输入新密码" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <div class="layui-input-inline">
                        <div class="layui-input-inline" style="margin-left:350px;">
                            <button class="layui-btn layui-btn-sm" data-type="saveOrUpdateUser"  lay-submit lay-filter="*">保存</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


</div>



</div>

</body>



<script>
    var table;
    var layer;
    var  form;
    var $2;


    layui.use(['table','layer','form','laydate','upload'], function(){
        table = layui.table;
        layer = layui.layer;
        form = layui.form;
        $2 = layui.$;
        var  laydate = layui.laydate,upload = layui.upload;

        //监听提交
        form.on('submit(*)', function(data){
            return false;
        });



        var $ = layui.$, active = {
            goBack:function(){
                $("#updateOrInsert").hide();
                $('.ztreeEdit').show();
            }
            ,


            saveOrUpdateUser: function(){
                var pwd = $("#pwd").val();
                var newpwd = $("#newpwd").val();
                var repwd = $("#repwd").val();
                if(!pwd){
                    tip("旧密码不能为空","#pwd");
                    return ;
                }
                if(!newpwd){
                    tip("新密码不能为空","#newpwd");
                    return ;
                }
                if(!repwd){
                    tip("确认密码不能为空","#repwd");
                    return ;
                }
                if(repwd!=newpwd){
                    tip("两次密码输入不一致","#repwd");
                    return ;
                }
                //保存或更新
                $.ajax({
                    dataType:'json',
                    url:"userAction/moifyPwd",
                    data:{pwd:pwd,newPwd:newpwd},
                    type:'post',
                    success:function(res){
                        if(res&&res.status=="success"){
                            msg("修改成功！");
                        }else{
                            msg(res.message);
                        }
                    }

                });

            }

        };

        $('#personDiv .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('#updateOrInsert .layui-btn').on('click', function(){
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
