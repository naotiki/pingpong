import java.util.List;
import java.lang.*;
import java.lang.reflect.*;
final int FRAME_RATE = 60;
final float UNIT = 60f/FRAME_RATE;

final ScreenManager screen = new ScreenManager(1000, 700, this);
final SceneManager sceneManager = new SceneManager();
final KeyEventManager keyEventManager = new KeyEventManager();

private final boolean isDebug = true;
PFont defaultFont;
PFont monoFont;
//各種イベントの伝播
void setup() {
  frameRate(FRAME_RATE);
  defaultFont = loadFont("DotGothic16-Regular-48.vlw"); 
  monoFont = loadFont("UDEVGothic-Regular-48.vlw");
  textFont(defaultFont, 32); 
  screen.applySize();
  sceneManager.registerScenes(new HashMap<String, Scene>() {
    {
        put("title", new TitleScene());
    }
  });
  sceneManager.changeOneshot(new TestScene());
  //sceneManager.change("main");
  //Class<MainScene> sampleClass = MainScene.class.getConstructor().newInstance();
  if(isDebug){
    DebugApplet debugApplet = new DebugApplet();
    PApplet.runSketch(new String[]{"Debug"}, debugApplet);
  }
}

void draw() {
  
  
  background(0);
  sceneManager.activeScene.update();
  

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
void debugDraw() {
  textAlign(LEFT, CENTER);
  fill(#ee00cc00);
  textSize(32);
  text(sceneManager.getActiveSceneId(), 40, 40);
  Runtime runtime = Runtime.getRuntime();
  long max = runtime.totalMemory();
  long free = runtime.freeMemory();
  long used = max - free;
  text(str(used/1024)+" KB", 40, 80);
  stroke(#ee00cccc);
  line(mouseX-10, mouseY ,mouseX+10, mouseY);
  line(mouseX, mouseY-10, mouseX, mouseY+10);
  textAlign(CENTER, CENTER);
  text("("+mouseX+","+mouseY+")", mouseX, mouseY-20);
}
