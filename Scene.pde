import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;

static abstract class Scene {
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
    EmptyScene es=new EmptyScene();
    registerScene("_empty",es);
    activeScene=es;
  }
  private Map<String, Scene> allScenes = new HashMap<>();

  private Scene activeScene;
  private String activeSceneId;
  // ゲッター
  Scene getActiveScene() {
    return activeScene;
  }
  String getActiveSceneId() {
    return activeSceneId;
  }
  String getIdFromScene(Scene scene){
    for(Map.Entry<String, Scene> entry : allScenes.entrySet()){
      if(entry.getValue().equals(scene)){
        return entry.getKey();
      }
    }
    return "_null";
  }
  Scene getSceneById(String id) {
    return allScenes.get(id);
  }
  void registerScene(String id,Scene instance){
    allScenes.put(id,instance);
  }
  void registerScenes(Map<String, Scene> scenes) {
    allScenes.putAll(scenes);
  }

  private void change(String sceneId,Scene scene){
    activeScene.destroy();
    activeScene = scene;
    activeScene.setup();
    activeSceneId = sceneId;
  }
  
  void change(String sceneId) {
    println("Loading "+sceneId);
    change(sceneId,getSceneById(sceneId));
  }
  void changeOneshot(Scene scene) {
    var id = "__"+scene.getClass().getSimpleName();
    println("Oneshot Loading "+id);
    change(id,scene);
  }
}


static final class EmptyScene extends Scene {
}
