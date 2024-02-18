final class TestScene2 extends Scene {
  final Area gameArea = new Area(this, new Rect(0, 0, screen.getWidth(), screen.getHeight()), -1);
  final NewBall ball = new NewBall(gameArea, BallSize.pos(gameArea.centerX()-150, gameArea.centerY()-70), gameArea);
  //final Wall wall = new Wall(gameArea, BallSize.pos(gameArea.centerX()-100, gameArea.centerY()+100), radians(5), 500);
  final Button menuButton = new Button(gameArea, gameArea.posByAnchor(new Rect(0, 25, 150, 50), Anchor.TopCenter), this, "Reload");
  final List<Wall> walls = new ArrayList<Wall>();
  float wallAngleBase() {
    return random(radians(5), radians(85));
  }
  void sceneSetup() {
    menuButton.setOnClickListener(()-> {
      sceneManager.changeOneshot(new TestScene2());
    }
    );
    float angle = wallAngleBase();
    Wall w=new Wall(gameArea, new Rect(0, screen.height-5), -angle, 100);
    walls.add(w);
    for (int i = 0; w.rect.x+w.vec.x < screen.width; ++i) {
      float sign=i%2==0?1:-1;
      if(sign==-1){
        angle= wallAngleBase();
      }
      w = new Wall(gameArea, new Rect(w.rect.x+w.vec.x,w.rect.y+w.vec.y,0,0), sign*angle, 100);
      walls.add(w);
    } 
  }
  void sceneUpdate() {
    //delay(250);
    println("update");
    while(true){
    PVector ballCenter=new PVector(ball.rect.centerX(),ball.rect.centerY());
    PVector newPos =  null;
    Float nearestDistanse = null;
    Wall hitWall=null;
    /*/*  */ for (int i = 0; i < walls.size(); i++) {
      Wall w = walls.get(i);
      
      PVector pos = calcCircleCenterOnCollision(
        ballCenter,
        ball.velocity,w.rect.getPosVec(),w.vec,ball.rect.w/2
       );
      if (pos==null) continue;
      float distance = PVector.dist(ballCenter, pos);
      if (newPos==null||nearestDistanse > distance) {
        hitWall=w;
        newPos = pos;
        nearestDistanse = distance;
      }
    } 
    if (newPos==null) {
      return;
    }
    markPoint(newPos,#ff0000);
    fill(#ffff00);
    stroke(#ffff00);
    strokeWeight(8);
    line(hitWall.rect.x,  hitWall.rect.y,  hitWall.rect.x+ hitWall.vec.x,  hitWall.rect.y+ hitWall.vec.y);
    //Collision
    PVector v=ball.velocity.copy();
    float radian=2*hitWall.vec.heading()-2*v.heading();
    float speed=v.mag();
    ball.velocity.rotate(radian);
    ball.rect.setPos(newPos.x-ball.rect.w/2, newPos.y-ball.rect.h/2);
    stroke(#ff0000);
    println(ball.velocity);
    line(ball.rect.x,ball.rect.y,(ball.rect.x+ball.velocity.x)*20,(ball.rect.y+ball.velocity.y)*20);
    //isStopDraw=true;
  }
    }
    //Collision End
    
  //}
}

final class NewBall extends GameObject {
  private float speed=10f*UNIT;
  static final color DEFAULT_TINTCOLOR = #ffffff;

  //速度ベクトル Defaultではランダム
  PVector velocity =PVector.fromAngle(70).setMag(speed);// randomAngleVec().setMag(speed);//

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
    

    if ((rect.x+velocity.x < areaRect.x && velocity.x < 0) || (rect.x+velocity.x+rect.w > areaRect.x + areaRect.w && velocity.x > 0)) {
      velocity.x*=-1;
    }
    if ((rect.y+velocity.y < areaRect.y && velocity.y < 0) || (rect.y+velocity.y+rect.h > areaRect.y + areaRect.h  && velocity.y > 0)) {
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
