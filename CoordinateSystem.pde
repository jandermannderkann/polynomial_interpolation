class CoordinateSystem {

  int x;
  int y;
  
  CoordinateSystem (int x, int y) {
    this.x=x;
    this.y=y;
  }
  
  void plot(Polynom p) {
    strokeWeight(1);
    for (int dx=-width/2;dx<width/2;dx++) {
      
      stroke(0);
      line(tX(dx-1),tY(p.getY(dx-1)),tX(dx),tY(p.getY(dx)));
      stroke(0,0,200);
      line(tX(dx-1),tY(p.newton(dx-1)),tX(dx),tY(p.newton(dx)));
      
      for (int n=0;n<anchor.size();n++) {
        stroke(200,0,0);
        point(tX(dx),tY(p.lagrangeP(dx,n)));
      }
      
      for (int n=1;n<anchor.size();n++) {
        stroke(0,200,0);
        float ny=p.newtonBase(dx,n);
        ny = ny * p.newtonCoefficient(0, n);
        point(tX(dx),tY(ny));
      }
    }
    strokeWeight(1);
  }
  //from coordinate-space to display-space
  int tX(int rx) {
    return rx+x;
  }
  
  int tY(int ry) {
    return ry+y;
  }
  float tY(float ry) {
    return ry+y;
  }
  //from display-space to coordinate-space
  // x=20 -> x=-480 
  int rX(int rx) {
    if (rx<this.x) {
      return -(this.x-rx);
    }
    return rx-this.x;
  }
  
  int rY(int ry) {
    if (ry<this.y) {
      return -(this.y-ry);
    }
    return ry-this.y;
  }
  
  void draw() {
    stroke(0);
    line(0,this.y,width,this.y);
    line(this.x,height,this.x,0);
    
    for (int d=0;d<width;d+=10) {
       line(x+5,d,x-5,d);
       line(d,y-5,d,y+5);
    }
  }
}
