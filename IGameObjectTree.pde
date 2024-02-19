import java.util.function.Function;
interface IGameObjectTree {
  void addChild(GameObject gameObject);
  //void removeChild(GameObject gameObject);
  List<GameObject> getChildren();
}


abstract class GameObjectTree {
  private boolean isLocked=false;
  private final List<GameObject> gameObjects = new ArrayList<GameObject>();
  private final List<GameObject> addGameObjects = new ArrayList<GameObject>();
  private final List<GameObject> removeGameObjects = new ArrayList<GameObject>();
  final void addChild(GameObject go) {
    if (isLocked) {
      addGameObjects.add(go);
    } else {
      gameObjects.add(go);
    }
  }

  final void removeChild(GameObject go) {
    if (isLocked) {
      removeGameObjects.add(go);
    } else {
      gameObjects.remove(go);
    }
  }

  final void childForEach(Consumer<GameObject> func) {
    lock();
    ((List<GameObject>)((ArrayList<GameObject>)gameObjects).clone()).forEach(g->func.accept(g));
    unlock();
  }

  final List<GameObject> getChildren() {
    return gameObjects;
  }

  final boolean hasChildren() {
    return gameObjects.size()>0;
  }

  private final void lock() {
    isLocked=true;
  }
  private final void unlock() {
    isLocked=false;
    gameObjects.addAll(addGameObjects);
    removeGameObjects.forEach(g-> {
      gameObjects.remove(g);
    }
    );
    addGameObjects.clear();
    removeGameObjects.clear();
  }
}
