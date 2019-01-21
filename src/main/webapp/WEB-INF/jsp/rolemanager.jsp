<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <%@include file="common.jsp"%>
    <link rel="stylesheet" href="static/ztree/zTree/zTreeStyle/zTreeStyle.css">
    <script src="static/ztree/zTree/js/jquery.ztree.all.min.js"></script>
    <style>
        .ztreeEdit{
            width:100%;
            float: left;
            border:0 solid red;
            font-size:13px;
            overflow-y: auto;
            padding:0 15px;
            box-sizing:border-box;
            margin-top: 15px;
        }
        .addBtn{
            display:none;
        }
        .demoTable{
            margin-left:30px;
        }
        .inputHeight{
            line-height:25px;
            height:25px;
        }
        #departmentTree{
            position: absolute;
            z-index: 999999999;
            height: 150px;
            overflow-y: auto;
            width: 250px;
            background-color:#ccc;
        }
        #resourceWh{
            margin-left: 10px;
            height:280px;
            overflow-y: auto;
            width:330px;
        }
    </style>

</head>
<body>
<div class="main_top">
    <%-- <span class="main_top_title">角色分配</span>--%>
</div>

<div class="ztreeEdit">

    <div class="roleSearch">
        角色名称：
        <div class="layui-inline">
            <input class="layui-input inputHeight" name="id" id="roleName" autocomplete="off">
        </div>
        单位名称：
        <div class="layui-inline">
            <input class="layui-input inputHeight" name="id" id="dwName" autocomplete="off">
        </div>
        <button class="layui-btn layui-btn-xs " data-type="searchRole">搜索</button>
        <a class="layui-btn layui-btn-xs"  data-type="deleteRole">删除</a>
        <a class="layui-btn layui-btn-xs"  data-type="addRoleInfo">新增</a>
    </div>
    <div>
        <table id="role" lay-filter="roleTable"></table>
    </div>


</div>

