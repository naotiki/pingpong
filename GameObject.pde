// 座標と幅、高さを持つ基底クラス
abstract class GameObject {
  //値はすべて絶対値 左上(0,0)
  Rect rect;
  boolean enabled = true;
  
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
  
  // 更新は各自で実装
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
  abstract class Pointerble extends GameObject{
    Pointerble(Scene scene,Rect rect) {
      super(scene,rect);
      scene.putPointerble(this);
    }
    boolean isMouseHover =false;
  }
  abstract class Clickable extends Pointerble  {
    Clickable(Scene scene,Rect rect) {
      super(scene,rect);
    }
    boolean isMouseClick =false;
    //ボタンが離されたとき発火
    abstract void onClicked();
    
 }