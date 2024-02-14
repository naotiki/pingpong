final class Button extends Clickable {
  
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
  private boolean mouseHovering = false;
  void draw(){
    rectMode(CORNER);
    strokeWeight(1);
    if(isMouseClick){
      fill(COLOR_PRESS);
    }else if(isMouseHover) {
      fill(COLOR_HOVER);
    } else {
      fill(TEXTCOLOR_DEFAULT);
    }
    rect(rect.x,rect.y,rect.w,rect.h,12); 
    mouseHovering = false;
  }
  boolean isMouseOver()  {
    return mouseX >= rect.x && mouseX <= rect.x+rect.w && mouseY >= rect.y && mouseY <= rect.y+rect.h;
  }
  void setOnClickListener(OnClickListner listener){
    this.listener = listener;
  }
  void onClicked(){
     if(listener!=null) listener.onClicked();
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