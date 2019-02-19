<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>个人中心</title>
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

    <div id="personDiv" class="layui-form" enctype="multipart/form-data" method="post" >
        <div class="layui-form-item layui-upload">
            <div class="layui-upload-list" style="margin-left: 20px;">
                <c:choose>
                    <c:when test="${empty USER_KEY.headImg}">
                        <img class="layui-upload-img" src="static/image/defaultHead.png"  style="border-radius:50%;border:1px solid #cccccc;">
                    </c:when>
                    <c:otherwise>
                        <img class="layui-upload-img" src="${USER_KEY.headImg}"  style="border-radius:50%;border:1px solid #cccccc;">
                    </c:otherwise>
                </c:choose>


            </div>

        </div>
        <style>
            .meInfo{
                width: 100%;
                display:block;

            }
            .meInfo i{
                color: #0C0C0C;
                font-size: 30px;
            }
            .meInfo div{
                height:80px;
                display: inline-block;
                float: left;
                line-height: 80px;
            }
            .meInfo>div{
                font-size: 24px;
                font-family: Calibri;
            }
        </style>
        <div class="layui-form-item meInfo box" >
            <div style="width:10%"><i class="iconfont icon-geren"> </i></div>
            <div style="width:80%">
                <span>${USER_KEY.username}</span>
            </div>
        </div>

        <div class="layui-form-item meInfo box">
            <div style="width:10%"><i class="iconfont icon-dianhua"> </i></div>
            <div style="width:80%">
                <span>${USER_KEY.telphone}</span>
            </div>
        </div>
        <div class="layui-form-item meInfo box">
            <div style="width:10%"><i class="iconfont icon-dizhi"> </i></div>
            <div style="width:80%">
                <span>${USER_KEY.address}</span>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <div class="layui-input-inline">
                    <div class="layui-input-inline" style="margin-left:300px;">
                        <button class="layui-btn layui-btn-sm" data-type="modify"   >修改</button>

                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<div id="updateOrInsert" style="font-size:14px;margin-left:60px;display: none;margin-top: 30px;" lay-filter="testRadio">
    <div>
        <form id="userForm" class="layui-form" enctype="multipart/form-data" method="post" >
            <input type="hidden" id="id" name="id" value="${USER_KEY.id}">

            <div class="layui-form-item layui-upload">
                <label class="layui-form-label">用户头像：</label>
                <div class="layui-upload-list" id="uploadclick">
                    <img class="layui-upload-img"  <c:if test="${not empty USER_KEY.headImg}">
                         src="${USER_KEY.headImg}"
                         </c:if> id="uploadImage" style="border-radius:50%;border:1px solid #cccccc;">
                    <input type="file" id="headImg" name="file" value="" class="layui-input inputIng cfileInput" onchange="chageImge()">
                </div>

            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">用户名：</label>
                <div class="layui-input-block">
                    <input type="text" name="username" value="${USER_KEY.username}" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">电话号：</label>
                <div class="layui-input-block">
                    <input type="text" name="telphone" value="${USER_KEY.telphone}"  placeholder="请输入电话号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址：</label>
                <div class="layui-input-block">
                    <input type="text" name="address" value="${USER_KEY.address}" placeholder="请输入地址" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <div class="layui-input-inline">
                        <div class="layui-input-inline" style="margin-left:300px;">
                            <button class="layui-btn layui-btn-sm" data-type="saveOrUpdateUser"  lay-submit lay-filter="*">保存</button>
                            <button class="layui-btn layui-btn-sm" data-type="goBack">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
</div>


</div>

</body>



