
public  class Paddle extends GameObject { //<>//

  public Paddle(float x,float y){
    super(x,y,5,100);
  }
  
  void draw(){
    strokeWeight(5);
    stroke(0);
    line(x,y,x,y+height);
  }
}
