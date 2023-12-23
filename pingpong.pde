import java.util.List;

final List<GameObject> gameObjects = new ArrayList<GameObject>();
final Bar player = new Bar(100, 500);
final PositionManager pos = PositionManager.getInstance(800,600,this);

final Ball ball = new Ball(50,50);
void setup() {
  
  frameRate(60);
  pos.applySize();
  
}

void draw() {
  background(255);
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
