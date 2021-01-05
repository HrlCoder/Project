package domain;

/**
 * 水果项数据模型
 */
public class FruitItem {
    private String number;
    private String fruitname;
    private double price;
    private String unit;

    public FruitItem() {

    }

    public FruitItem(String number, String fruitname, double price, String unit) {
        this.number = number;
        this.fruitname = fruitname;
        this.price = price;
        this.unit = unit;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getFruitname() {
        return fruitname;
    }

    public void setFruitname(String fruitname) {
        this.fruitname = fruitname;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
