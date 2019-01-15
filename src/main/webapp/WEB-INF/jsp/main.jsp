<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <%@include file="common.jsp"%>
    <link rel="stylesheet" href="static/css/layui2.css" />
    <link rel="stylesheet" href="static/css/admin.css" />
    <script type="text/javascript" src="static/common/hm.js"></script>
</head>
<body class="layui-layout-body" layadmin-themealias="default">
<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layadmin-flexible" lay-unselect="">
                    <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                    <a href="http://www.layui.com/admin/" target="_blank" title="前台">
                        <i class="layui-icon layui-icon-website"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect="">
                    <a href="javascript:;" layadmin-event="refresh" title="刷新">
                        <i class="layui-icon layui-icon-refresh-3"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                    <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords=">
                </li>
                <span class="layui-nav-bar" style="left: 30px; top: 48px; width: 0px; opacity: 0;"></span></ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">

                <li class="layui-nav-item" lay-unselect="" style="">
                    <a lay-href="app/message/index.html" layadmin-event="message" lay-text="消息中心">
                        <i class="layui-icon layui-icon-notice"></i>

                        <!-- 如果有新消息，则显示小圆点 -->
                        <span class="layui-badge-dot"></span>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect="" style="">
                    <a href="javascript:;" layadmin-event="theme">
                        <i class="layui-icon layui-icon-theme"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                    <a href="javascript:;" layadmin-event="note">
                        <i class="layui-icon layui-icon-note"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect="" style="">
                    <a href="javascript:;" layadmin-event="fullscreen">
                        <i class="layui-icon layui-icon-screen-full"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect="">
                    <a href="javascript:;">
                        <cite>贤心</cite>
                        <span class="layui-nav-more"></span></a>
                    <dl class="layui-nav-child">
                        <dd><a lay-href="set/user/info.html">基本资料</a></dd>
                        <dd><a lay-href="set/user/password.html">修改密码</a></dd>
                        <hr>
                        <dd layadmin-event="logout" style="text-align: center;"><a>退出</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                    <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
                <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect="">
                    <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
                <span class="layui-nav-bar" style="left: 0px; top: 48px; width: 0px; opacity: 0;"></span></ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu" style="background-color: #3366FF !important;color:#20222A !important;">
            <div class="layui-side-scroll">
                <div class="layui-logo" lay-href="index/resourcemanager">
                    <span>控制菜单</span>
                </div>

                <ul style="height: 100%;overflow: hidden" class="layui-nav-side layui-nav layui-nav-tree layui-bg-molv" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">

                    <c:forEach items="${menuList}" var="menu1">
                        <li data-name="${menu1.id}" class="layui-nav-item" style="">
                            <a <c:if test="${menu1.resourceSet.size() == 0}">lay-href="${menu1.url}"</c:if><c:if test="${menu1.resourceSet.size()>0}">href="javascript:;"</c:if> lay-tips="${menu1.resourceName}" lay-direction="2">
                                    ${menu1.bz}
                                <cite>${menu1.resourceName}</cite>
                                <c:if test="${menu1.resourceSet.size()>0}">
                                    <span class="layui-nav-more"></span>
                                </c:if>
                            </a>
                            <c:if test="${menu1.resourceSet.size()>0}">
                                <dl class="layui-nav-child">
                                    <c:forEach items="${menu1.resourceSet}" var="menu2">
                                        <dd data-name="${menu2.id}">
                                            <a <c:if test="${menu2.resourceSet.size()==0}">lay-href="${menu2.url}" </c:if><c:if test="${menu2.resourceSet.size()>0}">href="javascript:;" </c:if><%--lay-tips="${menu2.resourceName}"--%>>${menu2.resourceName}
                                                <c:if test="${menu2.resourceSet.size()>0}">
                                                    <span class="layui-nav-more"></span>
                                                </c:if>
                                            </a>
                                            <c:if test="${menu2.resourceSet.size()>0}">
                                                <dl class="layui-nav-child">
                                                    <c:forEach items="${menu2.resourceSet}" var="menu3">
                                                        <dd data-name="${menu3.id}">
                                                            <a lay-href="${menu3.url}">${menu3.resourceName}</a>
                                                        </dd>
                                                    </c:forEach>
                                                </dl>
                                            </c:if>

                                        </dd>
                                    </c:forEach>
                                </dl>
                            </c:if>
                        </li>
                    </c:forEach>

                    <span class="layui-nav-bar" style="top: 382.372px; height: 0px; opacity: 0;"></span></ul>
            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect="">
                        <a href="javascript:;"><span class="layui-nav-more"></span></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                        </dl>
                    </li>
                    <span class="layui-nav-bar"></span></ul>
            </div>
            <div class="layui-tab" lay-unauto="" lay-allowclose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="home/console.html" lay-attr="home/console.html" class="" style="">
                        <i class="layui-icon layui-icon-home"></i>
                        <i class="layui-icon layui-unselect layui-tab-close">ဆ</i></li>
                </ul>
            </div>
        </div>


        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="/index/resourcemanager" frameborder="0" class="layadmin-iframe"></iframe>
            </div>
        </div>

        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <%--<div class="layadmin-body-shade" layadmin-event="shade"></div>--%>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>

    layui.use('element', function(){
        var element = layui.element;

    });

    layui.config({
        base: 'static/common/' //静态资源所在路径
    }).extend({
        index: 'index' //主入口模块
    }).use('index');
</script>
</body>
</html>
