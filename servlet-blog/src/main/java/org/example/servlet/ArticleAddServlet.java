package org.example.servlet;


import org.example.dao.ArticleDao;
import org.example.model.Article;
import org.example.model.User;
import org.example.util.JSONUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;

@WebServlet("/articleAdd")
public class ArticleAddServlet extends AbstractBaseServlet {
    @Override
    protected Object process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        //请求数据类型是application/json，需要使用输入流获取
        InputStream is = req.getInputStream();
        //反序列化
        Article a = JSONUtil.desrialize(is,Article.class);
        a.setUserid(user.getId());
        int num = ArticleDao.insert(a);
        return null;
    }
}
