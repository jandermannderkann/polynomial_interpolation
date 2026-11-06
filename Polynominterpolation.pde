void setup() {
  size(1920,1080);
  c = new CoordinateSystem(width/2,height/2);
}

CoordinateSystem c;
ArrayList<PVector> anchor = new ArrayList<PVector>();
Polynom p;
int START=5;
int RECTSIZE=6;

void mousePressed() {
  if(anchor.size()>START){
    anchor = new ArrayList<PVector>();
    i=0;
    return;
  }
  int x=mouseX;
  int y=mouseY;
  anchor.add(new PVector(c.rX(x),c.rY(y)));
  print("x"+c.rX(x));
  print("Y"+c.rY(y));
}

int i=0;
void draw() {
  background(200);
  c.draw();
  drawAnchors();
  
  if(anchor.size()>START) {
    if (i==0) {
      p= new Polynom(anchor);
    }
    if (i>100){
      anchor = new ArrayList<PVector>();
      i=0;
      return;
    }
    p.draw();
    delay(100);
    println(i);
    i++;
  }
}

void drawAnchors() {
  int r=RECTSIZE;
  for (PVector p : anchor) {
    
    rect(c.tX((int)p.x-r/2),c.tY((int)p.y-r/2),r,r);
  }
}

class Polynom {
  ArrayList<PVector> anchor;
  int size;
  
  Polynom(ArrayList<PVector> anchor) {
    this.anchor=anchor;
    this.size=anchor.size();
  }
  
  int getY(int x) {
    int sum=0;
    for (int n=0;n<this.size;n++) {
      PVector p=this.anchor.get(n);
      
      sum+=p.y*this.lagrangeP(x,n);
    }
    return sum;
  }
  
  
  float newton(int x) {
    float sum=0;
      for (int n=0;n<this.size;n++) {
        float fn = p.newtonBase(x,n);
        float cn = p.newtonCoefficient(0, n);
        
        sum+=cn*fn;
      }
      return sum;
  }
  
  float newtonCoefficient(int n, int k) {
    if(n==k) {
      return anchor.get(n).y;
    }
    float top = newtonCoefficient(n,k-1)-newtonCoefficient(n+1,k);
    float bot = anchor.get(n).x-anchor.get(k).x;
    return top/bot;
  }
  
  float newtonBase(int x, int n) {
    float sum = 1;
    for (int m=0;m<n;m++) {
        PVector xm=anchor.get(m);
        sum = sum * (x-xm.x);
    }
    return sum;
  }
  
  float lagrangeP(int x, int n) {
    float sum=1;
    PVector xn=anchor.get(n);
    for (int m=0;m<size;m++) {
      if (n!=m) {
        PVector xm=anchor.get(m);
        sum = sum * (x-xm.x) * 1/(xn.x-xm.x);
      }
    }
    return sum;
  }
  
  void draw() {
    c.plot(this);
  }
}
