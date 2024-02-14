final class Area extends Pointerble implements IGameObjectTree {
    color bgColor;
    List<GameObject> children = new ArrayList<GameObject>();
    void addChild(GameObject child){
        children.add(child);
    }
    List<GameObject> getChildren(){
        return children;
    }
    
    Area(IGameObjectTree parent,Rect rect,Scene scene,color bgColor){
        super(parent,rect,scene);
        this.bgColor = bgColor;
    }
    Area(Scene scene,Rect rect,color bgColor){
        this(scene,rect,scene,bgColor);
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