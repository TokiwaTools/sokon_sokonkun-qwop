// 参考：http://r-dimension.xsrv.jp/classes_j/noise/

float x = 0;
float y = 0;

void setup() {
  size(600, 600);
  background(0);
  stroke(random(255), random(255), random(255));
}

void draw() {
  line(x, 0, x, noise(y)*height);

  y += 0.01;
  x += 1;

  if (x>width) {
    stroke(random(255), random(255), random(255));
    x = 0;
  }
}