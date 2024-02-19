import java.util.Map;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.Collections;

abstract class Scene extends GameObjectTree {
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

  final Timer timer = new Timer();
  final void sceneSetup() {
    println("Start:main Setup");
    setup();
    setupAll(this);
    println("End:main Setup");
  }
  
  //再帰で全部描画
  final void setupAll(GameObjectTree gameObjectTree) {
    gameObjectTree.childForEach( g -> {
      println("Start:"+g.getClass().getSimpleName()+" Setup");
      if (!g.enabled) return;
      g.setup();
      //子がいるなら
      if (g.hasChildren()) {
        println(g.getClass().getSimpleName()+" has children");
        setupAll(g);
      }
    }
    );
  }
  //再帰で全部描画
  final void drawAll(GameObjectTree gameObjectTree) {
    gameObjectTree.childForEach( g -> {
      if (!g.enabled) return;
      g.drawSelf();
      //子がいるなら
      if (g.hasChildren()) {
        drawAll(g);
      }
    }
    );
  }

  final void sceneUpdate() {
    update();
    timer.update();
    //forEach中にGOが追加されると例外が発生するため追加を一時停止する。
    mouseEventManager.update();
    drawAll(this);
  }
  void sceneDestroy() {
    timer.clear();
    destroy();
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
