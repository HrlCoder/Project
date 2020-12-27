package org.example.servlet;

import org.example.dao.ArticleDao;
import org.example.model.Article;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author： 浪漫不死
 * @Date： 2020/12/6
 * @description：
 * @version: 1.0
 */

@WebServlet("/articleDetail")
public class ArticleDetailServlet extends AbstractBaseServlet{
    @Override
    protected Object process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String id = req.getParameter("id");
        Article a = ArticleDao.query(Integer.parseInt(id));
        return a;
    }
}
