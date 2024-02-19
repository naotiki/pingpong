//Sceneを管理する人
class SceneManager {
  SceneManager() {
    EmptyScene es=new EmptyScene();
    registerScene("_empty", es);
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

  //SceneのIDを取得
  String getIdFromScene(Scene scene) {
    for (Map.Entry<String, Scene> entry : allScenes.entrySet()) {
      if (entry.getValue().equals(scene)) {
        return entry.getKey();
      }
    }
    //
    return "_null";
  }
  Scene getSceneById(String id) {
    return allScenes.get(id);
  }
  void registerScene(String id, Scene instance) {
    allScenes.put(id, instance);
  }
  void registerScenes(Map<String, Scene> scenes) {
    allScenes.putAll(scenes);
  }

  private void change(String sceneId, Scene scene) {
    activeScene.sceneDestroy();
    activeScene = scene;
    //旧Sceneの参照が外れるのでGCの実行を提案
    System.gc();
    activeSceneId = sceneId;
    activeScene.sceneSetup();
  }

  void change(String sceneId) {
    println("Loading "+sceneId);
    change(sceneId, getSceneById(sceneId));
  }
  void changeOneshot(Scene scene) {
    String id = "__"+scene.getClass().getSimpleName();
    println("Oneshot Loading "+id);
    change(id, scene);
  }
}


final class EmptyScene extends Scene {
}
