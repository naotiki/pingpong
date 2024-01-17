import java.awt.event.KeyEvent;
final KeyEventManager keyEventManager=new KeyEventManager();

final class KeyEventManager {
  static final int KEY_PRESS = 0b001;
  static final int KEY_HOLD = 0b010;
  static final int KEY_RELEASE = 0b100;

  private Map<Integer, Character> keys = new HashMap<>();
  KeyEventManager() {
  }

  void keyPressed() {
    if (keys.containsKey(keyCode)) {
      return;//Hold
    }
    keys.put(keyCode, key);//Press
  }

  void keyReleased() {
    //Release
    keys.remove(keyCode);
  }
}
