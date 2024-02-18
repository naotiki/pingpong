// 座標と幅、高さを持つ基底クラス
abstract class GameObject {

  //値はすべて絶対値 左上(0,0)
  Rect rect;
  boolean enabled = true;
  public final Scene getActiveScene() {
    return sceneManager.activeScene;
  }
  final IGameObjectTree parent;
  GameObject(IGameObjectTree parent, Rect rect) {
    this.rect=rect;
    this.parent=parent;
    //一般的に良くないとされている"this"のリークは気にしない
    parent.addChild(this);
  }
  //setupは任意
  void setup() {
  }

  // 描画は各自で実装
  abstract void draw();
  final void drawSelf() {
    resetDraw();
    draw();
  }
  // 他のGOの影響を受けないようにする
  private void resetDraw(){
    fill(255);
    strokeWeight(1);
    noStroke();
    noTint();
  }
  boolean isCollision(GameObject other) {
    return rect.intersects(other.rect);
  }
  void destroy() {
    //parent.removeChild(this);
  }
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
abstract class Pointerble extends GameObject {
  Pointerble(IGameObjectTree parent, Rect rect, Scene scene) {
    super(parent, rect);
    scene.add(this);
  }
  boolean isMouseHover =false;
}
abstract class Clickable extends Pointerble {
  Clickable(IGameObjectTree parent, Rect rect, Scene scene) {
    super(parent, rect, scene);
  }
  boolean isMouseClick =false;
  //ボタンが離されたとき発火
  abstract void onClicked();
}
