<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../static/layui/css/layui.css"  media="all">
</head>
<style>
    .layui-input {
        width: 50%;
    }
    .layui-upload-img {
        width: 92px;
        height: 92px;
        margin: 0 10px 10px 0;
        border: 0px;
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
</style>
<body>
    <div>
        <form id="orderForm" class="layui-form" lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">命令编码：</label>
                <div class="layui-input-block">
                    <input type="text" name="id" <c:if test="${orderData != null}">readonly </c:if> lay-verify="title" autocomplete="off" placeholder="请输入命令编码" class="layui-input" value="${orderData.id}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">命令说明：</label>
                <div class="layui-input-block">
                    <input type="text" name="orderStr" placeholder="请输入命令说明" autocomplete="off" class="layui-input" value="${orderData.orderStr}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">是否转向：</label>
                <div class="layui-input-block">
                    <input type="text" name="turn" placeholder="请输入转向" autocomplete="off" class="layui-input" value="${orderData.turn}">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn test" lay-submit="" lay-filter="saveOrUpdateOrder">保存</button>
                </div>
            </div>
        </form>

    </div>

<script src="../static/js/jquery.js" charset="utf-8"></script>
<script src="../static/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });

        //监听提交
        form.on('submit(saveOrUpdateOrder)', function(){
            //表单信息提交
            var dataFrom = $("#orderForm").serialize()
            $.ajax({
                url:"/order/saveOrUpdateOrder?"+dataFrom,
                type:"post",
                processData:true,
                dateType:"json",
                success:function(res){
                    if(res.status === "success"){
                        //保存成功
                        //layer.msg("保存成功！");
                        alert("保存成功")
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    }else{
                        //保存失败
                        alert("保存失败")
                    }

                }
            });
            return false;
        });
    });
</script>

</body>
</html>
