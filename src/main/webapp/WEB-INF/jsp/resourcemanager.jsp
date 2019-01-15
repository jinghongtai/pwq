<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>系统资源管理</title>
    <%@include file="common.jsp"%>
    <link rel="stylesheet" href="static/ztree/zTree/zTreeStyle/zTreeStyle.css">
    <script src="static/ztree/zTree/js/jquery.ztree.all.min.js"></script>
    <style>

        .ztreeLeftParent{
            width:250px;
            height:400px;
            float: left;
            margin:0 20px;

        }
        .ztreeLeft{
            background-color: white;
            border:1px #ccc solid;
            overflow-x: auto;
            overflow-y: auto;
            height: 100%;
            width:100%;;
        }
        .ztreeEdit{
            width:450px;
            float: left;
            border:0 solid red;
            font-size:13px;
            overflow-y: auto;
        }
        .addBtn{
            display:none;
        }
    </style>

</head>
<body>
<div class="main_top">

</div>
<div class="ztreeLeftParent" style="margin-top: 15px;">
    <div class="ztreeLeft">
        <ul id="resourceTree" class="ztree" style="z-index:99999999">
        </ul>
    </div>
</div>
<div class="ztreeEdit" style="margin-top: 15px;">

    <form class="layui-form" >
        <div class="layui-form-item">
            <label class="layui-form-label">资源名称</label>
            <div class="layui-input-block">
                <input type="text" id="RNAME" name="RNAME"  placeholder="请输入资源名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属资源</label>
            <div class="layui-input-block">
                <input type="text" ID="PARENTID" disabled name="PARENTID"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">控件类型：</label>
            <div class="layui-input-block" id="KJTYPE">
                <select name="TYPE"  id="TYPE" >
                    <option value=""></option>
                    <option value="0">目录</option>
                    <option value="1">页面</option>
                    <option value="2">控件</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">资源链接</label>
            <div class="layui-input-block">
                <input type="text" id="URL" name="URL"    autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">启用禁用</label>
            <div class="layui-input-block">
                <input type="checkbox" id="ISENABLED" name="ISENABLED" lay-text="启用|禁用"   lay-skin="switch">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">资源描述</label>
            <div class="layui-input-block" >
                <textarea name="BZ" id="BZ" placeholder="请输入内容" class="layui-textarea" heigth="50px"></textarea>
            </div>
        </div>
        <div class="layui-form-item layui-form-text updateBtn">
            <div class="layui-input-block updateBtn" >
                <button class="layui-btn addResouce layui-btn-xs" lay-submit lay-filter="addResouce" type="button">新增</button>
                <button class="layui-btn layui-btn-xs updateResource"  lay-submit lay-filter="updateResource" type="button">更新</button>
            </div>
            <div class="layui-input-block addBtn" >
                <button class="layui-btn saveResouce layui-btn-xs" lay-submit lay-filter="saveResouce" type="button">保存</button>
                <button class="layui-btn layui-btn-xs backResource"  lay-submit lay-filter="backResource" type="button">返回</button>
            </div>
        </div>


    </form>



</div>

</div>

