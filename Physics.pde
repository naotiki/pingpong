//Nullable
// object 物体の位置
// velocity 物体の移動速度
// target コライダーの原点
// vector コライダーの長さと方向
PVector calcCollisionPoint(PVector object,PVector velocity,PVector target,PVector vector){
    Float tan1 = tan(velocity.heading());
    Float tan2 = tan(vector.heading());//vector.heading()
    Float x=null;
    Float y=null;
    if(tan1 == 0f){
        y = object.y;
    }else if(tan1.isInfinite() && tan1>0){
        x = object.x;
    }else if(tan1.isInfinite() && tan1<0){
        x = - object.x;
    }
    if(tan2==0){
        if (y!=null) return null;//点ではないので  解無し
        //target.y = tan1*(x-object.x)+object.y
        //target.y = tan1*x-tan1*object.x+object.y
        //target.y+tan1*object.x-object.y=tan1*x
        x=(target.y+tan1*object.x-object.y)/tan1;
        y = target.y;
    }else if(tan2.isInfinite() && tan2>0){
        if (x!=null) return null;//点ではないので  解無し
        
        x = target.x;
        y = tan1*(x-object.x)+object.y; 
    }else if(tan2.isInfinite() && tan2<0){
        if (x!=null) return null;//点ではないので  解無し
        x = - target.x;
        y = tan1*(x-object.x)+object.y;
    }else{
        if(x!=null){
            y = tan1*(x-object.x)+object.y;
        }else if(y!=null){ 
            x=(object.y-target.y)/tan2+target.x;
        }else{
            // Solve x
            // tan1(x-object.x)+object.y = tan2(x-target.x)+target.y
            // tan1*x-tan1*object.x+object.y = tan2*x-tan2*target.x+target.y
            // (tan1-tan2)*x = tan1*object.x-object.y-tan2*target.x+target.y
            x = (tan1*object.x-object.y-tan2*target.x+target.y)/(tan1-tan2);
            y = tan1*(x-object.x)+object.y;
        }
    }
    // x,yが衝突点候補
    //println("x:"+str(x)+", y:"+str(y));
    // ここからはx,yが定義域内か判定
    PVector pos = new PVector(x,y);
   /*  println(PVector.sub(pos,object).heading());
    println(velocity.heading());
    println(PVector.sub(pos,target).heading());
    println(vector.heading());
    println(PVector.dist(pos,object));
    println(velocity.mag());
    println(PVector.dist(pos,target));
    println(vector.mag()); */
    return abs(PVector.sub(pos,object).heading() - velocity.heading()) < QUARTER_PI/4 // 速度とオブジェクト→posへの角度が同じ
        && abs(PVector.sub(pos,target).heading() - vector.heading()) < QUARTER_PI/4  // 壁の向きと原点→posの角度が同じ
        && PVector.dist(pos,object) < velocity.mag() // 
        && PVector.dist(pos,target) < vector.mag() //
        ? pos : null;
}