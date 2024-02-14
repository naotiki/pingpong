//Nullable
// object 物体の位置
// velocity 物体の移動速度
// target コライダーの原点
// vector コライダーの長さと方向
PVector calcCollisionPoint(PVector object,PVector velocity,PVector target,PVector vector){
    float tan1 = tan(velocity.heading());
    float tan2 = tan(vector.heading());
    Float x=null;
    Float y=null;
    switch (tan1) {
        case 0 :
            y = object.y;
            break;	
        case infinity:
            x = object.x;
            break;
        case -infinity:
            x = - object.x
            break;
    }
    switch (tan2) {
        case 0 :
            if (y!=null) return null;//点ではないので  解無し
            x = (target.y - object.y)/tan1
            y = target.y 
            break;	
        case infinity:
            if (x!=null) return null;//点ではないので  解無し
            x = target.x;
            y = tan1*x+object.y 
            break;
        case -infinity:
            if (x!=null) return null;//点ではないので  解無し
            x = - target.x;
            y = tan1*x+object.y;
            break;
        default :
            if(x!=null){
                y = tan1*x+object.y;
            }else if(y!=null){             
                x=(object.y-target.y)/tan2
            }else{
                x = (target.y-object.y)/(tan1-tan2);
                y = tan1*x+object.y;
            }
        break;	
    }
    // x,yが衝突点候補
    println("x:"+str(x)+", y:"+str(y));
    // ここからはx,yが定義域内か判定
    PVector pos = new PVector(x,y);

    return PVector.dist(object,pos) < velocity.mag() && PVector.dist(target,pos) < vector.mag() ? pos : null;
}