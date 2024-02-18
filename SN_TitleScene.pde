final class TitleScene extends Scene {
  final Text menuText = new Text(this, screen.posByAnchor(new Rect(0, 50), Anchor.TopCenter), "TODO: ここにタイトルを入力", 50, #ffffff);
  final Button start2P = new Button(this, screen.posByAnchor(new Rect(0, -80, 200, 50), Anchor.MiddleCenter), this, "vs 2P");
  final Button startCPU = new Button(this, screen.posByAnchor(new Rect(0, 0, 200, 50), Anchor.MiddleCenter), this, "vs CPU");
  final Button config = new Button(this, screen.posByAnchor(new Rect(0, 80, 200, 50), Anchor.MiddleCenter), this, "ゲーム設定");
  TitleScene() {
  }
  void setup() {
    start2P.setOnClickListener(()-> {
      sceneManager.changeOneshot(new MainScene());
    }
    );
  }
}
