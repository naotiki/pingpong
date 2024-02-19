final class Area extends Pointerble {
  color bgColor;

  Area(GameObjectTree parent, Rect rect, Scene scene, color bgColor) {
    super(parent, rect, scene);
    this.bgColor = bgColor;
  }
  Area(Scene scene, Rect rect, color bgColor) {
    this(scene, rect, scene, bgColor);
  }
  void draw() {
    if(bgColor==NO_COLOR){
      noFill();
    } else{
      fill(bgColor);
    }
    rect(rect.x, rect.y, rect.w, rect.h);
  }

  Rect posByAnchor(Rect rect, Anchor anchor) {
    return this.rect.posByAnchor(rect, anchor);
  }
  float centerX() {
    return rect.centerX();
  }
  float centerY() {
    return rect.centerY();
  }
}
