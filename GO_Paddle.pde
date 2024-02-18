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

  void up(Rect area) {
    if (rect.y > area.y) {
      rect.y -= 10*UNIT;
    }
     yPosWithin(area);
  }
  void down(Rect area) {
    if (rect.bottom() < area.bottom()) {
      rect.y += 10*UNIT;
    }
    yPosWithin(area);
  }

  void yPosWithin(Rect area){
    rect.y = rect.y < area.y ? area.y : rect.bottom() > area.bottom() ? area.bottom()-rect.h : rect.y; 
  }
}
