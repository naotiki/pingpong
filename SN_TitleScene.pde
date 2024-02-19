final class TitleScene extends Scene {
  final Text menuText = new Text(this, screen.posByAnchor(new Rect(0, 50), Anchor.TopCenter), "テニスゲーム", 50, #ffffff);
  final Button start2P = new Button(this, screen.posByAnchor(new Rect(0, -80, 400, 50), Anchor.MiddleCenter), this, "vs 2P");
  final Button startWeakCPU = new Button(this, screen.posByAnchor(new Rect(0, 0, 400, 50), Anchor.MiddleCenter), this, "vs よわよわ CPU");
  final Button startNormalCPU = new Button(this, screen.posByAnchor(new Rect(0, 80, 400, 50), Anchor.MiddleCenter), this, "vs CPU");
  final Button startStrongCPU = new Button(this, screen.posByAnchor(new Rect(0, 160, 400, 50), Anchor.MiddleCenter), this, "vs つよつよ CPU");
  final Button startSuperStrongCPU = new Button(this, screen.posByAnchor(new Rect(0, 160, 400, 50), Anchor.MiddleCenter), this, "vs 超つよつよ CPU");
  
  TitleScene() {
  }
  void setup() {
    start2P.setOnClickListener(()-> {
      sceneManager.changeOneshot(new TwoPlayerGameScene());
    });
    startWeakCPU.setOnClickListener(()-> {
      sceneManager.changeOneshot(new CPUPlayerGameScene(0.5f));
    });
    startNormalCPU.setOnClickListener(()-> {
      sceneManager.changeOneshot(new CPUPlayerGameScene(1));
    });
    startStrongCPU.setOnClickListener(()-> {
      sceneManager.changeOneshot(new CPUPlayerGameScene(2));
    });
    startSuperStrongCPU.setOnClickListener(()-> {
      sceneManager.changeOneshot(new CPUPlayerGameScene(10));
    });
  }
}
