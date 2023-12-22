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

public class Position {
  int x;
  int y;
  int width;
  int height;
}

public class PositionManager {
  private int width;
  private int height;
  int getCenterX() {
    return width / 2;
  }
  int getCenterY() {
    return height / 2;
  }

  public PositionManager(int width, int height) {
    this.width = width;
    this.height = height;
  }
  void setSize(int width, int height) {
    this.width = width;
    this.height = height;
    applySize();
  }
  void applySize() {
    windowResize(width, height);
  }

  void posByAnchor(Position posFromAnchor, Anchor anchor) {
  }
}
