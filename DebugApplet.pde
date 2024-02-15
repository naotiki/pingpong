import java.util.function.Consumer;
public class DebugApplet extends PApplet {

  public void settings() {
    size(400, 800);
  }
  public void draw() {
    background(255);
    column(this,new Rect(0,0),20,#000000,u->{
        u.text(sceneManager.getActiveSceneId());
        Runtime runtime = Runtime.getRuntime();
        long max = runtime.totalMemory();
        long free = runtime.freeMemory();
        long used = max - free;
        u.text(str(used/1024)+" KB");
        u.text("--- GameObjects ---");
        Scene scene = sceneManager.getActiveScene();
        /*  */
        drawTree(u,((List<GameObject>)((ArrayList<GameObject>)scene.getChildren()).clone()));
    });
    
  }
  void drawTree(UIBuilder u,List<GameObject> list){
        list.forEach(g->{
            u.text((g.enabled ? "o" : "x")+" "+g.getClass().getSimpleName());
            if(g instanceof IGameObjectTree){
                u.indent();
                drawTree(u,((IGameObjectTree)g).getChildren() );
                u.unindent();
            }
        });
    }
}