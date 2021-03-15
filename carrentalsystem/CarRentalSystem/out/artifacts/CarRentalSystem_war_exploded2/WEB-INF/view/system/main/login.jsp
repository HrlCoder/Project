<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2020/1/30
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
</head>
<body class="loginBody">
<form class="layui-form">
    <div class="login_face"><img src="${ctx}/resources/images/userface3.jpg" class="userAvatar"></div>
    <div class="layui-form-item input-item">
        <label for="userName">用户名</label>
        <input type="text" placeholder="请输入用户名" autocomplete="off" id="userName" name="loginname" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input type="password" placeholder="请输入密码" autocomplete="off" id="password" name="pwd" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item" id="imgCode">
        <label for="code">验证码</label>
        <input type="text" placeholder="请输入验证码" value="" autocomplete="off" id="code" class="layui-input">
        <img src="${ctx}/resources/images/code.jpg">
    </div>
    <div class="layui-form-item">
        <button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
    </div>
    <div class="layui-form-item layui-row">
<%--        <a href="javascript:;" class="seraph icon-qq layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>--%>
<%--        <a href="javascript:;" class="seraph icon-wechat layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>--%>
<%--        <a href="javascript:;" class="seraph icon-sina layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>--%>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form','layer','jquery'],function(){
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer
        $ = layui.jquery;

        $(".loginBody .seraph").click(function(){
            layer.msg("这只是做个样式，至于功能，你见过哪个后台能这样登录的？还是老老实实的找管理员去注册吧",{
                time:5000
            });
        })

        //登录按钮
        //登录按钮
        form.on("submit(login)",function(data){
            console.log(data.field);
            var btn =  $(this);
            //设置登录按钮  为不可点击
            btn.text("登录中...").attr("disabled","disabled").addClass("layui-disabled");
            $.post("/login/login",data.field,function(rs){
                //设置登录按钮 恢复可点击   在前端防止 重复点击
                btn.text("登录").attr("disabled",false).removeClass("layui-disabled");
                layer.msg(rs.msg);
                if(rs.code != 200){
                    layer.msg(rs.msg);
                }else{
                    //跳转到templates/system/index/index.html页面
                    layer.msg(rs.msg);
                    location.href="/sys/toIndex";
                }
            });
            return false;
        });

        //表单输入效果
        $(".loginBody .input-item").click(function(e){
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        })
        $(".loginBody .layui-form-item .layui-input").focus(function(){
            $(this).parent().addClass("layui-input-focus");
        })
        $(".loginBody .layui-form-item .layui-input").blur(function(){
            $(this).parent().removeClass("layui-input-focus");
            if($(this).val() != ''){
                $(this).parent().addClass("layui-input-active");
            }else{
                $(this).parent().removeClass("layui-input-active");
            }
        })
    })

</script>
<script type="text/javascript" src="${ctx}/resources/js/cache.js"></script>
</body>
</html>