</body>
<script>
    var form;

    var jquery;
    var layer;

    layui.use(['form','layer','element'], function(){
        form = layui.form;
        layer = layui.layer;
        /*var $ = layui.$;*/
        // 禁用掉form默认的提交事件
        form.on('submit(addResouce)', function(data){
            return false;
        });
        form.on('submit(updateResource)', function(data){
            return false;
        });






    });

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

        /***
         * ztree 数据显示
         */
        methodController.ztreeInit();


        /**
         * 新增资源
         * 传入参数：@param
         * 创建者:   jinghongtai
         * 创建日期：2018/7/27
         * 返回类型：
         */

        $(".addResouce").click(function(){
            $('.addBtn').show().siblings('.updateBtn').hide();
            $('.addBtn').attr("addResource","xz");
            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
            var treeNode = treeObj.getSelectedNodes()[0];
            if(treeNode&&treeNode.length==0){
                tip("请选择父节点",$("#resourceTree"));
            }
            $("#PARENTID").val(treeNode.resourceName);
            removeValue();

        });
        $(".backResource").click(function(){
            $('.addBtn').hide().siblings('.updateBtn').show();
            $('.addBtn').attr("addResource","gx");
            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
            var treeNode = treeObj.getSelectedNodes()[0];
            zTreeOnClick(event, 'resourceTree', treeNode)

        });
        $(".saveResouce").click(function(){
            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
            var nodes = treeObj.getSelectedNodes();
            if(nodes&&nodes.length==0){
                tip("请选择资源节点",$("#resourceTree"));
                return false;
            }
            var pId = nodes[0].id;
            var rname = $("#RNAME").val();
            var type =  $("#TYPE").val();
            var url = $("#URL").val();
            var isenabled = $("#ISENABLED").val();
            isenabled = isenabled&&isenabled=='on'?1:0;
            var bz = $("#BZ").val();
            var data = {pid:pId,resourceName:rname,type:type,url:url,state:isenabled,bz:bz};
            if(!rname){
                tip("资源名称不能为空",$("#RNAME"));
                return false;
            }
            if(!type){
                tip("请选择控件类型",$("#KJTYPE"));
                return false;
            }
            // 具体保存逻辑
            $.post("resourceAction/saveOrUpdateSysResource",data,function(res){
                if(res.status == "success"){
                    treeObj.addNodes(nodes[0], eval("("+res.node+")"));
                    msg("添加成功");
                }else{
                    msg(res.message);
                }
            });
        });
        /** 更新资源操作
         * 传入参数：@param
         * 创建者:   jinghongtai
         * 创建日期：2018/7/27
         * 返回类型：
         */
        $(".updateResource").click(function(){
            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
            var nodes = treeObj.getSelectedNodes();
            if(nodes&&nodes.length==0){
                tip("请选择资源节点",$("#resourceTree"));
                return false;
            }
            var rname = $("#RNAME").val();
            var type =  $("#TYPE").val();
            var url = $("#URL").val();
            var isenabled = $("#ISENABLED").val();
            isenabled = $("#ISENABLED").prop("checked");
            //isenabled = isenabled&&isenabled=='on'?1:0;
            isenabled = isenabled?1:0;
            var bz = $("#BZ").val();
            if(!rname){
                tip("资源名称不能为空",$("#RNAME"));
                return false;
            }
            if(!type){
                tip("请选择控件类型",$("#KJTYPE"));
                return false;
            }
            var data = {id:nodes[0].id,resourceName:rname,type:type,url:url,state:isenabled,bz:bz};
            $.post("resourceAction/saveOrUpdateSysResource",data,function(res){
                if(res.status == "success"){
                    nodes[0].resourceName=rname;nodes[0].type=type,nodes[0].url=url;nodes[0].state=isenabled,nodes[0].bz=bz;
                    treeObj.updateNode(nodes[0]);
                    msg("修改成功");
                }else{
                    msg(res.message);
                }
            });

        });
    });

    /**
     * 设置Ztree的那些按钮没有删除
     */
    function setRemoveBtn(treeId, treeNode){
        if(treeNode&&treeNode.rid==0)
            return false;
        else
            return true;
    }


    function zTreeBeforeRemove(treeId, treeNode){
        var flag = false;
        var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
        var nodes = treeObj.getSelectedNodes();
        if(nodes&&nodes.length==0||nodes[0].id!=treeNode.id){
            /*tip("请选择节点",treeNode);*/
            return false;
        }
        layer.confirm('确认删除？', {title:'提示'},
                function(index, layero){
                    zTreeOnRemove(nodes[0]);
                    layer.close(index);
                },
                function(index,layero){
                    flag = false;
                    layer.close(index);
                }

        );
        if(flag){
            return true;
        }else{
            return false;
        }
    }
    /**
     * 删除资源指定的节点
     * 传入参数：@param
     * 创建者:   jinghongtai
     * 创建日期：2018/7/27
     * 返回类型：
     */
    function zTreeOnRemove(treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
        var nodes = treeObj.getSelectedNodes();
        var data = {id: treeNode.id};
        $.post("resourceAction/deleteNode", data, function (res) {
            if (res.status == "success") {
                removeValue();
                treeObj.removeNode(nodes[0]);
                msg("删除成功")
            } else {
                msg(res.message);
            }
        })
    };


    /** ZTREE点击事件
     * 传入参数：@param
     * 创建者:   jinghongtai
     * 创建日期：2018/7/27
     * 返回类型：
     */
    function zTreeOnClick(event, treeId, treeNode){
        //清空上次点击节点的数据
        removeValue();
        var parentNode = treeNode.getParentNode();
        $("#RNAME").val(treeNode.resourceName);
        if(!parentNode)
            $("#PARENTID").val("root");
        else{
            if($('.addBtn').attr("addResource")=="xz"){
                $("#PARENTID").val(treeNode.resourceName);
            }else if($('.addBtn').attr("addResource")=="gx"){
                $("#PARENTID").val(parentNode.resourceName);
            }else
                $("#PARENTID").val(parentNode.resourceName);

        }
        $("#TYPE").val(treeNode.type);
        $("#URL").val(treeNode.url);
        if(treeNode.state==1){
            $("#ISENABLED").prop("checked",true);
        }else{
            $("#ISENABLED").prop("checked",false);
        }
        form.render();
        //form.render("select");
        //form.render("checkbox");
        $("#BZ").val(treeNode.bz);
        //console.log($("#ztreeEdit input[name=RNAME]").val())
    }

    function zTreeBeforeDrag(treeId, treeNodes){
        if(treeNodes[0].rid == '0')
            return false;
        else
            return true;
    }

    function prevTree(treeId, treeNodes, targetNode) {
        return !targetNode.isParent && targetNode.parentid == treeNodes[0].parentid;
    };
    function nextTree(treeId, treeNodes, targetNode) {
        return !targetNode.isParent && targetNode.parentid == treeNodes[0].parentid;
    };

    //  移动按钮释放前的操作
    function zTreeBeforeDrop(treeId, treeNodes, targetNode, moveType) {
        if(!targetNode) return false;
        if(!moveType || moveType == "inner") return false;
        var data = {id:treeNodes[0].rid,tId:targetNode.rid,moveType:moveType};
        var index = layer.load(2);
        $.ajax({
            type:'post',
            dataType:'json',
            url:"sysResourceAction/moveNode",
            data:data,
            async:false,
            success:function(res){
                layer.close(index);
                if(res.status == 200){
                    msg("排序成功！");
                    return true;
                }else{
                    msg("排序失败！");
                    return false;
                }
            },
            error:function(res){
                layer.close(index);
                msg("排序失败！");
                return false;
            }
        });
    };

    /*function zTreeOnDrag(event, treeId, treeNodes) {
     var node = treeNodes[0];
     // 获取当前父节点下的所有子节点 并重新对其排序操作
     var treeObj = $.fn.zTree.getZTreeObj(treeId);
     var nodes = treeObj.getNodeByParam("parentid", node.parentid, null);
     console.log(nodes)
     };*/
    /**
     * ztree 设置
     */
    var setting = {
        edit: {
            enable: true,
            showRemoveBtn: setRemoveBtn,
            showRenameBtn: false,
            removeTitle: "删除",
            drag:{
                prev: prevTree,
                next: nextTree,
                inner: false
            }
        },
        view:{
            showLine:true,
            selectedMulti:false
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
            onClick: zTreeOnClick,
            beforeRemove: zTreeBeforeRemove,
            beforeDrag: zTreeBeforeDrag,
            beforeDrop: zTreeBeforeDrop
            /*onDrag: zTreeOnDrag,*/
            /*onDragMove: zTreeOnDragMove*/
        }
    };


    var methodController = {

        /**
         * 查询资源数据
         */
        ztreeInit :function(){
            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
            if(treeObj)
                treeObj.checkAllNodes(false);
            // 查询所有的资源信息
            $.post("resourceAction/querySysResByEntity",function(result){
                        if(result&&result.length>0){
                            var zNodes = result;
                            zNodes[0].open = true;
                            $.fn.zTree.init($("#resourceTree"), setting, zNodes);
                            var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
                            var node = treeObj.getNodeByParam("rname", '资源根节点', null);
                            if(node)
                                treeObj.expandNode(node, true, false, true);
                        }else{
                            alert("数据加载失败");
                        }
                    },
                    "json");
        },


    }

    function removeValue(){
        $("#RNAME").val("");
        $("#TYPE").val("");
        $("#URL").val("");
        $("#ISENABLED").prop("checked",false);
        $("#BZ").val("");
        form.render();
        //form.render("checkbox");
    }


</script>
</html>