</body>
<script>
    var table;
    var updateIndex;    //更新弹出层
    var setRolePermissionIndex; // 设置权限显示
    var jquery;
    var layer;
    layui.use(['table','layer'], function(){
        table = layui.table;
        layer = layui.layer;


        var roleTable = table.render({
            elem: '#role' //指定原始表格元素选择器（推荐id选择器）
            ,height: '450' //容器高度
            ,page: true
            ,loading: true
            ,id: 'roleTable'
            ,size: 'sm' //小尺寸的表格
            ,limit:'30'
            ,cellMinWidth: 80
            ,limits:[20,30,40]
            ,cols: [[
                {
                    type:'checkbox'
                    ,width:'10%'
                },
                {
                    field: 'rolename'  //其它参数在此省略
                    ,title:'角色名称'
                    ,width: '35%',
                    align:'center'
                },{
                    field: 'createTime',
                    title:  '创建时间'
                    ,width: '30%'
                    ,align:'center'
                    ,templet:"#switchTpl"
                    ,unresize: true
                }/*,{
                    title:  '权限设置'
                    ,width: '15%'
                    ,align:'center'
                    ,toolbar: '#roleSet'
                }*/,{
                    title: '操作'
                    ,width: ''
                    ,align:'center'
                    ,toolbar: '#barDemo'
                }
            ]] //设置表头
            //,…… //更多参数参考右侧目录：基本参数选项
            ,url:'sysRoleAction/querySysRoleByPage'
            ,method:'POST'
            /*,where : {
             userType:1
             }*/
            ,response: {
                dataName: 'data'      //数据列表的字段名称，默认：data
                ,countName: 'count' //数据总数的字段名称，默认：count
                ,statusName: 'code' //数据状态的字段名称，默认：code
                ,statusCode: 200    //成功的状态码，默认：0
                ,msgName : 'msg'
            }
        });

        var $ = layui.$, active = {

            searchRole: function(){
                //执行重载
                tableReload();
            },
            saveOrUpdateRole: function(){
                var id = $('#id').val();
                var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                var checkedNodes = treeObj.getCheckedNodes(true);
                var permissions = [];
                checkedNodes.forEach(function(e){
                    permissions.push(e.id);
                });
                if(!permissions||permissions.length==0){
                    tip("请选择资源","#dname");
                    return ;
                }
                var rname = $('#rname').val();
                if(!rname){
                    tip("请输入角色名称","#rname");
                    return ;
                }
                var remark = $('#remark').val();
                var data = {rolename:rname,resourcIds:permissions.join(","),remark:remark};
                if(id){
                    data.id=id;
                    saveOrUpdate(data);
                }
                if(!id){
                    saveOrUpdate(data);
                }
            },
            deleteRole:function(){
                // 已选择的角色
                var checkStatus = table.checkStatus('roleTable');
                var data = checkStatus.data;
                if(data&&data.length==0){
                    tip("请选择数据",$("#role"))
                }
                var rids = new Array();
                data.forEach(function(e){
                    rids.push(e.id);
                });
                $.post("sysRoleAction/deleteRoleById",{RIDS:rids.join(",")},function(res){
                    if(res.status=="success"){
                        msg("删除成功");
                        tableReload();
                    }else
                        msg(res.message);
                },"json")
            },
            addRoleInfo:function(){
                resetSaveOrUpdate();
                // 组织机构树清空
                var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                if(treeObj){
                    treeObj.checkAllNodes(false);
                }
                $(".ztreeEdit").hide();
                $("#updateOrInsert").show();
                /*  var treeObj = $.fn.zTree.getZTreeObj("departmentTree");
                 if(treeObj){
                 var nodes = treeObj.getCheckedNodes(true);
                 if(nodes&&nodes.length>0)
                 treeObj.checkNode(nodes[0], false, true)
                 }*/
            }
            ,goBack:function(){
                $(".ztreeEdit").show();
                $("#updateOrInsert").hide();
            }
            ,
            saveRolePermission:function(){
                var rId = $("#RoleId").val();
                var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                var checkedNodes = treeObj.getCheckedNodes(true);
                var permissions = [];
                checkedNodes.forEach(function(e){
                    permissions.push(e.rid);
                });
                var data = {rId:rId,perIds:permissions.join(",")};
                if(!rId){
                    msg("操作失败");
                    return;
                }
                //保存已授权的数据
                $.post("roleAndPermissionAction/saveRolePermission",data,function(res){
                    if(res&&res.status==200){
                        msg("授权成功");
                        layer.close(setRolePermissionIndex);
                    }else
                        msg("授权失败");
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
        $('#permissionDiv .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        //监听工具条 //roleTable 为table标签中的lay-filter="roleTable"
        table.on('tool(roleTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                    ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                resetSaveOrUpdate();
                $('#id').val(data.id);
                //$('#dname').val(dwName);
                $('#rname').val(data.rolename);
                $('#remark').val(data.remark);
                // 清空上次选择的数据
                var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                if(treeObj){
                    treeObj.checkAllNodes(false);
                }
                $("#RoleId").val(data.id);
                // 查询当前角色已授权的资源
                $.post("roleAndResourceAction/querySysRoleByEntity",{roleId:data.id},function(res){
                    if(res&&res.length>0){
                        if(treeObj){
                            var nodes = treeObj.transformToArray(treeObj.getNodes());
                            var nodeMap = {};
                            for(var k=0;k<nodes.length;k++){
                                nodeMap[nodes[k].id] = nodes[k];
                            }
                            for(var k=0;k<res.length;k++){
                                if(nodeMap[res[k].pId]){
                                    treeObj.checkNode(nodeMap[res[k].pId], true, false);
                                }
                            }
                            if(treeObj){
                                var nodes2 = treeObj.getCheckedNodes(true);
                                /*var nodes2 = treeObj.transformToArray(nodes);*/
                                var array = [];
                                nodes2.forEach(function (e) {
                                    array.push(e.resourceName);
                                });
                                $("#dname").val(array.join(","));
                            }
                            $(".ztreeEdit").hide();
                            $("#updateOrInsert").show();
                        }
                    }

                },"json");

                /*updateIndex = layer.open({
                 title:'修改',
                 type:1,
                 content:$("#updateOrInsert"),
                 area: ['500px', '400px']
                 });*/
            }else if(layEvent === 'roleSet'){
                // 清空上次选择的数据
                var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                if(treeObj){
                    treeObj.checkAllNodes(false);
                }
                $("#RoleId").val("");
                $("#RoleId").val(data.rid);
                // 查询当前角色已授权的资源
                $.post("roleAndPermissionAction/queryResourceByRoleId",{rId:data.rid},function(res){
                    if(res&&res.length>0){
                        if(treeObj){
                            var nodes = treeObj.transformToArray(treeObj.getNodes());
                            var obj = {};
                            for(var i=0;i<res.length;i++){
                                if(res[i])
                                    obj[res[i].rid]=res[i];
                            }
                            for(var k=0;k<nodes.length;k++){
                                if(obj[nodes[k].rid]){
                                    treeObj.checkNode(nodes[k], true, false);
                                }

                            }
                        }
                    }
                    setRolePermissionIndex = layer.open({
                        title:'设置权限',
                        type:1,
                        content:$("#permissionDiv"),
                        area: ['350px', '400px']
                    });

                },"json");
            }
        });


    });

    function tableReload(){
        var roleInput = $('#roleName');
        var dwInput = $('#dwName');

        table.reload('roleTable', {
            page: {
                curr: 1 //重新从第 1 页开始
            }
            ,where: {
                roleName: roleInput.val(),
                dwName: dwInput.val()
            }
        });
    }
    /** 保存或者更新操作
     * 传入参数：@param
     * 创建者:   jinghongtai
     * 创建日期：2018/7/31
     * 返回类型：
     */
    function saveOrUpdate(data){
        $.post("sysRoleAction/saveOrUpdateSysRole",data,function(res){
            if(res.status=="success"){
                tableReload();
                msg("保存成功");
                layer.close(updateIndex);
            }else
                msg(res.message);
        },"json")
    }

    function msg(content){
        layer.msg(content, {
            time: 2000, //2s后自动关闭
            //btn: ['明白了', '知道了']
        });
    }

    function tip(content,position){
        layer.tips(content, $(position)); //在元素的事件回调体中，follow直接赋予this即可
    }


    $(function(){
        //

        $(".selectDw").on("click",function(){
            $("#resourceZtree").toggle();
        })

        // 点击全部单位
        $(".selectAll").on("click",function(){
            var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
            if(treeObj){
                var nodes = treeObj.transformToArray(treeObj.getNodes());
                var array = [];
                nodes.forEach(function (e) {
                    array.push(e.resourceName);
                    treeObj.checkNode(e, true, true)
                });
                $("#dname").val(array.join(","));
            }
        })
        // 资源树初始化
        departController.ztreeInitResource()

    });

    /**
     * 点击单选事件
     * 传入参数：@param
     * 创建者:   jinghongtai
     * 创建日期：2018/7/31
     * 返回类型：
     */
    function zTreeOnCheck(event, treeId, treeNode){
        var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
        if(treeObj){
            var nodes2 = treeObj.getCheckedNodes(true);
            /*var nodes2 = treeObj.transformToArray(nodes);*/
            var array = [];
            nodes2.forEach(function (e) {
                array.push(e.resourceName);
            });
            $("#dname").val(array.join(","));
        }

    }

    var setting = {
        edit: {
            enable: false,
            showRenameBtn: false
        },
        view:{
            showLine:true,
            selectedMulti:false
        },
        check: {
            enable: true,
            chkStyle: "radio",
            radioType: "all"
        },
        data: {
            simpleData:{
                enable: true,
                idKey: "did",
                pIdKey: "pid",
                rootPId: "0"
            },
            key:{
                url:'#',
                name:"departmentalias"
            }
        },
        callback: {
            /* onCheck: zTreeOnCheck*/
        }
    };

    /**
     * 资源树设置
     * 传入参数：@param
     * 创建者:   jinghongtai
     * 创建日期：2018/8/1
     * 返回类型：
     */
    var settingResource = {
        edit: {
            enable: false,
            showRenameBtn: false,
            drag: {
                isCopy: false,
                isMove: false,
                prev: false,
                next: false,
                inner: false
            }
        },

        view:{
            showLine:true,
            selectedMulti:false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            radioType: "all",
            chkboxType: { "Y": "ps", "N": "ps" }
        },
        data: {
            simpleData:{
                enable: true,
                idKey: "id",
                pIdKey: "pid",
                rootPId: "0"
            },
            key:{
                url:'#',
                name:"resourceName"
            }
        },
        callback: {
            onCheck: zTreeOnCheck
        }
    };




    var departController = {

        ztreeInit :function(){
            var treeObj = $.fn.zTree.getZTreeObj("departmentTree");
            if(treeObj)
                treeObj.checkAllNodes(false);
            // 查询所有的资源信息
            $.post("sysDepartmentAction/queryDepartment",function(result){
                        if(result&&result.length>0){
                            var zNodes = result;
                            zNodes[0].open = true;
                            $.fn.zTree.init($("#departmentTree"), setting, zNodes);
                        }else{
                            alert("数据加载失败");
                        }
                    },
                    "json");
        },
        /**
         * 查询资源数据
         */
        ztreeInitResource :function(){
            var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
            if(treeObj)
                treeObj.checkAllNodes(false);
            // 查询所有的资源信息
            $.post("resourceAction/querySysResByEntity",function(result){
                        if(result&&result.length>0){
                            var zNodes = result;
                            zNodes[0].open = true;
                            $.fn.zTree.init($("#resourceZtree"), settingResource, zNodes);
                            /*var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");*/
                            // 展开一级菜单
                            var treeObj = $.fn.zTree.getZTreeObj("resourceZtree");
                            var node = treeObj.getNodeByParam("resourceName", '资源根节点', null);
                            if(node)
                                treeObj.expandNode(node, true, false, true);
                        }else{
                            alert("数据加载失败");
                        }
                    },
                    "json");
        },


    }



    function resetSaveOrUpdate(){
        $('#id').val("");
        $('#dname').val("");
        $('#rname').val("");
        $('#remark').val("");
    }


</script>
<script type="text/html" id="switchTpl">
    {{#  if(d.did == 'QBDW'){ }}
    公共角色
    {{#  } else if(d.dname == null || d.dname == ''){ }}

    {{# }else{ }}
    {{d.dname}}
    {{#  } }}
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" data="{{d.rid}}" lay-event="edit">修改</a>
</script>
<%--<script type="text/html" id="roleSet">
    <a class="layui-btn layui-btn-danger layui-btn-xs" data="{{d.rid}}" lay-event="roleSet">权限设置</a>
</script>--%>

<div id="updateOrInsert" style="font-size:10px;margin-left:60px;display: none;margin-top: 30px;margin-right: 80px;">
    <div class="layui-form" >
        <input type="hidden" id="id" name="id" hidden>
        <div class="layui-form-block　" style="margin-bottom:10px;">
            <label  class="layui-input-inline layui-form-label">角色名称：</label>
            <div class="layui-input-block " style="">
                <input type="text" name="roleName" id="rname"  value="" required lay-verify="required" placeholder="请输入角色名称" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-block"  style="margin-bottom:10px;">
        <label class="layui-input-inline layui-form-label">资源名称：</label>
        <div class="layui-input-block " style="" >
            <input type="text" name="dwname" id="dname"   value="" required  lay-verify="required" disabled="disabled" autocomplete="off" class="layui-input"  >
        </div>
        <div class="layui-input-inline" style="margin-left:110px;margin-top: 10px;">
            <button class="layui-btn layui-btn-sm selectDw">选择资源</button>
            <%-- <button class="layui-btn layui-btn-sm selectAll">全部资源</button>--%>
            <ul id="resourceZtree" class="ztree" style="z-index:999999999999;display: none;">
            </ul>

        </div>
    </div>
    <div class="layui-form-block"  style="margin-bottom:10px;">
        <label  class="layui-input-inline layui-form-label">备注：</label>
        <div class="layui-input-block" >
            <textarea name="REMARK" id="remark" placeholder="请输入备注" class="layui-textarea" heigth="50px"></textarea>
        </div>
    </div>

    <div class="layui-input-inline">
        <div class="layui-input-inline" style="margin-left:110px;">
            <button class="layui-btn layui-btn-sm"  data-type="saveOrUpdateRole">保存</button>&nbsp;&nbsp;&nbsp;
            <button class="layui-btn layui-btn-sm"  data-type="goBack"  >返回</button>
        </div>
    </div>
</div>

<div id="permissionDiv" style="font-size:10px;display:none;margin-top: 10px;">
    <input type="hidden" id="RoleId" value="">
    <div class="layui-form　" style="margin-bottom:20px;">
        <div class="layui-input-block" id="resourceWh">
            <ul id="resourceZtree2" class="ztree  " style="z-index:999999999999;">
            </ul>
        </div>
        <div class="layui-input-block" style="position: relative;">
            <button class="layui-btn layui-btn-sm"  data-type="saveRolePermission"  >保存</button>
        </div>
    </div>
</div>


</html>
