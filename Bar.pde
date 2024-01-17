final class Bar extends GameObject {

  Bar(Scene scene, float x, float y) {
    super(scene, x, y, 5, 100);
  }


  void draw() {    
    strokeWeight(1);
    fill(255);
    rect(x, y, width, height);
  }
}
