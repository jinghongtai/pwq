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
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <%--<button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>--%>
        <button class="layui-btn layui-btn-sm" lay-event="addOrder">
            <i class="layui-icon">&#xe608;</i> 添加指令
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
    layui.use('table', function(){
        var table = layui.table;
        initTable(table)
        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'addOrder':
                    //弹出一个页面 里面有可添加指令信息
                    //页面层
                    openOrderPage(table);
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
                console.log(data)
                openOrderPage(table,data.id);
            }
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
            ,url:'/order/queryOrderPage'
            ,toolbar: '#toolbarDemo'
            ,title: '命令页面'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'命令编码', width:250, fixed: 'left', sort: true}
                ,{field:'orderStr', title:'命令说明', width:550}
                ,{field:'turn', title:'是否转向', width:150}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,page: true
        });
    }

    <!--删除命令-->
    function deleteOrder(id,index){
        var id = id;
        $.ajax({
            url:"/order/deleteOrderById?",
            data:{"id":id},
            type:"post",
            processData:true,
            dateType:"json",
            success:function(res){
                if(res.result === "success"){
                    //保存成功
                    alert("删除成功")
                    //刷新
                }else{
                    //保存失败
                    alert("删除失败")
                }

            }
        });
    }
</script>

</body>
</html>
