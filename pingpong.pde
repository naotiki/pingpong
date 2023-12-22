import java.util.List;

final List<GameObject> gameObjects = new ArrayList<GameObject>();
final Paddle player = new Paddle(100, 500);
final PositionManager pos = new PositionManager(800,600);

final Ball ball = new Ball(50,50);

void setup() {
  frameRate(60);
  pos.applySize();
  
}

void draw() {
  background(255);
  windowMove((int)random(1000),(int)random(1000));
  gameObjects.forEach( (e) -> {
    e.draw();
  });
}

void keyPressed() {
  if (keyCode == UP) {
    player.y-=10;
  }
  if (keyCode == DOWN) {
    player.y+=10;
  }
}
