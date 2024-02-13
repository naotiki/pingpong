final class Paddle extends GameObject {
  color fillColor;
  Paddle(Scene scene, Rect rect,color fillColor) {
    super(scene, rect);
    rect.setSize(10,200);
    this.fillColor = fillColor;
  }


  void draw() {    
    strokeWeight(1);
    fill(fillColor);
    rect(rect.x, rect.y, rect.w, rect.h);
  }

  void up(){
    if(rect.y > 0){
      rect.y -= 10;
    }
  }
  void down(){
    if(rect.y + rect.h < screen.height){
      rect.y += 10;
    }
  }
}
