import java.util.List;
import java.lang.*;
import java.lang.reflect.*;
final int FRAME_RATE = 45;
final float UNIT = 60f/FRAME_RATE;

final ScreenManager screen = new ScreenManager(1000, 700, this);
final SceneManager sceneManager = new SceneManager();
final KeyEventManager keyEventManager = new KeyEventManager();

PFont FontDefault;
PFont FontMono;
//各種イベントの伝播
void setup() {
  frameRate(FRAME_RATE);
  FontDefault = loadFont("DotGothic16-Regular-48.vlw");
  FontMono = loadFont("UDEVGothic-Regular-48.vlw");
  textFont(FontDefault, 32);
  screen.applySize();
  sceneManager.registerScenes(new HashMap<String, Scene>() {
    {
      put("title", new TitleScene());
    }
  }
  );
  sceneManager.change("title");
  sceneManager.changeOneshot(new MainScene());
  //sceneManager.change("main");
  //Class<MainScene> sampleClass = MainScene.class.getConstructor().newInstance();
  if (isDebug) {
    debugSetup();
  }
}
boolean isStopDraw=false;
void pauseDraw() {
  isStopDraw=true;
}
void draw() {
  if (isStopDraw) return;

  background(0);
  sceneManager.activeScene.sceneUpdate();


  if (isDebug) {
    debugDraw();
  }
}

void keyPressed() {
  keyEventManager.keyPressed();
  // TODO 消す ←たぶんわすれる
  sceneManager.activeScene.keyPressed();
}
void keyReleased() {
  keyEventManager.keyReleased();
}
