static enum ItemType {
  AddBall("item_addball.png"),
    Expand("item_expand.png"),
    Wall("item_wall.png");

  ItemType(String imageName) {
    this.imageName = imageName;
  }
  String imageName;
  static ItemType randomType() {
    return values()[(int) (Math.random() * (values().length))];
  }
}

class Item extends GameObject {
  ItemType type;
  Item(GameObjectTree parent, Rect rect, ItemType type) {
    super(parent, rect);
    this.type = type;
  }
  PImage img;
  void setup() {
    img = loadImage(type.imageName);
  }
  void draw() {
    stroke(#dddddd);
    strokeWeight(4);
    image(img, rect.x, rect.y, rect.w, rect.h);
  }
}
