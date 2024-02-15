final class Ball extends GameObject {
  private float speed=10f*UNIT;
  static final color DEFAULT_TINTCOLOR = #ffffff;

  //速度ベクトル Defaultではランダム
  PVector velocityVec = randomAngleVec().setMag(speed);

  PVector randomAngleVec(){
    float radian = random(radians(45),radians(60) )+round(random(3))*HALF_PI;
    return PVector.fromAngle(radian);
  }

  ParticleSystem ps;
  void setParticleColor(color c){
    ps.tintColor = c;
  }

  // Effectの方向ベクトル
  PVector getEffectVec(){
    // 正規化した速度の逆向き * -0.1
    return new PVector().set(velocityVec).normalize().mult(-0.1);
  } 
  Area area;
  Ball(IGameObjectTree scene, Rect rect,Area area) {
    super(scene, rect);
    this.area = area;
  }


  void setup() {
    PImage img = loadImage("ball_effect.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(50, new PVector(rect.centerX(),rect.centerY()), img,DEFAULT_TINTCOLOR);
  }

  void draw() {
    fill(255);
    noStroke();
    Rect areaRect = area.rect;
    if ((rect.x < areaRect.x && velocityVec.x < 0) || (rect.x+rect.w > areaRect.x + areaRect.w && velocityVec.x > 0)) {
      velocityVec.x*=-1;
    }
    if ((rect.y < areaRect.y && velocityVec.y < 0) || (rect.y+rect.h > areaRect.y + areaRect.h  && velocityVec.y > 0)) {
      velocityVec.y*=-1;
    }

    rect.x+=velocityVec.x;
    rect.y+=velocityVec.y;
    ps.origin.set(rect.centerX(), rect.centerY());
    ps.applyForce(getEffectVec());
    ps.run();
    ps.addParticle();
    ellipseMode(CORNER);
    ellipse(rect.x, rect.y, rect.w, rect.h);
  }

  void reset(){
      ps.tintColor = DEFAULT_TINTCOLOR;
      rect.x = screen.centerX();
      rect.y = screen.centerY();
      velocityVec = randomAngleVec().setMag(speed);
      ps.origin.set(rect.centerX(), rect.centerY());
      ps.init();
  }
}
