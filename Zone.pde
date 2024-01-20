class Zone extends GameObject {
  private Map<GameObject,CollisionListener > targets = new HashMap<>();
  Zone(Scene scene, float x, float y,float w,float h){
    super(scene,x,y,w,h);
  }
  
  
  void draw(){
    targets.forEach((target,listener)->{
      if(target.isCollision(this)){
        listener.onCollision();
      }
    });
  }

  void addTarget(GameObject target,CollisionListener listener){
    targets.put(target,listener);
  }




}


interface CollisionListener{
  void onCollision();
}
