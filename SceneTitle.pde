final class TitleScene extends Scene {
  Bar player = new Bar(this, 100, 500);
  Bar player2 = new Bar(this, 500, 500);
  Ball ball = new Ball(this, 50, 50);
  TitleScene() {
    super("title");
  }
  
  void draw(){
    println(ball.isCollision(player));
    if (keyPressed&&keyCode == UP) {
      player.y-=10;
    }
    if (keyPressed&&keyCode == DOWN) {
      player.y+=10;
    }
    super.draw();
    
  }


  void keyPressed() {
    
  }
}
