import java.util.TreeMap;
//タイマー
class Timer {
  private TreeMap<Long, TimeoutListener> timeouts=new TreeMap<Long, TimeoutListener>();
  // millis後にfuncを実行
  void setTimeout(long millis, TimeoutListener func) {
    timeouts.put(millis+System.currentTimeMillis(), func);
  }
  // タイマーをすべてキャンセル
  void clear() {
    timeouts.clear();
  }

  // タイマーを更新
  void update() {
    long currentTime=System.currentTimeMillis();
    for (long key : ((Map<Long, TimeoutListener>)timeouts.clone()).keySet()) {
      if (key<=currentTime) {
        timeouts.get(key).onTimeout();
        timeouts.remove(key);
      } else {
        return;
      }
    }
  }
}

interface TimeoutListener {
  void onTimeout();
}
