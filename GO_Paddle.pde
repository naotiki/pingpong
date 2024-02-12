final class Paddle extends GameObject {

  Paddle(Scene scene, Rect rect) {
    super(scene, rect);
    rect.setSize(10,200);
  }


  void draw() {    
    strokeWeight(1);
    fill(255);
    rect(rect.x, rect.y, rect.w, rect.h);
  }
}
