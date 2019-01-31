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
        <form id="userForm" class="layui-form" action="" lay-filter="example">
            <input type="hidden" id="id" name="id">

            <div class="layui-form-item layui-upload">
                <label class="layui-form-label">用户头像：</label>
                <div class="layui-upload-list" id="uploadclick">
                    <img class="layui-upload-img" id="uploadImage" style="border-radius:50%;border:1px solid #cccccc;">
                    <p id="demoText" style="margin-left: 250px; top: -70px; position: relative;"></p>
                    <input type="hidden" id="headImg" name="headImg" value="" class="layui-input">
                </div>

            </div>
         <%--   <div class="layui-form-item">
                <label class="layui-form-label">头像：</label>
                <div class="layui-input-block">
                    <input type="file" name="headImg" placeholder="头像" autocomplete="off" class="layui-input">
                </div>
            </div>--%>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名：</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码：</label>
                <div class="layui-input-block">
                    <input type="password" name="pwd" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">电话号：</label>
                <div class="layui-input-block">
                    <input type="text" name="telphone" placeholder="请输入电话号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址：</label>
                <div class="layui-input-block">
                    <input type="text" name="address" placeholder="请输入地址" autocomplete="off" class="layui-input">
                </div>
            </div>

            <%--    <div class="layui-form-item">
                    <label class="layui-form-label">开关</label>
                    <div class="layui-input-block">
                        <input type="checkbox" name="close" lay-skin="switch" lay-text="ON|OFF">
                    </div>
                </div>--%>

            <div class="layui-form-item">
                <label class="layui-form-label">角色：</label>
                <div class="layui-input-block">
                    <input type="radio" name="utype" value="0" title="管理员" checked="">
                    <input type="radio" name="utype" value="1" title="普通用户">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="saveOrUpdateUser">报存</button>
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

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [
                /^[\S]{6,12}$/
                ,'密码必须6到12位，且不能出现空格'
            ]
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        //监听提交
        form.on('submit(saveOrUpdateUser)', function(data){
            //表单信息提交
            var dataFrom = $("#userForm").serialize()


        /*    var aa = JSON.parse(dataFrom)*/
            $.ajax({
                url:"/userAction/saveOrUpdateUser?"+dataFrom,
                type:"post",
                processData:true,
                dateType:"json",
                success:function(dataFrom){
                    alert("报存成功")
                }
            });


           /* layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;*/
        });

        /*//表单初始赋值
        form.val('example', {
            "username": "贤心" // "name": "value"
            ,"password": "123456"
            ,"interest": 1
            ,"like[write]": true //复选框选中状态
            ,"close": true //开关状态
            ,"sex": "女"
            ,"desc": "我爱 layui"
        })*/


    });
    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#uploadclick'
            , url: '/upload'
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#uploadImage').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }else{
                    //获取上传地址
                    var imageUrl = res.msg;
                    $("#headImg").val(imageUrl);
                    $("#uploadImage").attr("src",imageUrl);

                }
                //上传成功
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
    })
</script>

</body>
</html>
