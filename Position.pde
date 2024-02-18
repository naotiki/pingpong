//位置指定アンカー
enum Anchor {
  TopLeft(0, 0),
    TopCenter(0.5, 0),
    TopRight(1, 0),
    MiddleLeft(0, 0.5),
    MiddleCenter(0.5, 0.5),
    MiddleRight(1, 0.5),
    BottomLeft(0, 1),
    BottomCenter(0.5, 1),
    BottomRight(1, 1);
  private float x;
  private float y;

  private Anchor(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

static class Rect {
  float x;
  float y;
  float w;
  float h;
  Rect(float x, float y) {
    this.x=x;
    this.y=y;
    this.w=0;
    this.h=0;
  }
  Rect(float x, float y, float w, float h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  //Getter
  public float left() {
    return x;
  }
  public float right() {
    return x + w;
  }
  public float top() {
    return y;
  }
  public float bottom() {
    return y + h;
  }
  public float centerX() {
    return x + w/2;
  }
  public float centerY() {
    return y + h/2;
  }
  public PVector[] vertex() {
    PVector[] vertex = new PVector[4];
    vertex[0] = new PVector(left(), top());
    vertex[1] = new PVector(right(), top());
    vertex[2] = new PVector(right(), bottom());
    vertex[3] = new PVector(left(), bottom());
    return vertex;
  }
  PVector getPosVec() {
    return new PVector(x, y);
  }
  PVectorD getPosVecD() {
    return new PVectorD(x, y);
  }

  //コピーして位置を変更
  Rect pos(float x, float y) {
    return new Rect(x, y, w, h);
  }
  //コピーしてサイズを変更
  Rect size(float w, float h) {
    return new Rect(x, y, w, h);
  }
  void setPos(float x, float y) {
    this.x=x;
    this.y=y;
  }
  void setSize(float w, float h) {
    this.w=w;
    this.h=h;
  }
  // thisのanchorを基準としてrectの位置を返す
  Rect posByAnchor(Rect rect, Anchor anchor) {
    float tmpX = w * anchor.x  - rect.w * anchor.x + rect.x + x;
    float tmpY = h * anchor.y - rect.h * anchor.y + rect.y + y;
    return new Rect(tmpX, tmpY, rect.w, rect.h);
  }
  boolean isPointWithIn(float x, float y) {
    return x >= left() && x <= right() && y >= top() && y <= bottom();
  }
}

static class ScreenManager {
  private int width;
  private int height;
  private PApplet app;
  int centerX() {
    return width / 2;
  }
  int centerY() {
    return height / 2;
  }

  int getWidth() {
    return width;
  }
  int getHeight() {
    return height;
  }
  ScreenManager(int width, int height, PApplet app) {
    this.width = width;
    this.height = height;
    this.app = app;
  }
  void setSize(int width, int height) {
    this.width = width;
    this.height = height;
    applySize();
  }

  void applySize() {
    app.windowResize(width, height);
  }

  Rect posByAnchor(Rect rect, Anchor anchor) {
    float x = width * anchor.x - rect.w * anchor.x + rect.x;
    float y = height * anchor.y - rect.h * anchor.y + rect.y;
    return new Rect(x, y, rect.w, rect.h);
  }
}
