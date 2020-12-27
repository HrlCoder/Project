package org.example.servlet;

import org.example.util.MyActionEnter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

/**
 * ueditor富文本编辑器图片上传
 * 1. 修改idea中Tomcat配置的应用上下文路径，Maven中的finalName
 * 2. 修改webapp/static/ueditor.config.js,33行修改
 *      (应用上下文路径+服务路径)
 * 实现后端接口
 */
@WebServlet("/ueditor")
public class UEditorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        URL url = UEditorServlet.class.getClassLoader().getResource("config.json");
        String path = URLDecoder.decode(url.getPath(),"UTF-8");
        MyActionEnter enter = new MyActionEnter(req,path);
        String exec = enter.exec();
        PrintWriter pw = resp.getWriter();
        pw.println(exec);
        pw.flush();
        pw.close();
    }
}
