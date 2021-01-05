package dao;

import data.DataBase;
import domain.FruitItem;
import tools.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *管理员数据访问类
 */
public class AdminDao {
    //获取所有数据
    public ArrayList<FruitItem> queryAlldata() {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        ArrayList<FruitItem> list  = new ArrayList<>();

        try {
            connection = JDBCUtils.getConnection();
            String sql = "select * from fruit";
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery();

            while (resultSet.next()) {
                String number = resultSet.getString("number");
                String fruitname = resultSet.getString("fruitname");
                Double price = resultSet.getDouble("price");
                String unit = resultSet.getString("unit");

                FruitItem fruitItem = new FruitItem();
                fruitItem.setNumber(number);
                fruitItem.setFruitname(fruitname);
                fruitItem.setPrice(price);
                fruitItem.setUnit(unit);
                list.add(fruitItem);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.close(resultSet,ps,connection);
        }
        return null;
    }
    //添加数据
    public void addFruitItem(FruitItem fruitItem) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = JDBCUtils.getConnection();
            String sql = "insert into fruit(number,fruitname,price,unit)values(?,?,?,?)";
            ps = connection.prepareStatement(sql);
            ps.setString(1,fruitItem.getNumber());
            ps.setString(2,fruitItem.getFruitname());
            ps.setString(3,fruitItem.getPrice()+"");
            ps.setString(4,fruitItem.getUnit());
            int i = ps.executeUpdate();
            if(i > 0) {
                System.out.println("数据插入成功");
            } else {
                System.out.println("数据插入失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.close(connection,ps);
        }
    }
    //删除数据
    public void delFruitItem(String delNumber) {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = JDBCUtils.getConnection();
            String sql = "delete from fruit where number = ?";
            ps = connection.prepareStatement(sql);
            ps.setString(1,delNumber);
            int i = ps.executeUpdate();
            if(i > 0) {
                System.out.println("数据删除成功");
            } else {
                System.out.println("数据删除失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.close(connection,ps);
        }
    }
}
