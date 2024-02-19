final class TestScene2 extends Scene {
  final Area gameArea = new Area(this, new Rect(0, 0, screen.getWidth(), screen.getHeight()), -1);
  final NewBall ball = new NewBall(gameArea, BallSize.pos(gameArea.centerX()-150, gameArea.centerY()-70), gameArea);
  //final Wall wall = new Wall(gameArea, BallSize.pos(gameArea.centerX()-100, gameArea.centerY()+100), radians(5), 500);
  final Button menuButton = new Button(gameArea, gameArea.posByAnchor(new Rect(0, 25, 150, 50), Anchor.TopCenter), this, "Reload");
  final List<Wall> walls = new ArrayList<Wall>();
  double wallAngleBase() {
    return ((Float)random(radians(5), radians(85))).doubleValue();
  }
  void setup() {
    menuButton.setOnClickListener(()-> {
      sceneManager.changeOneshot(new TestScene2());
    }
    );
    double angle = wallAngleBase();
    Wall w=new Wall(gameArea, new Rect(0, screen.height-10), -angle, 100);
    walls.add(w);
    for (int i = 0; w.rect.x+w.vec.x < screen.width; ++i) {
      double sign=i%2==0?1:-1;
      if (sign==-1) {
        angle= wallAngleBase();
      }
      w = new Wall(gameArea, new Rect(w.rect.x+w.vec.toFloat().x, w.rect.y+w.vec.toFloat().y, 0, 0), sign*angle, 100);
      walls.add(w);
    }
  }
  void update() {
    //delay(250);
    println("update");
    while (true) {
      PVectorD ballCenter=new PVectorD(ball.rect.centerX(), ball.rect.centerY());
      PVectorD newPos =  null;
      Double nearestDistanse = null;
      Wall hitWall=null;
      /*/*  */      for (int i = 0; i < walls.size(); i++) {
        Wall w = walls.get(i);

        PVectorD pos = calcCircleCenterOnCollisionD(
          ballCenter,
          ball.velocity, w.rect.getPosVecD(), w.vec, ball.rect.w/2
          );
        if (pos==null) continue;
        double distance = PVectorD.dist(ballCenter, pos);
        if (newPos==null||nearestDistanse > distance) {
          hitWall=w;
          newPos = pos;
          nearestDistanse = distance;
        }
      }
      if (newPos==null) {
        return;
      }
      markPoint(newPos.toFloat(), #ff0000);
      fill(#ffff00);
      stroke(#ffff00);
      strokeWeight(8);
      line(hitWall.rect.x, hitWall.rect.y, hitWall.rect.x+ hitWall.vec.toFloat().x, hitWall.rect.y+ hitWall.vec.toFloat().y);
      //Collision
      PVectorD v=ball.velocity.copy();
      double radian=2*hitWall.vec.heading()-2*v.heading();
      double speed=v.mag();
      ball.velocity.rotate(radian);
      PVector newPosF=newPos.toFloat();
      ball.rect.setPos(newPosF.x-ball.rect.w/2, newPosF.y-ball.rect.h/2);
      stroke(#ff0000);
      println(ball.velocity);
      //line(ball.rect.x,ball.rect.y,(ball.rect.x+ball.velocity.x)*20,(ball.rect.y+ball.velocity.y)*20);
      isStopDraw=true;
    }
  }
  //Collision End

  //}
}

final class NewBall extends GameObject {
  private double speed=10f*UNIT;
  static final color DEFAULT_TINTCOLOR = #ffffff;

  //速度ベクトル Defaultではランダム
  PVectorD velocity =PVectorD.fromAngle(70).setMag(speed);// randomAngleVec().setMag(speed);//

  PVectorD randomAngleVec() {
    Float radian = random(radians(45), radians(60) )+round(random(3))*HALF_PI;
    return PVectorD.fromAngle(radian.doubleValue());
  }

  ParticleSystem ps;
  void setParticleColor(color c) {
    ps.tintColor = c;
  }

  // Effectの方向ベクトル
  PVector getEffectVec() {
    // 正規化した速度の逆向き * -0.1
    return velocity.copy().normalize().mult(-0.1).toFloat();
  }
  Area area;
  NewBall(GameObjectTree scene, Rect rect, Area area) {
    super(scene, rect);
    this.area = area;
  }


  void setup() {
    PImage img = loadImage("ball_effect.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(50, new PVector(rect.centerX(), rect.centerY()), img, DEFAULT_TINTCOLOR);
  }

  void draw() {
    PVector fVec=velocity.toFloat();
    fill(255);
    noStroke();
    Rect areaRect = area.rect;


    if ((rect.x+fVec.x < areaRect.x && velocity.x < 0) || (rect.x+fVec.x+rect.w > areaRect.x + areaRect.w && velocity.x > 0)) {
      velocity.x*=-1;
    }
    if ((rect.y+fVec.y < areaRect.y && velocity.y < 0) || (rect.y+fVec.y+rect.h > areaRect.y + areaRect.h  && velocity.y > 0)) {
      velocity.y*=-1;
    }

    rect.x+=velocity.toFloat().x;
    rect.y+=velocity.toFloat().y;

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
final class Wall extends GameObject {
  PVectorD vec;
  Wall(GameObjectTree scene, Rect rect, double radian, double length) {
    super(scene, rect);
    vec = PVectorD.fromAngle(radian).setMag(length);
  }
  void draw() {
    fill(255);
    stroke(255);
    strokeWeight(4);
    line(rect.x, rect.y, rect.x+vec.toFloat().x, rect.y+vec.toFloat().y);
  }
}