<script>
    var table;
    var layer;
    var  form;
    var $2;

    function chageImge(){
        var imgs = $2('.inputIng').val(),         //获取到input的value，里面是文件的路径
                fileFormat = imgs.substring(imgs.lastIndexOf(".")).toLowerCase(),
                fileObj = document.getElementById('headImg').files[0]; //上传文件的对象,要这样写才行，用jquery写法获取不到对象
        // 检查是否是图片
        if( !fileFormat.match(/.png|.jpg|.jpeg/) ) {
            tip('仅支持:png/jpg/jpeg',$('.fileInput'));
            return;
        }
        var url = getObjectURL(fileObj);
        $("#uploadImage").attr("src",url);

    }
    function getObjectURL(file) {
        var url = null ;
        if (window.createObjectURL!=undefined) {
            url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) {
            url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) {
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }
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
            //返回
            modify:function(){
                $("#updateOrInsert").show();
                $('.ztreeEdit').hide();
            },
            // 启用 禁用
            startUser:function(){
                var checkStatus = table.checkStatus('usercretificateTab');
                var data = checkStatus.data;
                if(data&&data.length==0){
                    tip("请选择数据",$("#userTableId"));
                    return ;
                }
                var ids = new Array();
                data.forEach(function(e){
                    ids.push(e.id);
                });

                if(ids.length>1){
                    tip("只允许单用户操作",$("#userTableId"));
                    return;
                }

                $.post("userAction/modifyUserInfo",{id:ids[0],state:1},function(res){
                    if(res.status=="success"){
                        msg("启用成功");
                        tableReload();
                    }else
                        msg(res.message);
                },"json");
            }
            ,

            saveOrUpdateUser: function(){
                $("#userForm").ajaxSubmit({
                    clearForm:true, //提交成功后是否清空表单中的字段值
                    restForm:true, //提交成功后是否重置表单中的字段值，即恢复到页面加载时的状态
                    type:'post',
                    dataType:'json',
                    contentType:"multipart/form-data",
                    url:'<%=basePath%>userAction/saveOrUpdateUserBySelf',
                    beforeSerialize:function(){
                        //用于修改元素的值
                    },
                    beforeSubmit:function(formData, jqForm, options){
                        var username = $("#userForm input[name=username]").val();
                        if(!username){
                            tip("用户名不能为空",$("#userForm input[name=username]"));
                            return false;
                        }
                        var telphone = $("#userForm input[name=telphone]").val();
                        if(!telphone){
                            tip("手机号不能为空",$("#userForm input[name=telphone]"));
                            return false;
                        }

                        return true;
                    },
                    success:function(data){
                        if(data.status == "success"){
                            msg("保存成功");
                            tableReload();
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

    //保存或更新
    function saveOrUpdate(url,data,tip){
        $2.ajax({
            dataType:'json',
            url:url,
            data:data,
            type:'post',
            success:function(res){
                if(res&&res.status=="success"){
                    msg("修改成功！");
                    tableReload();
                }else{
                    msg(res.message);
                }
            }

        });
    }

    function setUserInfo(data){
        $2("#id").val(data.id);
        $2("#updateOrInsert input[name=username]").val(data.username);
        $2("#updateOrInsert input[name=telphone]").val(data.telphone);
        $2("#updateOrInsert input[name=address]").val(data.address);
        $2("#updateOrInsert input[name=utype]").prop("checked","false");
        $2("#updateOrInsert input[name=utype][value="+data.utype+"]").prop("checked","true");
        if(data.headImg)
            $2("#uploadImage").attr("src",data.headImg);
        else
            $2("#uploadImage").removeAttr("src");
        //ie有bug注释了
        form.render();
    }

    function resetUserInfo(){
        $2("#id").val("");
        $2("#username").val("");
        $2("#xgphone").val("");
        $2("#address").val("");
        $2("#remark").val("");

        //ie有bug注释了
        //form.render("select");
    }


    function tableReload(){
        var USERNAME = $2('#USERNAME');
        var PHONE = $2('#PHONE');
        table.reload('usercretificateTab', {
            page: {
                curr: 1 //重新从第 1 页开始
            }
            ,where: {
                likeName: USERNAME.val(),
                telphone: PHONE.val(),
            }
        });
    }


    function IdCard(UUserCard,num){
        if(num==1){
            //获取出生日期
            birth=UUserCard.substring(6, 10) + "-" + UUserCard.substring(10, 12) + "-" + UUserCard.substring(12, 14);
            return birth;
        }
        if(num==2){
            //获取性别
            if (parseInt(UUserCard.substr(16, 1)) % 2 == 1) {
                //男
                return "男";
            } else {
                //女
                return "女";
            }
        }
        if(num==3){
            //获取年龄
            var myDate = new Date();
            var month = myDate.getMonth() + 1;
            var day = myDate.getDate();
            var age = myDate.getFullYear() - UUserCard.substring(6, 10);
            if (UUserCard.substring(10, 12) < month || UUserCard.substring(10, 12) == month && UUserCard.substring(12, 14) <= day) {
                age++;
            }
            return age;
        }
    }


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
