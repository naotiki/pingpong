import java.util.List;
import java.lang.*;
import java.lang.reflect.*;
final ScreenManager screen = new ScreenManager(800, 600, this);
final SceneManager sceneManager = new SceneManager();
final KeyEventManager keyEventManager = new KeyEventManager();

private final boolean isDebug = true;

//各種イベントの伝播
void setup() {
  frameRate(60);
  screen.applySize();
  sceneManager.registerScenes(new HashMap<String, Scene>() {
    {
        put("title", new TitleScene());
    }
  });
  sceneManager.changeOneshot(new MainScene());
  //sceneManager.change("main");
  //Class<MainScene> sampleClass = MainScene.class.getConstructor().newInstance();
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
  text(sceneManager.getActiveSceneId(), 40, 40);
}
