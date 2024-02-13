final class Button extends GameObject {
  static final int COLOR_DEFAULT =0xff;
  static final int COLOR_HOVER =0xee;
  static final int COLOR_PRESS =0xbb;
  Text tmp;
  Button(Scene scene, Rect rect,String text) {
    super(scene, rect);
    tmp = new Text(scene, rect.posByAnchor(new Rect(0,0,rect.w,rect.h),Anchor.MiddleCenter), text);
  }
  void setup(){
  }
  private boolean mousePressing = false;
  void draw(){
    if (mousePressed) {
      if(!mousePressing&&isMouseOver()){
        println("Button Clicked");
        mousePressing = true;
      }
    }else {
      mousePressing = false;
    }
    rectMode(CORNER);
    strokeWeight(1);
    if(mousePressing){
      fill(COLOR_PRESS);
    }else if(isMouseOver()) {
      fill(COLOR_HOVER);
    } else {
      fill(COLOR_DEFAULT);
    }
    rect(rect.x,rect.y,rect.w,rect.h,12); 
  }

  boolean isMouseOver()  {
    return mouseX >= rect.x && mouseX <= rect.x+rect.w && mouseY >= rect.y && mouseY <= rect.y+rect.h;
  }
}
final class Text extends GameObject {
  private static final int TEXTSIZE_DEFAULT = 32;
  String text;
  int textSize=TEXTSIZE_DEFAULT;
  Text(Scene scene, Rect rect, String text) {
    this(scene, rect,text,TEXTSIZE_DEFAULT);
  }
  Text(Scene scene, Rect rect, String text,int textSize) {
    super(scene, rect);
    this.text = text;
    this.textSize = textSize;
  }
  void draw(){
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(textSize);
    text(text, rect.x, rect.y,rect.w,rect.h);
  }
}