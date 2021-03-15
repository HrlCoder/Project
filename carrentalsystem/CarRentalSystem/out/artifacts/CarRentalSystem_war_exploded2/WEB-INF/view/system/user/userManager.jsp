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
    <title>用户管理</title>
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
    <form action="/dept/loadAllDept" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">所属部门</label>
                <div class="layui-input-inline">
                    <input type="hidden" name="deptid" id="search_selectDeptTree">
                    <ul id="search_deptTree" class="dtree" data-id="0"></ul>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" id="name"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户地址</label>
                <div class="layui-input-inline">
                    <input type="text" name="address" id="address"  class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item" style="text-align: center">
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
                <button type="reset" class="layui-btn layui-btn-warm" onclick="javascript:document.getElementById('search_selectDeptTree').value=''"><span class="layui-icon layui-icon-refresh"></span>重置</button>

            </div>
        </div>
    </form>
</blockquote>
<!--查询条件结束-->
<!--数据表格开始-->
<div>
    <table class="layui-hide" id="userTable" lay-filter="userTable"></table>
    <div id="userToolBar" style="display: none">
        <button type="button" shiro:hasPermission="user:create" lay-event="add" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
    </div>
    <div id="userRowBar" style="display: none">
        <button type="button" shiro:hasPermission="user:update" lay-event="update" class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>更新</button>
        <button type="button" shiro:hasPermission="user:delete" lay-event="delete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
        <button type="button" shiro:hasPermission="user:resetPwd" lay-event="resetPwd" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-refresh"></span>重置密码</button>
        <button type="button" shiro:hasPermission="user:selectRole" lay-event="selectRole" class="layui-btn layui-btn-sm layui-btn-normal"><span class="layui-icon layui-icon-face-smile-b"></span>分配角色</button>
    </div>
</div>
<!--数据表格结束-->
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="userForm" class="layui-form layui-form-pane" lay-filter="userForm">

        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-inline">
                <input type="hidden" name="deptid" id="deptid" lay-verify="required"/>
                <ul id="deptTree" class="dtree" data-id="0" ></ul>
            </div>
            <label class="layui-form-label">用户排序值</label>
            <div class="layui-input-inline">
                <input type="number" name="ordernum" id="ordernum" lay-verify="ordernum" autocomplete="off" placeholder="请输入用户排序值" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">领导部门</label>
            <div class="layui-input-inline">
                <input type="hidden" name="leardeptid" id="leardeptid"/>
                <ul id="leardeptTree" class="dtree" data-id="0" ></ul>
            </div>
            <label class="layui-form-label">直属领导</label>
            <div class="layui-input-inline">
                <select name="mgr" id="mgr">
                    <option value="0">选择直属领导</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名称</label>
            <div class="layui-input-inline">
                <input type="hidden" name="id"/>
                <input type="text" name="name" id="username" lay-verify="username" autocomplete="off" placeholder="请输入用户名称" class="layui-input">
            </div>
            <label class="layui-form-label">登录名称</label>
            <div class="layui-input-inline">
                <input type="hidden" name="id"/>
                <input type="text" name="loginname" id="loginname" lay-verify="loginname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户地址</label>
            <div class="layui-input-block">
                <input type="text" name="address" lay-verify="address" autocomplete="off" placeholder="请输入用户地址" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户备注</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="remark" lay-verify="remark" id="remark"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <input type="radio" name="sex" value="1" title="男" checked="">
                <input type="radio" name="sex" value="0" title="女">
            </div>
            <label class="layui-form-label">是否可用</label>
            <div class="layui-input-inline">
                <input type="radio" name="available" value="1" title="可用" checked="">
                <input type="radio" name="available" value="0" title="不可用">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block"  style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-filter="doSubmit" lay-submit=""><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<!--分配用户角色弹出层 开始-->
<div id="selectUserRoleDiv" style="display: none;padding: 5px;">
    <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
