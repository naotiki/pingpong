import java.lang.Math;
final float error = radians(1);
private PVector calcCrossPoint(PVector object, PVector velocity, PVector target, PVector vector){
  Float tan1 = tan(velocity.heading());
  Float tan2 = tan(vector.heading());//vector.heading()
  Float x=null;
  Float y=null;
  if (tan1 == 0f) {
    y = object.y;
  } else if (tan1.isInfinite() && tan1>0) {
    x = object.x;
  } else if (tan1.isInfinite() && tan1<0) {
    x = - object.x;
  }
  if (tan2==0) {
    if (y!=null) return null;//点ではないので  解無し
    //target.y = tan1*(x-object.x)+object.y
    //target.y = tan1*x-tan1*object.x+object.y
    //target.y+tan1*object.x-object.y=tan1*x
    x=(target.y+tan1*object.x-object.y)/tan1;
    y = target.y;
  } else if (tan2.isInfinite() && tan2>0) {
    if (x!=null) return null;//点ではないので  解無し

    x = target.x;
    y = tan1*(x-object.x)+object.y;
  } else if (tan2.isInfinite() && tan2<0) {
    if (x!=null) return null;//点ではないので  解無し
    x = - target.x;
    y = tan1*(x-object.x)+object.y;
  } else {
    if (x!=null) {
      y = tan1*(x-object.x)+object.y;
    } else if (y!=null) {
      x=(object.y-target.y)/tan2+target.x;
    } else {
      // Solve x
      // tan1(x-object.x)+object.y = tan2(x-target.x)+target.y
      // tan1*x-tan1*object.x+object.y = tan2*x-tan2*target.x+target.y
      // (tan1-tan2)*x = tan1*object.x-object.y-tan2*target.x+target.y
      x = (tan1*object.x-object.y-tan2*target.x+target.y)/(tan1-tan2);
      y = tan1*(x-object.x)+object.y;
    }
  }
  // x,yが衝突点候補
  return new PVector(x,y);
}
//Nullable
// object 物体の位置
// velocity 物体の移動速度
// target コライダーの原点
// vector コライダーの長さと方向
PVector calcCollisionPoint(PVector object, PVector velocity, PVector target, PVector vector) {
  
  //println("x:"+str(x)+", y:"+str(y));
  // ここからはx,yが定義域内か判定
  PVector pos = calcCrossPoint(object,velocity,target,vector);
  /*  println(PVector.sub(pos,object).heading());
   println(velocity.heading());
   println(PVector.sub(pos,target).heading());
   println(vector.heading());
   println(PVector.dist(pos,object));
   println(velocity.mag());
   println(PVector.dist(pos,target));
   println(vector.mag()); */
  return abs(PVector.sub(pos, object).heading() - velocity.heading()) < QUARTER_PI/4 // 速度とオブジェクト→posへの角度が同じ
    && abs(PVector.sub(pos, target).heading() - vector.heading()) < QUARTER_PI/4  // 壁の向きと原点→posの角度が同じ
    && PVector.dist(pos, object) < velocity.mag() //
    && PVector.dist(pos, target) < vector.mag() //
    ? pos : null;
}
//https://www.desmos.com/calculator/tjrvntf1t2
PVector calcCircleCenterOnCollision(PVector object, PVector velocity, PVector target, PVector vector,float radius){
  float angle0=velocity.heading();
  float angle1=vector.heading();
  float angle=angle1-angle0;
  PVector crossPos = calcCrossPoint(object,velocity,target,vector);
  //衝突時の円の中心と交点のずれ dx,dy
  float addX = (radius*cos(angle0+PI))/sin(angle0-angle1);
  float addY = (radius*sin(angle0+PI))/sin(angle0-angle1);
  PVector diff=PVector.sub(object,crossPos);
  //候補
  float xSign=Math.signum(diff.x*addX);
  float ySign=Math.signum(diff.y*addY);
  PVector centerPos =  crossPos.copy().add(addX*xSign,addY*ySign);
  float l= radius*cos(angle)/sin(angle);
  PVector collosionPoint = crossPos.copy().add(l*cos(angle1+PI)*xSign,l*sin(angle1+PI)*ySign);
  //markPoint(centerPos,#ff0000);
  //markPoint(collosionPoint,#00ffff);
  println(PVector.sub(collosionPoint, target).heading());
  return abs(PVector.sub(centerPos, object).heading() - velocity.heading()) <= error// 速度とオブジェクト→posへの角度が同じ
    && abs(PVector.sub(collosionPoint, target).heading() - vector.heading()) <=  error
    && PVector.dist(centerPos,object) <= velocity.mag() 
    && PVector.dist(collosionPoint,target) <= vector.mag() ? centerPos : null;
}
