final class MainScene extends Scene {
  Bar player = new Bar(this, 100, 500);
  Bar player2 = new Bar(this, 500, 500);
  Ball ball = new Ball(this, 50, 50);
  MainScene() {
    super("main");
  }

  void draw() {
    if (player.isCollision(ball)) {
      if ((ball.x <= player.x+player.width && ball.velocityVec.x<0) || (ball.x + ball.width >= player.x && ball.velocityVec.x>0)) {
        ball.velocityVec.x*=-1;
      }
    }


    if (keyCode == UP&&keyPressed) {
      player.y-=10;
    } 
    if (keyCode == DOWN&&keyPressed) {
      player.y+=10;
    }
    super.draw();
    text("px:"+player.x+" py:"+player.y,40,450);
  }


  void keyPressed() {
    if(key=='b'){
       var o=new Ball(this, random(500f), random(500f));
       o.setup();
    }
  }
}