</div>
<!--分配用户角色弹出层 结束-->
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript" src="/resources/layui_ext/dtree/dtree.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree: '/resources/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['jquery','form','table','layer','dtree'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var dtree = layui.dtree;

        //表格数据渲染
        var tableIns=table.render({
            elem: '#userTable'
            ,url:'/user/loadAllUser'
            ,toolbar: '#userToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
                {field:'id', title:'ID',align: 'center',width:'80'}
                ,{field:'deptName', title:'所属部门',align: 'center',width:'100'}
                ,{field:'name', title:'用户名称',align: 'center',width:'100'}
                ,{field:'remark', title:'用户备注',align: 'center',width:'150'}
                ,{field:'address', title:'用户地址',align: 'center',width:'150'}
                ,{field:'leaderName', title:'直属领导',align: 'center',width:'150'}
                ,{field:'available', title:'是否可用',align: 'center',width:'100',templet: function(d){
                        return d.available==1?'<font style="color:blue">可用</font>':'<font style="color:red">不可用</font>';
                    }}
                ,{field:'sex', title:'性别',align: 'center',width:'100',templet: function(d){
                        return d.sex==1?'<font style="color:blue">男</font>':'<font style="color:red">女</font>';
                    }}
                ,{field:'ordernum', title:'排序',align: 'center',width:'80'}
                ,{field:'hiredate', title:'创建时间',align: 'center',width:'200'}
                ,{fixed: 'right', title:'操作', toolbar: '#userRowBar',align: 'center',width:'400'}
            ] ]
            ,done: function(res, curr, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);
                //得到当前页码
                console.log(curr);
                //得到数据总量
                console.log(count);
                //当删除数据表格最后一页的最后一条数据时 渲染上一页的数据
                if(res.data.length==0&&curr!=1){
                    tableIns.reload({
                        page:{
                            curr:(curr-1)
                        }
                    })
                }
            }
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
        table.on("toolbar(userTable)",function(obj){

            switch(obj.event){
                case 'add':
                    addUserLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(userTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    console.log(data);
                    updateUserLayer(data);
                    break;
                case 'delete':
                    deleteUserLayer(data);
                    break;
                case 'resetPwd':
                    resetPwdUserLayer(data);
                    break;
                case 'selectRole':
                    selectRoleUserLayer(data);
                    break;
            }
        });
        //初始化父级用户的下拉选项
        var deptTreeSelect=dtree.renderSelect({
            elem: "#deptTree",
            width: "100%", // 可以在这里指定树的宽度来填满div
            url: "/dept/loadDeptMenuDtreeJson",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0} //修改response中返回数据的定义
        });
        dtree.on("node('deptTree')" ,function(obj){
            $("#deptid").val(obj.param.nodeId);

            //layer.msg(JSON.stringify(obj.param.nodeId));
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addUserLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'添加用户',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#userForm')[0].reset();
                    $('#deptid').val("");
                    //设置用户的值
                    $.get("/user/getUserMaxOrderNum",function (res) {
                       $("#ordernum").val(res.value);
                    });
                    url='/user/addUser';
                    //重置为空
                    var html=null;
                    html+="<option value='0'>请选择直属领导</option>";
                    $("#mgr").html(html);
                    form.render("select");
                }
            });
        }
        //修改弹出层设置
        function updateUserLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改用户',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#userForm')[0].reset();

                    //表单加载数据
                    form.val('userForm',data);
                    dtree.dataInit("deptTree", data.deptid);

                    // 也可以在这里指定，第二个参数如果不填，则会自动返显当前选中的数据
                    dtree.setSelectValue("deptTree");
                    $.get("/user/getLearDeptNameAndName",{learId:data.mgr},function (res) {
                        var d=res.data;
                        //判断有无直属领导
                        if(d!=null) {
                            dtree.dataInit("leardeptTree", d.deptid);
                            // 也可以在这里指定，第二个参数如果不填，则会自动返显当前选中的数据
                            dtree.setSelectValue("leardeptTree");
                            var html = "";
                            html += "<option value='" + d.id + "'>" + d.name + "</option>"
                            $("#mgr").html(html);
                            form.render("select");
                        }
                    });

                    url='/user/updateUser'
                }
            });
        }
        //监听提交
        form.on("submit(doSubmit)",function (data) {
             //alert(data.field);
             // console.log(data.field);
            $.post(url,data.field,function (res) {
                if(res.code==200){
                    tableIns.reload();
                    //选择的下拉框
                    deptTreeSelect.reload();
                    //刷新左侧的菜单树
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
            return false;
        });
        //删除用户
        function deleteUserLayer(data) {
            layer.confirm('你确定要删除【'+data.name+'】这个用户吗？', {icon: 3, title:'提示'}, function(index){
                $.post("/user/deleteUser",{id:data.id},function(res){
                    if(res.code==200){
                        //重新刷新表格
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });

                layer.close(index);
            });
        }
        //重置密码
        function resetPwdUserLayer(data){
            layer.confirm('你确定要重置【'+data.name+'】这个用户的密码吗？', {icon: 3, title:'提示'}, function(index){
                $.post("/user/resetPwdUser",{id:data.id},function(res){
                    if(res.code==200){
                        //重新刷新表格
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });

                layer.close(index);
            });
        }
        //渲染查询条件的下拉部门树
        search_deptTree = dtree.renderSelect({
            elem: "#search_deptTree",
            url: "/dept/loadDeptMenuDtreeJson",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
            checkbar:false //开启复选框
        });

        // 绑定节点点击
        dtree.on("node('search_deptTree')" ,function(obj){
            //将部门号赋值
            $('#search_selectDeptTree').val(obj.param.nodeId);
            //console.log(obj.param.nodeId);
            // layer.msg(JSON.stringify(obj.param.nodeId));
        });
        //添加弹出层领导所属部门
        leardeptTree=dtree.renderSelect({
            elem: "#leardeptTree",
            url: "/dept/loadDeptMenuDtreeJson",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
            checkbar:false //开启复选框
        });
        // 绑定节点点击
        dtree.on("node('leardeptTree')" ,function(obj){
            // $('#leardeptid').val(obj.param.nodeId);
            var learDeptId=obj.param.nodeId;
            var deptLear=null;
            var html="";
            var dom_mgr=$("#mgr");
            html+="<option value='0'>请选择直属领导</option>";
            // alert(obj.param.nodeId);
            //发送请求通过部门ID从后台获取所有关于部门的领导名字
            $.get("/user/allDeptLearName",{learDeptId:learDeptId},function (res) {
                deptLear=res.data;
                // console.log(res.data);
                //动态添加html元素
                $.each(deptLear,function (index,item) {
                    html+="<option value='"+item.id+"'>"+item.name+"</option>";
                });
                dom_mgr.html(html);
                //更新渲染
                form.render("select");
            });

        });

        //当用户名失去焦点时调用发送请求到后台去返回登录名称
        $("#username").on("blur",function () {
            var username=$(this).val();
            $.get("/user/usernameChineseToPinYin",{username:username},function (res) {
                $("#loginname").val(res.value);
            })
        });
        //分配角色弹出层
        function selectRoleUserLayer(data){
            layer.open({
                type: 1,
                title:'分配这个【'+data.name+'】用户的角色',
                content: $('#selectUserRoleDiv'),
                area:['800px','600px']
                ,btnAlign: 'c' //弹出层按钮为中间
                ,btn: ['确认分配', '关闭窗口']
                ,yes: function(index, layero){
                    var checkStatus = table.checkStatus('roleTable'); //idTest 即为基础参数 id 对应的值
                    var params="uid="+data.id;
                    $.each(checkStatus.data,function (index,item) {
                        params+='&ids='+item.id;
                    });
                    // alert(params);
                    $.post("/user/saveSelectRole",params,function (res) {
                        layer.msg(res.msg);
                    })
                }
                ,btn2: function(index, layero){
                    //return false 开启该代码可禁止点击该按钮关闭
                }
                ,success: function () {
                    RoleTableInit(data);
                    // $.get("/user/userRoleTableInit",{id:9},function (res) {
                    //     console.log(res.data);
                    // })
                }
            });
        }

        //渲染分配角色表格
        var roleTableIns;
        function RoleTableInit(data) {
            roleTableIns=table.render({
                elem: '#roleTable'
                ,url:'/user/userRoleTableInit'
                ,where:{
                    id:data.id
                }
                ,cols: [ [
                    {type:'checkbox',align: 'center'}
                    ,{field:'id', title:'ID',align: 'center'}
                    ,{field:'name', title:'角色名称',align: 'center'}
                    ,{field:'remark', title:'角色备注',align: 'center'}
                ] ]
            });
        }
    });

    function tableFlush(id) {
        // alert(id);
        tableIns.reload({
            where:{
                id:id
            },
            page:{
                curr:1
            }
        });
    }

</script>
</body>
</html>