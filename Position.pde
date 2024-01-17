enum Anchor {
  Default(-1, -1),
    BottomLeft(1, -1),
    BottomCenter(1, 0),
    BottomRight(1, 1);
  private int x;
  private int y;

  private Anchor(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Position {
  int x;
  int y;
  int width;
  int height;
}

static class PositionManager {
  private int width;
  private int height;
  private PApplet app;
  int getCenterX() {
    return width / 2;
  }
  int getCenterY() {
    return height / 2;
  }

  int getWidth() {
    return width;
  }
  int getHeight() {
    return height;
  }
  private PositionManager(int width, int height, PApplet app) {
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
  private static PositionManager instance;
  static PositionManager getInstance(int width, int height, PApplet app) {
    instance = new PositionManager(width, height, app);
    return instance;
  }
  static PositionManager getInstance() {
    return instance;
  }

  void posByAnchor(Position posFromAnchor, Anchor anchor) {
  }
}
