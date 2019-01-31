<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <%@ include file="../common.jsp"%>
    <style>
        .ztreeEdit,#orderForm{
            margin-top: 12px;
            margin-left:15px;
        }
        .layui-input {
            width: 50%;
        }

    </style>
</head>
<body>
<div class="ztreeEdit">
    <table class="layui-hide" id="test" lay-filter="test"></table>
</div>

<div id="orderForm" style="display: none;margin-left:100px;margin-top:50px !important;" class="layui-form" lay-filter="example">
    <div class="layui-form-item">
        <input type="hidden" name="id" id="id" value="">
        <label class="layui-form-label">状态码：</label>
        <div class="layui-input-block">
            <input type="text" name="statusNo" id="statusNo"  lay-verify="title" autocomplete="off" placeholder="请输入状态码" class="layui-input" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">说明：</label>
        <div class="layui-input-block">
            <input type="text" name="statusDes" id="statusDes" placeholder="请输入状态码说明" autocomplete="off" class="layui-input" value="">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" style="margin-left:40%;">
            <button class="layui-btn test  layui-btn-sm" lay-submit="" data-type="saveOrUpdateOrder">保存</button>
            <button class="layui-btn test layui-btn-sm" lay-submit="" data-type="goBack">返回</button>
        </div>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addOrder">
            <i class="layui-icon">&#xe608;</i> 添加状态码
        </button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="../static/js/jquery.js" charset="utf-8"></script>
<script src="../static/layui/layui.js" charset="utf-8"></script>

<script>
    var $2 ;
    var table;
    var layer;

    function resetOrderInfo(){
        $2("#id").val("");
        $2("#statusNo").val("");
        $2("#statusDes").val("");
    }

    layui.use(['table','layer'], function(){
        table = layui.table;
        $2 = layui.$;
        layer = layui.layer;

        initTable(table) ;

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'addOrder':
                    resetOrderInfo();
                    $2("#orderForm").show();
                    $2('.ztreeEdit').hide();
                    break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                //删除对应的指令

                layer.confirm('真的删除行么', function(index){
                    deleteOrder(data.id,index);
                    layer.close(index);
                    initTable(table);
                   /* obj.del();
                    */
                });
            } else if(obj.event === 'edit'){
                $2("#id").val(data.id);
                $2("#statusNo").val(data.statusNo);
                $2("#statusDes").val(data.statusDes);
                $2("#orderForm").show();
                $2('.ztreeEdit').hide();
            }
        });

        var  active = {

            searchRole: function(){
                //执行重载
                tableReload();
            },
            //返回
            goBack:function(){
                $2("#orderForm").hide();
                $2('.ztreeEdit').show();
                tableReload();
            },
            // 启用 禁用
            saveOrUpdateOrder:function(){
                var id = $2("#id").val();
                var statusNo = $2("#statusNo").val();
                var statusDes = $2("#statusDes").val();
                if(!statusNo){
                    tip("状态码不能为空",$2("#statusNo"));
                    return ;
                }
                if(!statusDes){
                    tip("状态码说明不能为空",$2("#statusDes"));
                    return ;
                }
                $.post("orderStatusAction/saveOrUpdateOrderStatus",{"id":id,"statusNo":statusNo,"statusDes":statusDes},function(res){
                    if(res.status=="success"){
                        msg("操作成功");
                        tableReload();
                    }else
                        msg(res.message);
                },"json");
            }

        };
        //返回

        $('#orderForm .layui-btn').on('click', function(){
            var type = $2(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

    <!-- 弹出命令新增加页面方法 -->
    function openOrderPage(table,id){
        //弹出一个页面 里面有可添加指令信息
        //页面层
        var id = id;
        layer.open({
            id: "orderPage",
            type: 2,
            title: '添加指令',
            anim: -1,
            area: ['500px', '300px'], //宽高
            content: '/order/orderAddPage?id='+id,
            end: function(){
                initTable(table);
            }
        });
    }

    <!-- 初始化表单 -->
    function initTable(table){
        table.render({
            elem: '#test'
            ,id:'myOrderTable'
            ,url:'orderStatusAction/queryOrderStatusPage'
            ,toolbar: '#toolbarDemo'
            ,title: '命令状态码表'
            ,limits:[10,15,20]
            ,height:500
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'statusNo', title:'状态码', width:200, fixed: 'left', sort: true}
                ,{field:'statusDes', title:'状态码说明', width:300}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', align: 'center',  width:150}
            ]]
            ,page: true
            ,response: {
                dataName: 'data'
                ,countName: 'count'
                ,statusName: 'code'
                ,statusCode: 200
                ,msgName : 'msg'
            }
        });
    }

    <!--删除命令-->
    function deleteOrder(id,index){
        var id = id;
        $.ajax({
            url:"orderStatusAction/deleteOrderStatusById",
            data:{"id":id},
            type:"post",
            processData:true,
            dateType:"json",
            success:function(res){
                if(res.result === "success"){
                    //保存成功
                    msg("删除成功");
                    tableReload();
                    //刷新
                }else{
                    //保存失败
                    msg("删除失败")
                }

            }
        });
    }

    function tableReload(){

        table.reload('myOrderTable', {
            page: {
                curr: 1 //重新从第 1 页开始
            }

        });
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
