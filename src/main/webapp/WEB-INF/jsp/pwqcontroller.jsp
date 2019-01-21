<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>人员管理</title>
    <%@include file="common.jsp"%>
</head>
<style>
    .ztreeEdit{
        margin-top: 2px;
    }
    .inputHeight{
        line-height:25px;
        height:25px;
    }
</style>
<body>
<body>
<div class="main_top">

</div>

<div class="ztreeEdit layui-fluid">
    <div style="float: left;width: 99.9%;height:200px;border: 1px #8D8D8D solid">
        <hr class="layui-bg-red" style="height: 2px;width:60%">
        <div style="text-align: center;vertical-align: middle;line-height:100%;height:10px;width:60%">门机轨道</div>
        <hr class="layui-bg-red"  style="height: 2px;width:60%">
    </div>
    <div style="float: left;width: 20%;height:400px;border: 1px #3F3F3F solid">

    </div>
    <div style="float: right;width: 20%;height:400px;border: 1px #3F3F3F solid">

    </div>


</div>

<div id="updateOrInsert" style="font-size:14px;margin-left:60px;display: none;margin-top: 30px;">
    <div class="layui-form">
        <input type="hidden" id="UID" name="id" hidden>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" name="username" id="xgname" value="" disabled="disabled" style="background-color:#ccc;" placeholder="请输入用户名"
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


</body>
</html>
