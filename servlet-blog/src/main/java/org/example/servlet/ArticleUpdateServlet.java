package org.example.servlet;

import org.example.dao.ArticleDao;
import org.example.model.Article;
import org.example.util.JSONUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author： 浪漫不死
 * @Date： 2020/12/6
 * @description：
 * @version: 1.0
 */

@WebServlet("/articleUpdate")
public class ArticleUpdateServlet extends AbstractBaseServlet {
    @Override
    protected Object process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        InputStream is = req.getInputStream();
        Article a = JSONUtil.desrialize(is,Article.class);
        int num = ArticleDao.update(a);
        return null;
    }
}
