final class Area extends GameObject {
    color bgColor;
    Area(Scene scene,Rect rect,color bgColor){
        super(scene,rect);
        this.bgColor = bgColor;
    }
    void draw(){
        fill(bgColor);
        rect(rect.x,rect.y,rect.w,rect.h);
    }

    Rect posByAnchor(Rect rect, Anchor anchor){
        return this.rect.posByAnchor(rect,anchor);
    }
    float centerX(){
        return rect.centerX();
    }
    float centerY(){
        return rect.centerY();
    }
}