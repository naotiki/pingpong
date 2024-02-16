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
    wall.vec.rotate(radians(1));
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
final class NewBall extends GameObject {
  private float speed=10f*UNIT;
  static final color DEFAULT_TINTCOLOR = #ffffff;

  //速度ベクトル Defaultではランダム
  PVector velocity =PVector.fromAngle(45).setMag(speed);// randomAngleVec().setMag(speed);//

  PVector randomAngleVec() {
    float radian = random(radians(45), radians(60) )+round(random(3))*HALF_PI;
    return PVector.fromAngle(radian);
  }

  ParticleSystem ps;
  void setParticleColor(color c) {
    ps.tintColor = c;
  }

  // Effectの方向ベクトル
  PVector getEffectVec() {
    // 正規化した速度の逆向き * -0.1
    return new PVector().set(velocity).normalize().mult(-0.1);
  }
  Area area;
  NewBall(IGameObjectTree scene, Rect rect, Area area) {
    super(scene, rect);
    this.area = area;
  }


  void setup() {
    PImage img = loadImage("ball_effect.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(50, new PVector(rect.centerX(), rect.centerY()), img, DEFAULT_TINTCOLOR);
  }

  void draw() {
    fill(255);
    noStroke();
    Rect areaRect = area.rect;
    if ((rect.x < areaRect.x && velocity.x < 0) || (rect.x+rect.w > areaRect.x + areaRect.w && velocity.x > 0)) {
      velocity.x*=-1;
    }
    if ((rect.y < areaRect.y && velocity.y < 0) || (rect.y+rect.h > areaRect.y + areaRect.h  && velocity.y > 0)) {
      velocity.y*=-1;
    }



    rect.x+=velocity.x;
    rect.y+=velocity.y;
    ps.origin.set(rect.centerX(), rect.centerY());
    ps.applyForce(getEffectVec());
    ps.run();
    ps.addParticle();
    ellipseMode(CORNER);
    ellipse(rect.x, rect.y, rect.w, rect.h);
  }

  void reset() {
    ps.tintColor = DEFAULT_TINTCOLOR;
    rect.x = screen.centerX();
    rect.y = screen.centerY();
    velocity = randomAngleVec().setMag(speed);
    ps.origin.set(rect.centerX(), rect.centerY());
    ps.init();
  }
}
