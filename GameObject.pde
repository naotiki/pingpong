// 座標と幅、高さを持つ基底クラス
abstract class GameObject {
  //値はすべてAbsolute
  float x;
  float y;
  float width;
  float height;

  public Scene getActiveScene() {
    return sceneManager.activeScene;
  }

  GameObject(Scene scene, float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    scene.gameObjects.add(this);
  }

  void setup() {
  }

  // 描画は各自で実装
  abstract void draw();

  // 衝突判定 TODO
  boolean isCollision(GameObject target) {
    return (x < target.x + target.width && x + width > target.x) && (y < target.y + target.height && y + height > target.y) ;
  }
}

abstract class RigitBody extends GameObject {
  PVector velocity = new PVector();
  RigitBody(Scene scene, float x, float y, float width, float height) {
    super(scene,x,y,width,height);
  }
  
}
