final class Paddle extends GameObject {
  color fillColor;
  Paddle(IGameObjectTree scene, Rect rect, color fillColor) {
    super(scene, rect);
    this.fillColor = fillColor;
  }


  void draw() {
    strokeWeight(1);
    fill(fillColor);
    rect(rect.x, rect.y, rect.w, rect.h);
  }

  void up(Area area) {
    if (rect.y > area.rect.y) {
      rect.y -= 10*UNIT;
    }
  }
  void down(Area area) {
    if (rect.bottom() < area.rect.bottom()) {
      rect.y += 10*UNIT;
    }
  }
}
