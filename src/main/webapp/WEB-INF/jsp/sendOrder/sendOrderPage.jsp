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
            <div class="layui-form-item">
                <label class="layui-form-label">风机操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="fan" value="0103" title="启动">
                    <input type="radio" name="fan" value="0104" title="停止" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">喷雾操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="spray" value="0105" title="启动">
                    <input type="radio" name="spray" value="0106" title="停止" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">大风策略</label>
                <div class="layui-input-block">
                    <input type="radio" name="gale" value="0107" title="启动">
                    <input type="radio" name="gale" value="0108" title="停止" checked>
                    <input type="radio" name="gale" value="0112" title="方向调整">
                    <div id="dfcn" class="layui-input-block">
                        <select name="city" lay-verify="required">
                            <option value="">请选择方向</option>
                            <option value="0">东</option>
                            <option value="1">西</option>
                            <option value="2">南</option>
                            <option value="3">北</option>
                        </select>
                    </div>
                    <%--<input type="text" id="dfcn" name="title" placeholder="请输入方向" autocomplete="off" class="layui-input">--%>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">摆动操作</label>
                <div class="layui-input-block">
                    <input type="radio" name="swing" value="0110" title="启动">
                    <input type="radio" name="swing" value="0111" title="停止" checked>
                    <input type="radio" name="swing" value="0113" title="方向调整">
                    <div id="bdczfx" class="layui-input-block">
                        <select name="city" lay-verify="required">
                            <option value="">请选择方向</option>
                            <option value="0">东</option>
                            <option value="1">西</option>
                            <option value="2">南</option>
                            <option value="3">北</option>
                        </select>
                    </div>
                    <div id="bdczfw" class="layui-input-block">
                        <select name="city" lay-verify="required">
                            <option value="">请选择摆动范围</option>
                            <option value="0">东</option>
                            <option value="1">西</option>
                            <option value="2">南</option>
                            <option value="3">北</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>

    </div>
    <script src="../static/js/jquery.js" charset="utf-8"></script>
    <script src="../static/layui/layui.js" charset="utf-8"></script>
    <script>
        //Demo
        layui.use('form', function(){
            var form = layui.form;

            //监听提交
            /*form.on('submit(formDemo)', function(data){
                layer.msg(JSON.stringify(data.field));
                return false;
            });*/

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
                    }
                    if(value === '0110' || value === '0111'){
                        $("#bdczfx").css("display","none")
                        $("#bdczfw").css("display","none")
                    }
                }
            });
        });




    </script>
</body>
</html>
