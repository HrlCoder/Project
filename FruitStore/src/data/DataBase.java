package data;

import domain.FruitItem;

import java.util.ArrayList;

public class DataBase {
    public static ArrayList<FruitItem> data = new ArrayList<>();
    static {
        data.add(new FruitItem("1","苹果",5.0,"kg"));
    }
}
