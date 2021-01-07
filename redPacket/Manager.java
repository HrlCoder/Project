package cn.redPacket;

import java.util.ArrayList;

/**
 * @author ：浪漫不死
 * @version: 1
 * @description：
 * @date : 2020/8/25 15:30
 */
public class Manager extends User {
    public Manager() {
    }

    public Manager(String name, int money) {
        super(name, money);
    }

    public ArrayList<Integer> send(int totalMoney,int count) {
        //创建一个集合，存储红包
        ArrayList<Integer> redList = new ArrayList<>();

        //查看发红包人当前金额
        int nowMoney = super.getMoney();
        //判断发送金额是否超出当前金额
        if(totalMoney > nowMoney) {
            System.out.println("余额不足！");
            return redList; //返回空的集合
        }

        //发红包，就是重置金额
        super.setMoney(nowMoney - totalMoney);

        //往红包里面放钱
        int avg = totalMoney / count;
        int mod = totalMoney % count;   //均分后没除完的零头

        for (int i = 0; i < count; i++) {
            redList.add(avg);
        }

        int last = avg + mod;
        redList.add(last);
        return redList;
    }
}
