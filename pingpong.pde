import java.util.List;

final ScreenManager screen = new ScreenManager(800, 600, this);
final SceneManager sceneManager = new SceneManager();
final KeyEventManager keyEventManager = new KeyEventManager();

private final boolean isDebug = true;

//各種イベントの伝播
void setup() {
  frameRate(60);
  screen.applySize();
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
  // TODO 消す ←たぶんわすれる
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
