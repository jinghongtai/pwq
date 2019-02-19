<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="../static/css/layui2.css" />
    <link rel="stylesheet" href="../static/css/admin.css" />
    <link rel="stylesheet" href="../static/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="../static/common/hm.js"></script>
    <style>
        #dfcn,#bdczfx,#bdczfw{
            margin-left:5px;
            margin-right:50px;
        }
        #dfcn{
            display: none;
        }
        #bdczfx,#bdczfw {
            display: none;
        }
    </style>
</head>
<body>
    <div>
        <form class="layui-form" action="">
            <input type="hidden" id="id" name="id" value="${data.id}">
            <input type="hidden" id="areaId" name="areaId" value="${data.areaId}">
            <input type="hidden" id="orderNo" name="orderNo" value="${data.orderNo}">
            <div class="layui-form-item">
                <label class="layui-form-label">风机操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="fanOperation" value="0103" title="启动" <c:if test="${data.fanOperation =='0103'}">checked</c:if> >
                    <input type="radio" name="fanOperation" value="0104" title="停止" <c:if test="${data.fanOperation =='0104' || data.fanOperation  == null ||data.fanOperation  == '' }">checked</c:if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">喷雾操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="sprayOperation" value="0105" title="启动" <c:if test="${data.sprayOperation =='0105'}">checked</c:if>>
                    <input type="radio" name="sprayOperation" value="0106" title="停止" <c:if test="${data.sprayOperation =='0106' || data.sprayOperation  == null ||data.sprayOperation  == '' }">checked</c:if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">大风策略</label>
                <div class="layui-input-block">
                    <input type="radio" name="galeStrategy" value="0107" title="启动" <c:if test="${data.galeStrategy =='0107'}">checked</c:if>>
                    <input type="radio" name="galeStrategy" value="0108" title="停止" <c:if test="${data.galeStrategy =='0108' || data.galeStrategy  == null ||data.galeStrategy  == '' }">checked</c:if> >
                    <input type="radio" name="galeStrategy" value="0112" title="方向调整" <c:if test="${data.galeStrategy =='0112'}">checked</c:if>>
                    <div id="dfcn" class="layui-input-block" <c:if test="${data.galeStrategy =='0112'}">style="display: block" </c:if>>
                        <select name="galeclFx" id="galeclFx">
                            <option value="">请选择方向</option>
                            <option value="0" <c:if test="${data.galeclFx =='0'}">selected="selected"</c:if>>东</option>
                            <option value="1" <c:if test="${data.galeclFx =='1'}">selected="selected"</c:if>>西</option>
                            <option value="2" <c:if test="${data.galeclFx =='2'}">selected="selected"</c:if>>南</option>
                            <option value="3" <c:if test="${data.galeclFx =='3'}">selected="selected"</c:if>>北</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">摆动操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="swingOperation" value="0110" title="启动" <c:if test="${data.swingOperation =='0110'}">checked</c:if>>
                    <input type="radio" name="swingOperation" value="0111" title="停止" <c:if test="${data.swingOperation =='0111' || data.swingOperation  == null ||data.swingOperation  == '' }">checked</c:if>>
                    <input type="radio" name="swingOperation" value="0113" title="方向调整" <c:if test="${data.swingOperation =='0113'}">checked</c:if>>
                   <%-- <div id="bdczfx" class="layui-input-block">
                        <select name="city" >
                            <option value="">请选择方向</option>
                            <option value="0">东</option>
                            <option value="1">西</option>
                            <option value="2">南</option>
                            <option value="3">北</option>
                        </select>
                    </div>--%>
                    <div id="bdczfw" class="layui-input-block" <c:if test="${data.swingOperation =='0113'}">style="display: block" </c:if>>
                        <select name="swingFd" id="swingFd">
                            <option value="">请选择摆动范围</option>
                            <option value="0" <c:if test="${data.swingFd =='0'}">selected="selected"</c:if> >0</option>
                            <option value="90" <c:if test="${data.swingFd =='90'}">selected="selected"</c:if> >90</option>
                            <option value="180" <c:if test="${data.swingFd =='180'}">selected="selected"</c:if> >180</option>
                            <option value="270" <c:if test="${data.swingFd =='270'}">selected="selected"</c:if>>270</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">发送指令</button>
                    <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
                </div>
            </div>
        </form>

    </div>
    <script src="../static/js/jquery.js" charset="utf-8"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <script>
        //Demo
        var layer ;
        layui.use(['form','layer'], function(){
            var form = layui.form;
            layer = layui.layer;

            //监听提交
            form.on('submit(formDemo)', function(data){
                var subdata = data.field;

                $.ajax({
                    url:"/sendOrder/saveOrUpdateSendOrder?",
                    data:subdata,
                    type:"post",
                    processData:true,
                    dateType:"json",
                    success:function(res){
                        if(res.status === "success"){
                            //保存成功
                            //layer.msg("保存成功！");
                            msg("保存成功");
                            var index = parent.layer.getFrameIndex(window.name);
                            setTimeout(function(){
                                parent.layer.close(index);
                            },2000);

                        }else{
                            //保存失败
                            msg("保存失败");
                        }

                    }
                });

                return false;
            });

            form.on('radio()', function(data){
                var value = $(data.elem).val();
                if(value === '0112' || value === '0113'){
                    //显示
                    if(value === '0112'){
                        $("#dfcn").css("display","block")

                    }else{
                        $("#bdczfx").css("display","block")
                        $("#bdczfw").css("display","block")

                    }

                }else{
                    //隐藏
                    if(value === '0107' || value === '0108'){
                        $("#dfcn").css("display","none")
                        $("#galeclFx").val("");

                    }
                    if(value === '0110' || value === '0111'){
                        $("#bdczfx").css("display","none")
                        $("#bdczfw").css("display","none")
                        $("#swingFd").val("");
                    }
                }
            });
        });


        function msg(content){
            layer.msg(content, {
                time: 2000
            });
        }

    </script>
</body>
</html>
