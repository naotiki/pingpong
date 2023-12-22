

abstract class GameObject {
  public float x;
  public float y;
  public float width;
  public float height;
  GameObject(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    gameObjects.add(this);
  }

  abstract void draw();

  boolean isCollision(GameObject target) {
    return false;
  }
}
