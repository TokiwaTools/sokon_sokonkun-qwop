// 参考：http://r-dimension.xsrv.jp/classes_j/noise/
import fisica.*;


FWorld world;
SokonKun sokonKun;

void setup() {
  size(800, 600);
  Fisica.init(this);
  world = new FWorld(0, 0, width, height);
  world.setEdges(0, 0, width, height, color(0, 0, 0, 0));

  sokonKun = new SokonKun(20, 20, #000000);
  PImage bodyImg = loadImage("body.png");

  float characterScale = 10/bodyImg.height;

  //sokonKun.attachTextures(
  //  loadTexture("body.png", characterScale*1.05), 
  //  loadTexture("left_eye.png", characterScale), loadTexture("right_eye.png", characterScale), 
  //  loadTexture("left_hand.png", characterScale), loadTexture("right_hand.png", characterScale), 
  //  loadTexture("left_hand.png", characterScale), loadTexture("right_hand.png", characterScale), 
  //  loadTexture("left_foot.png", characterScale), loadTexture("right_foot.png", characterScale)
  //  );
  //sokonKun.attachTexturesToJoints(
  //  loadTexture("left_arm.png", characterScale*1.3, characterScale), loadTexture("right_arm.png", characterScale*1.55, characterScale), 
  //  loadTexture("left_leg.png", characterScale*1.1, characterScale), loadTexture("right_leg.png", characterScale*1.1, characterScale), 
  //  loadTexture("left_leg.png", characterScale*1.8, characterScale), loadTexture("right_leg.png", characterScale*1.9, characterScale)
  //  );
}

void draw() {
  background(100);

  float y = 0;
  for (int x=0; x<=width; x++) {
    stroke(200, 200, 0);
    line(x, height, x, height-noise(y)*height/2);

    if (x==width*3/7 || x==width*5/7 || x==width*6/7) {
      fill(200, 200, 0);

      rectMode(CORNERS);
      rect(x, height-noise(y)*height/2, x+50, height);
      rectMode(CORNER);

      stroke(random(200, 255));

      strokeWeight(3);
      line(x, height-noise(y)*height/2, x+50, height-noise(y)*height/2);
      strokeWeight(1);

      x += 50;
    }

    y += 0.01;
  }

  sokonKun.drawJointTextures();
  world.step();
  world.draw();
}


//PImage loadTexture(String path, float scale) {
//  PImage texture = loadImage(path);
//  texture.resize((int)(texture.width*scale), (int)(texture.height*scale));
//  return texture;
//}

//PImage loadTexture(String path, float widthScale, float heightScale) {
//  PImage texture = loadImage(path);
//  texture.resize((int)(texture.width*widthScale), (int)(texture.height*heightScale));
//  return texture;
//}