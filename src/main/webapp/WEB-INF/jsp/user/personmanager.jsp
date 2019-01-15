<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>人员管理</title>
    <%@include file="../common.jsp"%>
</head>
<style>
    .ztreeEdit{
        margin-top: 12px;
    }
</style>
<body>
<body>
<div class="main_top">

</div>

<div class="ztreeEdit layui-fluid">

    <div class="roleSearch layui-form">
        &nbsp;&nbsp;&nbsp;用户名：
        <div class="layui-input-inline">
            <input type="text" class="layui-input inputHeight" id="USERNAME" style="width:150px;margin-left: 2px;" placeholder="请输入用户名">
        </div>
        &nbsp;&nbsp;&nbsp;手机号：
        <div class="layui-input-inline">
            <input type="text" class="layui-input inputHeight" id="PHONE" style="width:150px;" placeholder="请输入手机号">
        </div>
        <div class="layui-input-inline">
            <a class="layui-btn layui-btn-xs " data-type="searchRole" title="搜索用户">搜索</a>
            <a class="layui-btn layui-btn-xs " data-type="deleteUser" title="删除用户">删除</a>
            <a class="layui-btn layui-btn-xs " data-type="insertUser" title="新增用户">新增</a>
            <a class="layui-btn layui-btn-xs " data-type="startUser" title="启用用户">启用</a>
            <a class="layui-btn layui-btn-xs " data-type="stopUser" title="禁用用户">禁用</a>
            <a class="layui-btn layui-btn-xs " data-type="setAdmin" TITLE="管理员设置">管理员</a>

        </div>

    </div>
    <div>
        <table id="userTableId" lay-filter="userTableEvent"></table>
    </div>


</div>

<div id="updateOrInsert" style="font-size:14px;margin-left:60px;display: none;margin-top: 30px;">
    <div class="layui-form">
        <input type="hidden" id="UID" name="id" hidden>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" name="username" id="xgname" value="" disabled style="background-color:#ccc;" placeholder="请输入用户名"
                       autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" id="xgphone" value="" placeholder="请输入手机号" autocomplete="off" class="layui-input ">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">通信地址</label>
            <div class="layui-input-inline">
						<textarea type="text" name="address" id="address" value="" style="height:40px;" placeholder="请输入通信地址"
                                  class="layui-input ">
                </textarea>
            </div>
            <label class="layui-form-label">备注</label>
            <div class="layui-input-inline">
						<textarea type="text" name="remark" id="remark" value="" style="height:40px;" placeholder="请输入备注"
                                  class="layui-input ">
                </textarea>
            </div>
        </div>
        <div class="layui-form-block　" style="margin-bottom:10px;margin-left: -30px;">

        </div>
    </div>

    <div class="layui-input-inline">
        <div class="layui-input-inline" style="margin-left:400px;">
            <button class="layui-btn layui-btn-sm" data-type="saveOrUpdateRole">保存</button>
            <button class="layui-btn layui-btn-sm" data-type="goBack">返回</button>
        </div>
    </div>
</div>

</body>


