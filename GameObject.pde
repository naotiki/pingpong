// 座標と幅、高さを持つ基底クラス
abstract class GameObject {
  //値はすべて絶対値 左上(0,0)
  Rect rect;

  
  public Scene getActiveScene() {
    return sceneManager.activeScene;
  }

  GameObject(Scene scene,Rect rect) {
    this.rect=rect;
    //一般的に良くないとされている"this"のリークは気にしない
    scene.addGameObject(this);
  }
  //setupは任意
  void setup() {
  }
  void beforeSetup() {
  }

  // 描画は各自で実装
  abstract void draw();

   // 衝突判定 // これいる？
  /* boolean isCollision(GameObject target) {
    return (x < target.x + target.width && x + width > target.x) && (y < target.y + target.height && y + height > target.y) ;
  } */

}



/* 
//TODO ???
abstract class RigitBody extends GameObject {
  PVector velocity = new PVector();
  RigitBody(Scene scene, float x, float y, float width, float height) {
    super(scene,x,y,width,height);
  }
  
}
 */