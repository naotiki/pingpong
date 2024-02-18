import java.lang.Math;
// Physics.pde の double版実装。
final double errorD = Math.toRadians(0.1);
private PVectorD calcCrossPointD(PVectorD object, PVectorD velocity, PVectorD target, PVectorD vector){
  Double tan1 = velocity.tan();
  Double tan2 = vector.tan();//vector.heading()
  Double x=null;
  Double y=null;
  if (tan1 == 0.0) {
    y = object.y;
  } else if (tan1.isInfinite() && tan1>0.0) {
    x = object.x;
  } else if (tan1.isInfinite() && tan1<0.0) {
    x = - object.x;
  }
  if (tan2==0.0) {
    if (y!=null) return null;//点ではないので  解無し
    //target.y = tan1*(x-object.x)+object.y
    //target.y = tan1*x-tan1*object.x+object.y
    //target.y+tan1*object.x-object.y=tan1*x
    x=(target.y+tan1*object.x-object.y)/tan1;
    y = target.y;
  } else if (tan2.isInfinite() && tan2>0.0) {
    if (x!=null) return null;//点ではないので  解無し

    x = target.x;
    y = tan1*(x-object.x)+object.y;
  } else if (tan2.isInfinite() && tan2<0.0) {
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
  return new PVectorD(x,y);
}

//https://www.desmos.com/calculator/tjrvntf1t2
PVectorD calcCircleCenterOnCollisionD(PVectorD object, PVectorD velocity, PVectorD target, PVectorD vector,double radius){
  double angle0=velocity.heading();
  double angle1=vector.heading();
  double angle=angle1-angle0;
  if(Math.abs(angle)<errorD) return null;
  PVectorD crossPos = calcCrossPointD(object,velocity,target,vector);
  //衝突時の円の中心と交点のずれ dx,dy
  double addX = (radius*Math.cos(angle0+Math.PI))/Math.sin(angle0-angle1);
  double addY = (radius*Math.sin(angle0+Math.PI))/Math.sin(angle0-angle1);
  PVectorD diff=PVectorD.sub(object,crossPos);
  //候補
  double xSign=Math.signum(diff.x*addX);
  double ySign=Math.signum(diff.y*addY);
  PVectorD centerPos =  crossPos.copy().add(addX*xSign,addY*ySign);
  double l= radius*Math.cos(angle)/Math.sin(angle);
  PVectorD collosionPoint = crossPos.copy().add(l*Math.cos(angle1+Math.PI)*xSign,l*Math.sin(angle1+Math.PI)*ySign);
  //markPoint(centerPos,#ff0000);
  //markPoint(collosionPoint.toFloat(),#00ffff,false);
  
  PVectorD result= Math.abs(PVectorD.sub(centerPos, object).betweenAngle(velocity)) <= errorD// 速度とオブジェクト→posへの角度が同じ
    && Math.abs(PVectorD.sub(collosionPoint, target).betweenAngle(vector)) <=  errorD
    //&& PVectorD.dist(centerPos,collosionPoint) <= radius +0.1*radius

    && PVectorD.dist(centerPos,object) <= velocity.mag() 
    && PVectorD.dist(crossPos,target) <= vector.mag()
    && PVectorD.dist(collosionPoint,target) <= vector.mag() ? centerPos : null;
  if (result!=null&&isDebug) {
    markPoint(result.toFloat(),#00ffff,false);
    println(PVectorD.sub(centerPos, object).betweenAngle(velocity));
    println(PVectorD.sub(collosionPoint, target).betweenAngle(vector));
    println(PVectorD.dist(centerPos,object));
    println(PVectorD.dist(collosionPoint,target));
    println(centerPos);
    println(collosionPoint);
    markPoint(crossPos.toFloat(),#00ffff,false);
    markPoint(collosionPoint.toFloat(),#0000ff,false);
    markPoint(target.toFloat(),#00ff00,false);
    println(vector.mag());
  }
  return result;
}
