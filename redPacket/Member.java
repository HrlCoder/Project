package cn.redPacket;

import java.util.ArrayList;
import java.util.Random;

/**
 * @author ：浪漫不死
 * @version: 1
 * @description：
 * @date : 2020/8/25 15:31
 */
public class Member extends User {
    public Member() {
    }

    public Member(String name, int money) {
        super(name, money);
    }

    public void receive(ArrayList<Integer> list) {
        //抽红包，随机获取一个索引编号
        int index = new Random().nextInt(list.size());
        int delta = list.remove(index);
        int money = super.getMoney();
        super.setMoney(delta + money);
    }
}
