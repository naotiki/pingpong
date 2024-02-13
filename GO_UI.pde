final class Button extends GameObject {
  
  static final int TEXTCOLOR_DEFAULT =0xff;
  static final int COLOR_HOVER = 0xee;
  static final int COLOR_PRESS = 0xbb;

  private Text tmp;
  private OnClickListner listener;
  Button(Scene scene, Rect rect,String text,OnClickListner listener) {
    super(scene, rect);
    tmp = new Text(scene, rect.posByAnchor(new Rect(0,0,rect.w,rect.h),Anchor.MiddleCenter), text);
    this.listener = listener;
  }
  Button(Scene scene, Rect rect,String text) {
    this(scene, rect,text,null);
  }
  void setup(){
  }
  private boolean mousePressing = false;
  void draw(){
    if (mousePressed) {
      if(!mousePressing&&isMouseOver()){
        mousePressing = true;
      }
    }else {
      if(mousePressing){
        if(listener!=null) listener.onClicked();
      }
      mousePressing = false;
    }
    rectMode(CORNER);
    strokeWeight(1);
    if(mousePressing){
      fill(COLOR_PRESS);
    }else if(isMouseOver()) {
      fill(COLOR_HOVER);
    } else {
      fill(TEXTCOLOR_DEFAULT);
    }
    rect(rect.x,rect.y,rect.w,rect.h,12); 
  }

  boolean isMouseOver()  {
    return mouseX >= rect.x && mouseX <= rect.x+rect.w && mouseY >= rect.y && mouseY <= rect.y+rect.h;
  }
  void setOnClickListener(OnClickListner listener){
    this.listener = listener;
  }
}

final class Text extends GameObject {
  private static final int TEXTSIZE_DEFAULT = 32;
  private static final color TEXTCOLOR_DEFAULT = #000000;
  String text;
  int textSize = TEXTSIZE_DEFAULT;
  color textColor = TEXTCOLOR_DEFAULT;
  Text(Scene scene, Rect rect, String text) {
    this(scene, rect,text,TEXTSIZE_DEFAULT,TEXTCOLOR_DEFAULT);
  }
  Text(Scene scene, Rect rect, String text,int textSize,color textColor) {
    super(scene, rect);
    this.text = text;
    this.textSize = textSize;
    this.textColor = textColor;
  }
  void draw(){
    textAlign(CENTER, CENTER);
    fill(textColor);
    textSize(textSize);
    if(rect.w==0&&rect.h==0){
      text(text, rect.x, rect.y);
    }else{
      text(text, rect.x, rect.y,rect.w,rect.h);
    }
  }
}

interface OnClickListner{
  void onClicked();
}