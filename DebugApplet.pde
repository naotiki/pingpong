import java.util.function.Consumer;
public class DebugApplet extends PApplet {

  public void settings() {
    size(400, 800);
  }
  public void setup() {
    textFont(FontMono, 32);
  }
  public void draw() {
    background(255);
    column(this, new Rect(0, 0), 18, #000000, u-> {
      u.text(sceneManager.getActiveSceneId());
      Runtime runtime = Runtime.getRuntime();
      long max = runtime.totalMemory();
      long free = runtime.freeMemory();
      long used = max - free;
      u.text(str(used/1024)+" KB");
      u.text("--- GameObjects ---");
      Scene scene = sceneManager.getActiveScene();
      /*  */
      drawTree(u, scene);
    }
    );
  }
  void drawTree(UIBuilder u, GameObjectTree gameObjectTree) {
    gameObjectTree.childForEach(g-> {
      String str = String.format("(%5.1f, %5.1f)", g.rect.x, g.rect.y);
      u.text((g.enabled ? "o" : "x")+" "+g.getClass().getSimpleName()+" "+str);
      if (g.hasChildren()) {
        u.indent();
        drawTree(u, g);
        u.unindent();
      }
    }
    );
  }
}
