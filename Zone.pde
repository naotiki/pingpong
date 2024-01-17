class Zone extends GameObject {
  private Map<GameObject,CollisionListener > targets = new HashMap<>();
  Zone(Scene scene, float x, float y,float w,float h){
    super(scene,x,y,w,h);
  }
  
  
  void draw(){
    
  }




}


interface CollisionListener{
  void onCollision();
}
