import java.util.TreeMap;
class Timer {
    int time;
    long lastTime;
    TreeMap<Long,TimeoutListener> timeouts=new TreeMap<Long,TimeoutListener>();
    Timer() {
        this.time = 0;
    }
    void setTimeout(long millis,TimeoutListener func){
        timeouts.put(millis+System.currentTimeMillis(),func);
    }

    void clear(){
        timeouts.clear();
    }
    void update(){
        long currentTime=System.currentTimeMillis();
        for(long key:((Map<Long,TimeoutListener>)timeouts.clone()).keySet()){
            if(key<=currentTime){
                timeouts.get(key).onTimeout();
                timeouts.remove(key);
            }else{
                return;
            }
        }
    }
}

interface TimeoutListener {
    void onTimeout();
}