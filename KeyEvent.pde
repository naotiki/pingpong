import java.awt.event.KeyEvent;

//キーイベントをいい感じにこねこねするクラス
final class KeyEventManager {
  //unused?
  static final int KEY_PRESS = 0b001;
  static final int KEY_HOLD = 0b010;
  static final int KEY_RELEASE = 0b100;

  private Map<Integer, Character> keys = new HashMap<>();
  KeyEventManager() {}

  void keyPressed() {
    if (keys.containsKey(keyCode)) {
      return;//Hold
    }
    keys.put(keyCode, key);//Press
  }

  boolean isPressedKeyCode(int keyCode)  {
    return keys.containsKey(keyCode);
  }

  void keyReleased() {
    //Release
    keys.remove(keyCode);
  }
}
