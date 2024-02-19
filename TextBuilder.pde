
// textをいい感じに配置するクラス
static class UIBuilder {
  final Rect pos;
  final int textSize;
  final color defaultColor;
  final PApplet app;
  UIBuilder(PApplet app, Rect rect, int textSize, color defaultColor) {
    this.app = app;
    pos=rect;
    this.textSize=textSize;
    this.defaultColor=defaultColor;
  }
  private int indent = 0;
  private int lineCount = 0;
  private final float indentUnit = 12;
  private final float lineSpace = 1;
  private final float marginX = 5;
  private final float marginY = 5;
  void text(String text) {
    text(text, defaultColor);
  }
  void text(String text, color textColor) {
    app.textSize(textSize);
    app.fill(textColor);
    app.text(text, pos.x+marginX+indent*indentUnit, pos.y+marginY+lineCount*(lineSpace+textSize));
    lineCount++;
  }
  void indent() {
    indent(1);
  }
  void unindent() {
    indent(-1);
  }
  void indent(int num) {
    if (indent<=0 && num < 0) return;
    indent+=num;
  }
  void removeIndent() {
    indent=0;
  }
}
interface UIBuildFunc {
  void build(UIBuilder u);
}
void column(PApplet app, Rect rect, int textSize, color defaultColor, UIBuildFunc block) {
  UIBuilder builder = new UIBuilder(app, rect, textSize, defaultColor);
  app.textAlign(LEFT, TOP);
  block.build(builder);
}
