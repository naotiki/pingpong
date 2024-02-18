import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.Collections;

abstract class Scene implements IGameObjectTree {
  //マウスのホバー・クリックを管理する人
  //PointerbleなGOが重なっている場合上に描画されているGOにのみイベントを送信する。
  final class MouseEventManager {
    private List<Pointerble> gameObjects = new ArrayList<Pointerble>();
    MouseEventManager() {
    }
    void add(Pointerble p) {
      gameObjects.add(0, p);
    }
    Pointerble clickingGameObject=null;
    void update() {
      if (clickingGameObject==null) {
        gameObjects.stream()
          .peek(g-> {
          g.isMouseHover = false;
          if (g instanceof Clickable) {
            ((Clickable)g).isMouseClick = false;
          }
        }
        )
        .filter(g->g.enabled && isParentsEnabled(g) && g.rect.isPointWithIn(mouseX, mouseY) )
          .findFirst()
          .ifPresent(g-> {
          if (mousePressed) {
            if (g instanceof Clickable) {
              ((Clickable)g).isMouseClick = true;
            }
            clickingGameObject=g;
            println("clickingGameObject:"+g.getClass().getSimpleName());
          }
          g.isMouseHover = true;
        }
        );
      }else if (!mousePressed&&clickingGameObject!=null) {
        if (clickingGameObject instanceof Clickable) {
          ((Clickable)clickingGameObject).onClicked();
          ((Clickable)clickingGameObject).isMouseClick = false;
          ((Clickable)clickingGameObject).isMouseHover = false;
        }
        clickingGameObject=null;
      }
    }
  }
  final MouseEventManager mouseEventManager = new MouseEventManager();
  void add(Pointerble p) {
    mouseEventManager.add(p);
  }
  private List<GameObject> gameObjects = new ArrayList<GameObject>();
  private List<GameObject> standbyGameObjects = new ArrayList<GameObject>();
  private List<GameObject> removeGameObjects = new ArrayList<GameObject>();
  private boolean isLockedGameObjects = false;
  final void addChild(GameObject go) {
    if (isLockedGameObjects) {
      standbyGameObjects.add(go);
    } else {
      gameObjects.add(go);
    }
  }
  final void removeChild(GameObject go) {
    if (isLockedGameObjects) {
      removeGameObjects.add(go);
    } else {
      gameObjects.remove(go);
    }
  }

  final List<GameObject> getChildren() {
    return gameObjects;
  }


  final void sceneSetup() {
    println("Start:main Setup");
    setup();
    isLockedGameObjects = true;
    setupAll(getChildren());
    isLockedGameObjects = false;
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
    println("End:main Setup");
  }
  
  //再帰で全部描画
  final void setupAll(List<GameObject> children) {
    children.forEach( (g) -> {
      println("Start:"+g.getClass().getSimpleName()+" Setup");
      if (!g.enabled) return;
      g.setup();
      //子がいるなら
      if (g instanceof IGameObjectTree) {
        println(g.getClass().getSimpleName()+" has children");
        setupAll(((IGameObjectTree)g).getChildren() );
      }
    }
    );
  }
  //再帰で全部描画
  final void drawAll(List<GameObject> children) {
    children.forEach( (g) -> {
      if (!g.enabled) return;
      g.drawSelf();
      //子がいるなら
      if (g instanceof IGameObjectTree) {
        drawAll(((IGameObjectTree)g).getChildren() );
      }
    }
    );
  }

  final void sceneUpdate() {
    update();
    //forEach中にGOが追加されると例外が発生するため追加を一時停止する。
    isLockedGameObjects = true;
    mouseEventManager.update();
    drawAll(getChildren());
    isLockedGameObjects = false;
    //追加待ちのGOを一括追加
    gameObjects.addAll(standbyGameObjects);
    standbyGameObjects.clear();
  }
  
  //オーバーライドしてSceneごとのSetupを実行
  void setup() {
  }
  //オーバーライドしてSceneごとのUpdateを実行
  void update() {
  }
  // 非推奨, 代わり → "KeyEventManager"
  void keyPressed() {
  }
  // Sceneを離れるとき すべてを破壊してきれいにする。(クリーンアップ)
  // 本来、オンライン対戦の実装に使用する予定だったが使用することはなかった。
  void destroy() {
  };
}
