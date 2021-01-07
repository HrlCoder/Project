package cn.redPacket;

import java.util.ArrayList;

/**
 * @author ：浪漫不死
 * @version: 1
 * @description：
 * @date : 2020/8/25 15:32
 */
public class MainRedPacket {

    public static void main(String[] args) {
        Manager manager = new Manager("郭贼",100);
        Member member1 = new Member("飞贼",0);
        Member member2 = new Member("胖贼",0);
        Member member3 = new Member("黄贼",0);

        manager.show();
        member1.show();
        member2.show();
        member3.show();
        System.out.println("==============");

        ArrayList<Integer> list = manager.send(100, 3);
        member1.receive(list);
        member2.receive(list);
        member3.receive(list);

        manager.show();
        member1.show();
        member2.show();
        member3.show();
    }



}
