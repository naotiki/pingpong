import java.util.List;
private final PositionManager positionManager = new PositionManager(800, 600, this);
private final SceneManager sceneManager = new SceneManager();
private final boolean isDebug = true;
//各種イベントの伝播

void setup() {
  frameRate(30);
  positionManager.applySize();
  sceneManager.registerScenes(new Scene[]{new MainScene(), new TitleScene()});
  sceneManager.transition("main");
}

void draw() {
  background(0);
  if (isDebug) {
    drawSceneName();
  }
  sceneManager.activeScene.draw();
}

void keyPressed() {
  keyEventManager.keyPressed();
  sceneManager.activeScene.keyPressed();
}
void keyReleased() {
  keyEventManager.keyReleased();
}

void drawSceneName() {
  fill(0, 408, 612, 100);
  textSize(32);
  text(sceneManager.activeScene.id, 40, 40);
}
