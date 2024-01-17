import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;

static abstract class Scene {
  String id;
  List<GameObject> gameObjects = new ArrayList<GameObject>();
  Scene(String id) {
    this.id=id;
  }

  void setup(){
    gameObjects.forEach( (g) -> {
      g.setup();
    }
    );
  }
  
  void draw() {
    gameObjects.forEach( (g) -> {
      g.draw();
    }
    );
    
  }
  
  // Deprected. draw内で判定したほうがスムーズ
  void keyPressed(){}

  //Sceneを離れるとき
  void destroy() {
  };
}




//Sceneを管理する人
final static class SceneManager {
  private SceneManager() {
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

  //シングルトン
  private static SceneManager instance = new SceneManager();
  static SceneManager getInstance() {
    return instance;
  }
}


final static class EmptyScene extends Scene {
  EmptyScene(){
    super("_empty");
  }
}
