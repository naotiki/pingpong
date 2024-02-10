final class Ball extends GameObject {
  static final float speed=10f;

  //速度ベクトル Defaultではランダム
  PVector velocityVec = PVector.random2D().setMag(speed);

  ParticleSystem ps;
  // Effectの方向ベクトル
  PVector getEffectVec(){
    // 正規化した速度の逆向き
    return new PVector().set(velocityVec).normalize().mult(-0.1);
  } 
  
  Ball(Scene scene, float x, float y) {
    super(scene, x, y, 20, 20);
  }


  void setup() {
    PImage img = loadImage("texture.png");

    //なんかエフェクトがつくやつ
    ps = new ParticleSystem(0, new PVector(width/2, height-60), img);
  }

  void draw() {
    fill(255);
    noStroke();
    if ((x < 0 && velocityVec.x < 0) || (x > positionManager.width && velocityVec.x > 0)) {
      velocityVec.x*=-1;
    }
    if ((y < 0 && velocityVec.y < 0) || (y > positionManager.height && velocityVec.y > 0)) {
      velocityVec.y*=-1;
    }

    x+=velocityVec.x;
    y+=velocityVec.y;
    ps.origin.set(x, y);
    ps.applyForce(getEffectVec());
    ps.run();
    ps.addParticle();

    ellipse(x, y, width, height);
  }
}
