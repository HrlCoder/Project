import org.example.util.DBUtil;
import org.junit.Assert;
import org.junit.Test;

import java.sql.Connection;

public class DBUtilTest {
    @Test
    public void getConnection() {
        Connection c = DBUtil.getConnection();
        System.out.println(c);
        Assert.assertNotNull(c);
    }
}