<script type="text/html" id="switchTpl">
    {{# if(d.gender != null && d.gender == 0){ }}
    男
    {{# }else if(d.gender != null && d.gender == 1){ }}
    女
    {{# }else{ }}
    &nbsp;
    {{# } }}

</script>
<script type="text/html" id="switchTp2">
    {{# if(d.isenabled != null && d.isenabled == 1){ }}
    启用
    {{# }else if(d.isenabled != null && d.isenabled == 0){ }}
    禁用
    {{# }else{ }}
    &nbsp;
    {{# } }}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" data="{{d.rid}}" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" data="{{d.rid}}" lay-event="accredit">授权</a>
</script>
<script type="text/html" id="barUserName">
    <a class="userNameOver" title="{{d.username}}">{{d.username}}</a>
</script>



<script type="text/html" id="shStatus">
    {{# if(d.isimp==null || d.isimp=='0'){ }}
    未审核
    {{# }else{ }}
    已审核
    {{# }}}
</script>
<script type="text/html" id="zxStatus">
    {{# if(d.isvalidate==null || d.isvalidate=='1' ){ }}
    是
    {{# }else{ }}
    否
    {{# }}}
</script>
<script type="text/html" id="templet3">
    {{# if(d.utype!=null && d.utype==0 ){ }}
    管理员
    {{# }else if(d.utype == null || d.utype == 1){ }}
    普通用户
    {{# }else{} }}
</script>
<script type="text/html" id="templet4">
    {{# if(d.state!=null && d.state==0 ){ }}
    禁用
    {{# }else if(d.utype != null && d.utype == 1){ }}
    启用
    {{# }else{} }}
</script>
<div id="userSetRole" style="font-size:10px;margin-left:60px;display: none;margin-top: 30px;margin-right: 80px;">
    <div class="layui-form">
        <input type="hidden" id="USERIDACCREDIT" value="">
        <div class="selectDwDivRight" style="margin-left:0px;">
            <div class="layui-input-inline" id="roleDivInfo">

            </div>
        </div>
        <div style="margin-top:50px;margin-left:320px;">
            <a class="layui-btn layui-btn-danger layui-btn-xs" data-type="saveUserAccredit">保存</a>
        </div>
    </div>


</div>
<script>
        var table;
        var layer;
        var  form;
        var $2;
        layui.use(['table','layer','form','laydate'], function(){
            table = layui.table;
            layer = layui.layer;
            form = layui.form;
            $2 = layui.$;
            var  laydate = layui.laydate;

            //常规用法
            laydate.render({
                elem: '#birthday'
                ,isInitValue: true
            });


            var roleTable = table.render({
                elem: '#userTableId' //指定原始表格元素选择器（推荐id选择器）
                ,page: true
                ,loading: true
                ,id: 'usercretificateTab'
                ,size: 'sm' //小尺寸的表格
                ,limit:'10'
                ,cellMinWidth: 60
                ,limits:[10,15,20]
                ,cols: [[
                    {
                        type:'checkbox'
                        ,width:50
                        ,fixed: 'left'
                    },{
                        field: 'username'  //其它参数在此省略
                        ,title:'用户名'
                        ,width: 160,
                        align:'center'
                        ,fixed: 'left'
                    }, {
                        field: 'telphone',
                        title:  '手机号'
                        ,width: 160
                        ,align:'center'
                    }, {
                        field: 'utype',
                        title:  '用户类型'
                        ,width: 120
                        ,align:'center'
                        ,templet:"#templet3"
                    }, {
                        field: 'state',
                        title: '状态'
                        , width: 170
                        , align: 'center'
                        ,templet:"#templet4"
                    } , {
                        title: '操作'
                        , width: 130
                        , align: 'center'
                        ,fixed: 'right'
                        ,toolbar: '#barDemo'
                    }

                ]] //设置表头
                //,…… //更多参数参考右侧目录：基本参数选项
                ,url:'userAction/queryPage'
                ,method:'POST'
                /*,where : {
                 userType:1
                 }*/
                ,response: {
                    dataName: 'data'
                    ,countName: 'count'
                    ,statusName: 'code'
                    ,statusCode: 200
                    ,msgName : 'msg'
                }
            });

            table.on('tool(userTableEvent)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'edit'){
                    // 设置用户信息
                    setUserInfo(data);
                    $2("#updateOrInsert").show();
                    $2('.ztreeEdit').hide();
                }else if(layEvent == 'accredit'){
                    //获取已经授权的角色及所有的角色
                    $("#USERIDACCREDIT").val(data.uid);
                    $("#roleDivInfo").empty();
                    $.post("sysRoleAction/queryUserDepartRole",{uId:data.uid},function(res){
                        if(res){
                            var array = [];
                            for(var i=0;i<res.length;i++){
                                var str = '<input type="checkbox" name="role" value="'+res[i].rid+'" title="'+res[i].rolename+'"';
                                if(res[i].falg=="true")
                                    str += checked="checked";
                                array.push(str+">");
                            }
                        }
                        $("#roleDivInfo").append(array.join(""));
                        form.render("checkbox");
                        layer.open({
                            type: 1,
                            content: $("#userSetRole"), //这里content是一个普通的String
                            area: ['500px', '400px'],
                            offset: ['80px', '50px'],
                            title:"角色信息"
                        });
                    },"json");
                }
            });

            var $ = layui.$, active = {

                searchRole: function(){
                    //执行重载
                    tableReload();
                },
                //返回
                goBack:function(){
                    $("#updateOrInsert").hide();
                    $('.ztreeEdit').show();
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
                        ids.push(e.uid);
                    });

                    $.post("userAction/saveOrUpdateUserToIsEnabled",{ids:ids.join(","),status:1},function(res){
                        if(res.status==200){
                            msg("启用成功");
                            tableReload();
                        }else
                            msg(res.message);
                    },"json");
                }
                ,stopUser:function(){
                    var checkStatus = table.checkStatus('usercretificateTab');
                    var data = checkStatus.data;
                    if(data&&data.length==0){
                        tip("请选择数据",$("#userTableId"));
                        return ;
                    }
                    var ids = new Array();
                    data.forEach(function(e){
                        ids.push(e.uid);
                    });
                    layer.confirm('确认禁用？用户将无法登录！', {
                        btn: ['确定', '取消']
                    }, function(){
                        $.post("userAction/saveOrUpdateUserToIsEnabled",{ids:ids.join(","),status:0},function(res){
                            if(res.status==200){
                                msg("用户已被禁用");
                                tableReload();
                            }else
                                msg(res.message);
                        },"json")
                                , function(){

                        };
                    })
                },
                setAdmin:function(){
                    var checkStatus = table.checkStatus('usercretificateTab');
                    var data = checkStatus.data;
                    if(data&&data.length==0){
                        tip("请选择数据",$("#userTableId"));
                        return ;
                    }
                    var ids = new Array();
                    data.forEach(function(e){
                        ids.push(e.uid);
                    });
                    if(ids.length>1){
                        tip("只允许单用户设置为管理员",$("#userTableId"));
                        return ;
                    }
                    $.post("userAction/userSerAdmin",{id:ids[0]},function(res){
                        if(res.status==200){
                            msg("设置管理员成功");
                            tableReload();
                        }else
                            msg(res.message);
                    },"json")
                },
                insertUser:function(){
                    resetUserInfo();
                    $2("#updateOrInsert").show();
                    $2('.ztreeEdit').hide();
                },

                deleteUser:function(){
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
                    layer.confirm('确认删除吗？', {
                        btn: ['确定', '取消']
                    }, function(){
                        $.post("userAction/deleteUserByIds",{ids:ids.join(",")},function(res){
                            if(res){
                                msg("删除成功");
                                tableReload();
                            }else
                                msg("操作失败");
                        },"json")
                    }, function(){

                    });
                },// 保存信息
                saveOrUpdateRole: function(){
                    var UID = $("#UID").val();
                    var mane = $("#xgname").val();
                    var phone = $("#xgphone").val();
                    if(phone&&phone.length!=11){
                        tip("手机号为11位！",$("#xgphone"));return;
                    }
                    var address = $("#address").val();
                    var remark = $("#remark").val();

                    var data = {
                        id:UID,     //用户主键
                        username:mane,     //用户主键
                        telphone:phone,     //用户主键
                        address:address,    // 通信地址
                        remark:remark      //备注
                    };
                    saveOrUpdate("userAction/saveOrUpdateUser",data,"修改成功");
                }
                ,saveUserAccredit:function(){
                    var roleInfos = $("#roleDivInfo input[name=role]");
                    var checkArray = [];
                    if(roleInfos&&roleInfos.length>0){
                        roleInfos.each(function (index,e) {
                            if(e.checked)
                                checkArray.push(e.value);
                        })
                    }
                    var uId = $("#USERIDACCREDIT").val();
                    if(checkArray&&checkArray.length==0){
                        tip("请选择角色",$2("#roleDivInfo"));
                        return;
                    }
                    var saveObj = [];
                    checkArray.forEach(function(e){
                        saveObj.push({uid:uId,rid:e});
                    });
                    $.ajax({
                        dataType:'json',
                        url:'userAndRoleAction/saveUserAndRole',
                        type:'post',
                        contentType:'application/json',
                        data:JSON.stringify(saveObj),
                        success:function(res){
                            if(res.status==200)
                                msg("角色分配成功");
                            else
                                msg(res.message);
                        },
                        error:function () {

                        }
                    });
                }
            };

            $('.roleSearch .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
            $('#updateOrInsert .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
            $('#userSetRole .layui-btn').on('click', function(){
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
            $2("#UID").val(data.id);
            $2("#xgname").val(data.username);
            $2("#xgphone").val(data.phone);
            $2("#address").val(data.address);
            $2("#remark").val(data.remark);

            //ie有bug注释了
            //form.render("select");
        }

        function resetUserInfo(){
            $2("#UID").val("");
            $2("#xgname").val("");
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
