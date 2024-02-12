import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;

static abstract class Scene {
  String id;
  List<GameObject> gameObjects = new ArrayList<GameObject>();
  private List<GameObject> standbyGameObjects = new ArrayList<GameObject>();
  private boolean isLockedGameObjects = false;
  final void addGameObject(GameObject go) {
    if(isLockedGameObjects) {
      standbyGameObjects.add(go);
    }else{
      gameObjects.add(go);
    }
    
  }

  Scene(String id) {
    this.id=id;
  }

  void setup(){
    println("Start:main Setup");
    isLockedGameObjects = true;
    gameObjects.forEach( (g) -> {
      g.setup();
    }
    );
    isLockedGameObjects = false;
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
    println("End:main Setup");
  }
  
  void draw() {
    isLockedGameObjects = true;
    gameObjects.forEach( (g) -> {
      g.draw();
    }
    );
    isLockedGameObjects = false;
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
  }
  
  // Deprected. draw内で判定したほうがスムーズ
  void keyPressed(){}

  //Sceneを離れるとき
  void destroy() {
  };
}




//Sceneを管理する人
final static class SceneManager {
  SceneManager() {
    var es=new EmptyScene();
    registerScenes(new Scene[]{es});
    activeScene=es;
  }
  private Map<String, Scene> allScenes = new HashMap<>();

  private Scene activeScene;
  // ゲッター
  Scene getActiveScene() {
    return activeScene;
  }
  
  Scene getSceneById(String id) {
    return allScenes.get(id);
  }

  void registerScenes(Scene[] scenes) {
    allScenes.putAll(
      Arrays.asList(scenes)
      .stream()
      .collect(
      Collectors.toMap(s->s.id, s->s)
      )
      );
  }

  void transition(String sceneId) {
    println("Loading "+sceneId);
    activeScene.destroy();
    activeScene = getSceneById(sceneId);
    activeScene.setup();
  }
}


final static class EmptyScene extends Scene {
  EmptyScene(){
    super("_empty");
  }
}
