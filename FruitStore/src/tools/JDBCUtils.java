package tools;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 工具类
 */
public class JDBCUtils {
    private static final String URL = "jdbc:mysql://localhost:3306/jdbc?" +
            "user=root&password=root&useUnicode=true&characterEncoding=UTF-8&useSSL=false";
    private static final DataSource DS = new MysqlDataSource();

    static {
        ((MysqlDataSource)DS).setUrl(URL);
    }

    public static Connection getConnection() {
        try {
            return DS.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("获取数据库连接失败");
        }
    }

    public static void close(Connection c, Statement s) {
        close(null,s,c);
    }
    public static void close( ResultSet r,Statement s, Connection c) {
        try {
            if(r != null)
                r.close();
            if(s != null)
                s.close();
            if(c != null)
                c.close();
        } catch (SQLException e) {
            throw new RuntimeException("数据库释放资源出错");
        }
    }

}
