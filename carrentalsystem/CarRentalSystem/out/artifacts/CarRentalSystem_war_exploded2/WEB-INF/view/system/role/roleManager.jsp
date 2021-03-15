<%--
Created by IntelliJ IDEA.
User: ASUS
Date: 2020/1/30
Time: 16:41
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:shiro="http://www.pollix.at/thymeleaf/shiro">
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="/resources/favicon.ico">
    <link rel="stylesheet" href="/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/resources/css/public.css" media="all" />
    <link rel="stylesheet" href="/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="/resources/layui_ext/dtree/font/dtreefont.css">
</head>
<body class="childrenBody">
<!--查询条件开始-->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form action="/role/loadAllRole" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">角色名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" id="name"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">角色备注</label>
                <div class="layui-input-inline">
                    <input type="text" name="remark" id="remark"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">是否可用</label>
                <div class="layui-input-inline">
                    <input type="radio" name="available" value="1" title="可用">
                    <input type="radio" name="available" value="0" title="不可用">
                </div>
            </div>
        </div>

        <div class="layui-form-item" style="text-align: center">
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>

            </div>
        </div>
    </form>
</blockquote>
<!--查询条件结束-->
<!--数据表格开始-->
<div>
    <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
    <div id="roleToolBar" style="display: none">
        <button type="button" lay-event="add" shiro:hasPermission="role:create" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
    </div>
    <div id="roleRowBar" style="display: none">
        <button type="button" lay-event="update" shiro:hasPermission="role:update" class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>修改</button>
        <button type="button" lay-event="delete" shiro:hasPermission="role:delete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
        <button type="button" lay-event="selectPermission" shiro:hasPermission="role:selectPermission" class="layui-btn layui-btn-sm layui-btn-normal"><span class="layui-icon layui-icon-about"></span>分配权限</button>
    </div>
</div>
<!--数据表格结束-->
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="roleForm" class="layui-form layui-form-pane" lay-filter="roleForm">
        <div class="layui-form-item">
            <input type="hidden" name="id"/>
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" lay-verify="name" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色备注</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="remark" lay-verify="remark"></textarea>
            </div>
        </div>
        <div class="layui-item">
            <label class="layui-form-label">是否可用</label>
            <div class="layui-input-block">
                <input type="radio" name="available" value="1" title="可用" checked="">
                <input type="radio" name="available" value="0" title="不可用">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-filter="doSubmit" lay-submit=""><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<!--分配权限的页面开始-->
<div style="display: none" id="selectPermissionDiv">
    <ul id="selectPermissionTree" class="dtree" data-id="0"></ul>
</div>
<!--分配权限的页面结束-->
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript" src="/resources/layui_ext/dtree/dtree.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree: '/resources/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['jquery','form','table','layer'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var dtree=layui.dtree;
        //表格数据渲染
        var tableIns=table.render({
            elem: '#roleTable'
            ,url:'/role/loadAllRole'
            ,toolbar: '#roleToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '角色权限表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
               {field:'id', title:'ID',align: 'center'}
                ,{field:'name', title:'角色名称',align: 'center'}
                ,{field:'remark', title:'角色备注',align: 'center'}
                ,{field:'createtime', title:'创建时间',align: 'center'}
                ,{field:'available', title:'是否可用',align: 'center',templet: function(d){
                        return d.available==1?'<font style="color:blue">可用</font>':'<font style="color:red">不可用</font>';
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#roleRowBar',align: 'center',width:300}
            ] ]
        });
        //模糊查询
        form.on("submit(doSearch)",function (data) {
            tableIns.reload({
                where: data.field
                ,page: {
                    curr: 1
                }
            });
            return false;
        });
        //头工具事件
        table.on("toolbar(roleTable)",function(obj){

            switch(obj.event){
                case 'batchDelete':
                    batchDelete();
                    break;
                case 'add':
                    addRoleLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(roleTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateRoleLayer(data);
                    break;
                case 'delete':
                    deleteRole(data);
                    break;
                case 'selectPermission':
                    selectPermissionRoleLayer(data);
                    break;
            }
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addRoleLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'添加角色',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#roleForm')[0].reset();
                    url='/role/addRole'
                }
            });
        }
        //修改弹出层设置
        function updateRoleLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改角色',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#roleForm')[0].reset();
                    //表单加载数据
                    form.val('roleForm',data);
                    url='/role/updateRole'
                }
            });
        }
        //监听提交
        form.on("submit(doSubmit)",function (data) {
            $.post(url,data.field,function (res) {
                if(res.code==200){
                    tableIns.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
        });
        //删除函数
        function deleteRole(data) {
            layer.confirm('你确定要删除【'+data.name+'】这条角色·吗？', {icon: 3, title:'提示'}, function(index){
                $.post("/role/deleteRole",{id:data.id},function(res){
                    if(res.code==200){
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });
                layer.close(index);
            });
        }
        //分配权限
        function selectPermissionRoleLayer(data){
            mainIndex=layer.open({
                type: 1,
                title:'分配这个【'+data.name+'】角色的权限',
                content: $('#selectPermissionDiv'),
                area:['400px','600px']
                ,btnAlign: 'c' //弹出层按钮为中间
                ,btn: ['确认分配', '关闭窗口']
                ,yes: function(index, layero){
                    var selectPermissionRole = dtree.getCheckbarNodesParam("selectPermissionTree");
                    var params="rid="+data.id;
                    $.each(selectPermissionRole,function (index,item) {
                        params+='&ids='+item.nodeId;
                    });
                    $.post("/role/saveSelectPermission",params,function (res) {
                        layer.msg(res.msg);
                    })
                }
                ,btn2: function(index, layero){
                //return false 开启该代码可禁止点击该按钮关闭
                }
                ,success: function () {
                    dtree.render({
                        elem: "#selectPermissionTree",
                        width: "100%", // 可以在这里指定树的宽度来填满div
                        url: "/role/queryRolePermission?roleId="+data.id,
                        dataStyle: "layuiStyle",  //使用layui风格的数据格式
                        dataFormat: "list",  //配置data的风格为list
                        response:{message:"msg",statusCode:0}, //修改response中返回数据的定义
                        checkbar: true,
                        checkbarType: "all" // 默认就是all，其他的值为： no-all  p-casc   self  only
                    });
                }
            });

        }
    })
</script>
</body>
</html>