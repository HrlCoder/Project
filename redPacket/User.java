package cn.redPacket;

/**
 * @author ：浪漫不死
 * @version: 1
 * @description：
 * @date : 2020/8/25 15:30
 */
public class User {
    private String name;    //姓名
    private int money;      //余额

    public User() {
    }

    public User(String name, int money) {
        this.name = name;
        this.money = money;
    }

    public void show() {
        System.out.println("姓名：" + name + ",余额：" +money);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }
}
