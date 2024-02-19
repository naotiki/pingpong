import java.lang.Math;
static class PVectorD {
  double x;
  double y;
  PVectorD(double x, double y) {
    this.x = x;
    this.y = y;
  }
  PVectorD(float x, float y) {
    this.x = ((Float)x).doubleValue();
    this.y = ((Float)y).doubleValue();
  }
  PVectorD(PVector vec) {
    this.x = ((Float)vec.x).doubleValue();
    this.y = ((Float)vec.y).doubleValue();
  }

  double tan() {
    return y/x;
  }


  static PVectorD fromAngle(double angle) {
    return new PVectorD(Math.cos(angle), Math.sin(angle));
  }

  PVectorD setMag(double mag) {
    return this.normalize().mult(mag);
  }


  double mag() {
    return Math.sqrt(x*x + y*y);
  }



  double heading() {
    return Math.atan2(y, x);
  }
  PVectorD normalize() {
    double m = mag();
    if (m != 0 && m != 1) {
      this.div(m);
    }
    return this;
  }
  PVectorD copy() {
    return new PVectorD(x, y);
  }
  PVectorD rotate(double angle) {
    double newx = x*Math.cos(angle) - y*Math.sin(angle);
    double newy = x*Math.sin(angle) + y*Math.cos(angle);
    x = newx;
    y = newy;
    return this;
  }
  PVectorD add(double x, double y) {
    this.x += x;
    this.y += y;
    return this;
  }
  PVectorD mult(double n) {
    this.x *= n;
    this.y *= n;
    return this;
  }
  PVectorD div(double n) {
    this.x /= n;
    this.y /= n;
    return this;
  }
  double betweenAngle(PVectorD v) {
    if (this.x == 0 && this.y == 0) {
      return 0;
    }
    if (v.x == 0 && v.y == 0) {
      return 0;
    }
    double amt = this.dot(v)/(this.mag()*v.mag());
    if (amt <= -1) {
      return Math.PI;
    } else if (amt >= 1) {
      return 0;
    }
    return Math.acos(amt);
  }
  double dot(PVectorD v) {
    return this.x*v.x + this.y*v.y;
  }
  PVector toFloat() {
    return new PVector(((Double)x).floatValue(), ((Double)y).floatValue());
  }
  static PVectorD add(PVectorD a, PVectorD b) {
    return new PVectorD(a.x + b.x, a.y + b.y);
  }
  static PVectorD sub(PVectorD a, PVectorD b) {
    return new PVectorD(a.x - b.x, a.y - b.y);
  }
  static double dist(PVectorD a, PVectorD b) {
    return Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y));
  }
  String toString() {
    return "(" + x + ", " + y + ")";
  }
}
