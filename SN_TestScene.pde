/*
final class TestScene extends Scene {
  final Area gameArea = new Area(this, new Rect(0, 0, screen.getWidth(), screen.getHeight()), #000000);
  final NewBall ball = new NewBall(gameArea, BallSize.pos(gameArea.centerX()-150, gameArea.centerY()-70), gameArea);
  final Wall wall = new Wall(gameArea, BallSize.pos(gameArea.centerX(), gameArea.centerY()-50), radians(60), 500);
  final Button menuButton = new Button(gameArea, gameArea.posByAnchor(new Rect(0, 25, 150, 50), Anchor.TopCenter), this, "Reload");
  void sceneSetup() {
    PVector point = ball.rect.vertex()[0];
    PVector vec=calcCollisionPoint(point, ball.velocity, wall.rect.getPosVec(), wall.vec);
    println(vec);
    menuButton.setOnClickListener(()-> {
      sceneManager.changeOneshot(new TestScene());
    }
    );
  }
  void sceneUpdate() {
    wall.vec.rotate(radians(0.1));
    Integer nearestIndex = null;
    PVector targetPoint = null;
    Float nearestDistanse = null;
    PVector[] vertex = ball.rect.vertex();
    for (int i = 0; i < vertex.length; i++) {
      PVector point = vertex[i];
      PVector vec=calcCollisionPoint(point, ball.velocity, wall.rect.getPosVec(), wall.vec);
      if (vec==null) continue;
      float distance = PVector.dist(point, vec);
      if (nearestIndex==null||nearestDistanse > distance) {
        nearestIndex = i;
        targetPoint = vec;
        nearestDistanse = distance;
      }
    }
    if (nearestIndex==null) {
      return;
    }
    //Collision
    PVector v=ball.velocity.copy();
    float radian=2*wall.vec.heading()-2*v.heading();
    println(radian);
    float speed=v.mag();
    //ball.velocity.x=speed*cos(radian);



    ball.velocity.rotate(2*wall.vec.heading()-2*v.heading());
    switch (nearestIndex) {
    case 0:
      ball.rect.setPos(targetPoint.x, targetPoint.y);
      break;
    case 1:
      ball.rect.setPos(targetPoint.x-ball.rect.w, targetPoint.y);
      break;
    case 2:
      ball.rect.setPos(targetPoint.x-ball.rect.w, targetPoint.y-ball.rect.h);
      break;
    case 3:
      ball.rect.setPos(targetPoint.x, targetPoint.y-ball.rect.h);
      break;
    }
    println(ball.velocity);
    stroke(#ff0000);
    line(ball.rect.x, ball.rect.y, (ball.rect.x+ball.velocity.x)*10, (ball.rect.y+ball.velocity.y)*10);
    //Collision End
    //delay(5000);
  }
}
final class Wall extends GameObject {
  PVector vec;
  Wall(IGameObjectTree scene, Rect rect, float radian, float length) {
    super(scene, rect);
    vec = PVector.fromAngle(radian).setMag(length);
  }
  void draw() {
    fill(255);
    stroke(255);
    strokeWeight(4);
    line(rect.x, rect.y, rect.x+vec.x, rect.y+vec.y);
  }
}
//
*/