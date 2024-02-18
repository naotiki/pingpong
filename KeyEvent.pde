import java.awt.event.KeyEvent;

//キーイベントをいい感じにこねこねするクラス
final class KeyEventManager {


  private Map<Integer, Character> keys = new HashMap<>();
  private List<KeyEventListener> listeners = new ArrayList<KeyEventListener>();
  void addKeyEventListener(KeyEventListener listener){
    listeners.add(listener);
  }
  KeyEventManager() {
  }

  void keyPressed() {
    if (keys.containsKey(keyCode)) {
      return;//Hold
    }
    keys.put(keyCode, key);//Press
    listeners.forEach(l->l.onKeyEvent(KeyEventType.Pressed,keyCode,key));
  }

  boolean isPressKeyCode(int keyCode) {
    return keys.containsKey(keyCode);
  }
  boolean isPressKey(char key) {
    return keys.containsValue(key);
  }

  void keyReleased() {
    //Release
    keys.remove(keyCode);
    listeners.forEach(l->l.onKeyEvent(KeyEventType.Released,keyCode,key));
  }
}

  enum KeyEventType{
    Pressed,
    Hold,
    Released,
  }
interface KeyEventListener {
  void onKeyEvent(KeyEventType type,int keyCode,char key);
}