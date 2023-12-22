class Ball extends GameObject{
  public Ball(float x,float y){
    super(x,y,20,20);
  }
  
  public void draw(){
    fill(0);
    noStroke(); 
    ellipse(x,y,width,height);
  }
}
