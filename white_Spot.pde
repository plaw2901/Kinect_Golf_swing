// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/1scFcY-xMrI

class White_spot {
  PVector center;
  int max_dist;
  ArrayList<PVector> points;

  White_spot(float x, float y,int max_distance) {
    center = new PVector(x,y);
    max_dist = max_distance;
    points = new ArrayList<PVector>();
    points.add(center);
  }

  void add(float x, float y) {
    points.add(new PVector(x, y));
    center.x = (center.x + x)/2;
    center.y = (center.y + y)/2;
  }

  PVector get_center(){
    return center;
  }
  
  int get_size(){
    return points.size();
  }
    
  boolean isNear(float x, float y) {

    for (PVector v : points) {
      float tempD = dist(x, y, v.x, v.y);
      if (tempD < max_dist) {
        this.add(x,y);
        return true;
      }
    }
    return false;
  }
}
