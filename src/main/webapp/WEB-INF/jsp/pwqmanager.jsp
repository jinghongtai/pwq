<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>喷雾器管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <%@ include file="common.jsp"%>
    <style>
        .ztreeEdit,#orderForm{
            margin-top: 12px;
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
    <input type="hidden" id="id" name="id" value="">
    <div class="layui-form-item">
        <label class="layui-form-label">喷雾器名称：</label>
        <div class="layui-input-block">
            <input type="text" name="name" id="name"  lay-verify="title" autocomplete="off" placeholder="名称必须T开头范围为01-34" class="layui-input" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">通讯IP地址：</label>
        <div class="layui-input-block">
            <input type="text" name="ip" id="ip" placeholder="请输入通讯IP地址" autocomplete="off" class="layui-input" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投放区域：</label>
        <div class="layui-input-block">
            <select name="modules inputHeight" id="opertypeSelect" lay-verify="required" lay-search="">
                <option value="A">A堆场</option>
                <option value="B">B堆场</option>
                <option value="C">C堆场</option>
                <option value="D">D堆场</option>
                <option value="E">E堆场</option>
                <option value="F">F堆场</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">喷雾器当前方向值：</label>
        <div class="layui-input-block">
            <input type="text" name="currentTurn" id="currentTurn" placeholder="喷雾器当前方向值" autocomplete="off" class="layui-input" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">左限位值：</label>
        <div class="layui-input-block">
            <input type="text" name="leftPosition" id="leftPosition" placeholder="射雾器能到达的最左方向值" autocomplete="off" class="layui-input" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">右限位值：</label>
        <div class="layui-input-block">
            <input type="text" name="rightPosition" id="rightPosition" placeholder="射雾器能到达的最右方向值" autocomplete="off" class="layui-input" value="">
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
            <i class="layui-icon">&#xe608;</i> 添加喷雾器
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
    var form ;

    function resetOrderInfo(){
        $2("#id").val("");
        $2("#orderStr").val("");
        $2("#turn").val("");
    }

    layui.use(['table','layer','form'], function(){
        table = layui.table;
        $2 = layui.$;
        layer = layui.layer;
        form = layui.form;

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
                });
            } else if(obj.event === 'edit'){
                $2("#id").val(data.id);
                $2("#name").val(data.name);
                $2("#ip").val(data.ip);
                $2("#opertypeSelect").val(data.areaId);
                $2("#currentTurn").val(data.currentTurn);
                $2("#leftPosition").val(data.leftPosition);
                $2("#rightPosition").val(data.rightPosition);
                $2("#orderForm").show();
                $2('.ztreeEdit').hide();
                form.render();
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
                var name = $2("#name").val();
                var ip = $2("#ip").val();
                var areaId = $2("#opertypeSelect").val();
                var currentTurn = $2("#currentTurn").val();
                var leftPosition = $2("#leftPosition").val();
                var rightPosition = $2("#rightPosition").val();
                if(!ip){
                    tip("通讯IP地址不能为空",$2("#ip"));
                    return ;
                }
                if(!areaId){
                    tip("投放区域不能为空",$2("#areaId"));
                    return ;
                }
                if(!currentTurn){
                    tip("当前方向值不能为空",$2("#currentTurn"));
                    return ;
                }
                if(!leftPosition){
                    tip("射雾器能到达的最左方向值不能为空",$2("#leftPosition"));
                    return ;
                }
                if(!rightPosition){
                    tip("射雾器能到达的最右方向值不能为空",$2("#rightPosition"));
                    return ;
                }
                $.post("pwqAction/saveOrUpdatePwq",
                        {
                            "id":id,
                            "name":name,
                            "ip":ip,
                            "areaId":areaId,
                            "currentTurn":currentTurn,
                            "leftPosition":leftPosition,
                            "rightPosition":rightPosition

                        },function(res){
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
            ,url:'/pwqAction/queryPwqPage'
            ,toolbar: '#toolbarDemo'
            ,title: '喷雾器管理'
            ,limits:[10,15,20]
            ,height:500
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'name', title:'名称', width:150, fixed: 'left', sort: true}
                ,{field:'ip', title:'ip地址', width:200}
                ,{field:'areaId', title:'投放区域', width:150}
                ,{field:'communication', title:'通讯状态标志', width:150}
                ,{field:'autoMark', title:'自动控制', width:200}
                ,{field:'fjAutoMark', title:'风机状态', width:200}
                ,{field:'pwMark', title:'喷雾状态', width:200}
                ,{field:'fjGzMark', title:'风机故障', width:200}
                ,{field:'pwGzMark', title:'喷雾故障', width:200}
                ,{field:'currentTurn', title:'喷雾器当前方向值', width:200}
                ,{field:'leftPosition', title:'左限位值', width:200}
                ,{field:'rightPosition', title:'右限位值', width:200}
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
            url:"pwqAction/deleteOrderById?",
            data:{"id":id},
            type:"post",
            processData:true,
            dateType:"json",
            success:function(res){
                if(res.result === "success"){
                    //保存成功
                    msg("删除成功")
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
