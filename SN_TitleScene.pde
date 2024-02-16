final class TitleScene extends Scene {
  final Text menuText = new Text(this, screen.posByAnchor(new Rect(0, 50), Anchor.TopCenter), "ここにタイトルを入力", 50, #ffffff);

  final Button startMain = new Button(this, screen.posByAnchor(new Rect(0, -80, 200, 50), Anchor.MiddleCenter), this, "vs CPU");
  TitleScene() {
  }
  void sceneSetup() {
    startMain.setOnClickListener(()-> {
      sceneManager.changeOneshot(new MainScene());
    }
    );
  }
}
