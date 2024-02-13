final class Paddle extends GameObject {
  color fillColor;
  Paddle(Scene scene, Rect rect,color fillColor) {
    super(scene, rect);
    this.fillColor = fillColor;
  }


  void draw() {    
    strokeWeight(1);
    fill(fillColor);
    rect(rect.x, rect.y, rect.w, rect.h);
  }

  void up(Area area){
    if(rect.y > area.rect.y){
      rect.y -= 10;
    }
  }
  void down(Area area){
    if(rect.y + rect.h < area.rect.h+area.rect.y){
      rect.y += 10;
    }
  }
}
