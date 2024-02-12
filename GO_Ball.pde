final class Ball extends GameObject {
  static final float speed=10f;

  //速度ベクトル Defaultではランダム
  PVector velocityVec = PVector.random2D().setMag(speed);

  ParticleSystem ps;
  // Effectの方向ベクトル
  PVector getEffectVec(){
    // 正規化した速度の逆向き * -0.1
    return new PVector().set(velocityVec).normalize().mult(-0.1);
  } 
  
  Ball(Scene scene, Rect rect) {
    super(scene, rect);
    rect.setSize(20, 20);
  }


  void setup() {
    PImage img = loadImage("ball_effect.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(0, new PVector(width/2, height-60), img);
  }

  void draw() {
    fill(255);
    noStroke();
    if ((rect.x < 0 && velocityVec.x < 0) || (rect.x > screen.width && velocityVec.x > 0)) {
      velocityVec.x*=-1;
    }
    if ((rect.y < 0 && velocityVec.y < 0) || (rect.y > screen.height && velocityVec.y > 0)) {
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
}
