final class Ball extends GameObject {
  static final float speed=10f;
  

  //速度ベクトル Defaultではランダム
  PVector velocityVec = PVector.random2D().setMag(speed);

  ParticleSystem ps;
  void setParticleColor(color c){
    ps.tintColor = c;
  }

  // Effectの方向ベクトル
  PVector getEffectVec(){
    // 正規化した速度の逆向き * -0.1
    return new PVector().set(velocityVec).normalize().mult(-0.1);
  } 
  
  Ball(Scene scene, Rect rect) {
    super(scene, rect);
  }


  void setup() {
    PImage img = loadImage("ball_effect.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(0, new PVector(width/2, height-60), img,#ffffff);
  }

  void draw() {
    fill(255);
    noStroke();
    if ((rect.x < 0 && velocityVec.x < 0) || (rect.x+rect.w > screen.width && velocityVec.x > 0)) {
      velocityVec.x*=-1;
    }
    if ((rect.y < 0 && velocityVec.y < 0) || (rect.y+rect.h > screen.height && velocityVec.y > 0)) {
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
