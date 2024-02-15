import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.Collections;

 abstract class Scene implements IGameObjectTree {
  final class MouseEventManager{
    private List<Pointerble> gameObjects = new ArrayList<Pointerble>();
    MouseEventManager(){
      
    }
    void add(Pointerble p){
      gameObjects.add(0,p);
    }
    Pointerble clickingGameObject=null;
    void update(){
      if (clickingGameObject==null) {
        gameObjects.stream()
          .peek(g->{
            g.isMouseHover = false;
            if (g instanceof Clickable) {
                ((Clickable)g).isMouseClick = false;
              }
          })
          .filter(g->g.enabled && isParentsEnabled(g) && g.rect.isPointWithIn(mouseX,mouseY) )
          .findFirst()
          .ifPresent(g->{
            if(mousePressed){
              if (g instanceof Clickable) {
                ((Clickable)g).isMouseClick = true;
              }
              clickingGameObject=g;
              println("clickingGameObject:"+g.getClass().getSimpleName());
            }
              g.isMouseHover = true;
            
          });
      }else if(!mousePressed&&clickingGameObject!=null){
        if(clickingGameObject instanceof Clickable){
          ((Clickable)clickingGameObject).onClicked();
          ((Clickable)clickingGameObject).isMouseClick = false;
          ((Clickable)clickingGameObject).isMouseHover = false;
        }
        clickingGameObject=null;
      }
    }
  }
  final MouseEventManager mouseEventManager = new MouseEventManager();
  void add(Pointerble p){
    mouseEventManager.add(p);
  }
  private List<GameObject> gameObjects = new ArrayList<GameObject>();
  private List<GameObject> standbyGameObjects = new ArrayList<GameObject>();
  private boolean isLockedGameObjects = false;
  final void addChild(GameObject go) {
    if(isLockedGameObjects) {
      standbyGameObjects.add(go);
    }else{
      gameObjects.add(go);
    }
  }

  final List<GameObject> getChildren() {
    return gameObjects;
  }

  void sceneSetup() {
  }
  void sceneUpdate(){

  }
  final void setup(){
    println("Start:main Setup");
    sceneSetup();
    isLockedGameObjects = true;
    setupAll(getChildren());
    isLockedGameObjects = false;
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
    println("End:main Setup");
  }
  
  final void setupAll(List<GameObject> children){
    children.forEach( (g) -> {
      println("Start:"+g.getClass().getSimpleName()+" Setup");
      if(!g.enabled) return;
      g.setup();
      if(g instanceof IGameObjectTree){
        println(g.getClass().getSimpleName()+" has children");
        setupAll(((IGameObjectTree)g).getChildren() );
      }
    }
    );
  }
  final void drawAll(List<GameObject> children){
    children.forEach( (g) -> {
      if(!g.enabled) return;
      g.draw();
      if(g instanceof IGameObjectTree){
        drawAll(((IGameObjectTree)g).getChildren() );
      }
    }
    );
  }

  final void update() {



    sceneUpdate();
    isLockedGameObjects = true;
    
    mouseEventManager.update();

    drawAll(getChildren());
    isLockedGameObjects = false;
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
  }
  
  // Deprected, Use "KeyEventManager"
  void keyPressed(){}
  // Sceneを離れるとき すべてを破壊してきれいにする
  void destroy() {
  };

}





