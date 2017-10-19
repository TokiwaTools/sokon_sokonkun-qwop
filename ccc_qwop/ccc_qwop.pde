/*
Q：左太ももを後ろへ、右太ももを前へ (股を閉じる)
W：右太ももを後ろへ、左太ももを前へ (股を開く)
O：左ひざを曲げる
P：右ひざを曲げる
*/

import fisica.*;
import gifAnimation.*;

FWorld world;
FCircle body, leftEye, rightEye, leftHand, rightHand, leftFoot, rightFoot;
FBox leftArm, rightArm, leftThigh, rightThigh, leftLeg, rightLeg;
FRevoluteJoint leftBodyEyeJoint, rightBodyEyeJoint, leftBodyArmJoint, rightBodyArmJoint, leftBodyThighJoint, rightBodyThighJoint, leftHandArmJoint, rightHandArmJoint, leftThighLegJoint, rightThighLegJoint, leftLegFootJoint, rightLegFootJoint;
GifMaker gifMaker;

void setup() {
  fullScreen();
  smooth();

  Fisica.init(this);

  world = new FWorld();
  world.setEdges(-width/2, height, width/2, 80);
  world.setGravity(0, -200);

  createPlayer(0, 100, 480);
/*
  gifMaker = new GifMaker(this, "ss.gif");
  gifMaker.setRepeat(0);
  gifMaker.setDelay(20)
*/
}

void draw() {
  background(255);
  translate(width/2, height);
  scale(1, -1);

  world.step();
  world.draw();
//  gifMaker.addFrame();
}
/*
void stop() {
  gifMaker.finish();
  super.stop();
}
*/
void keyPressed() {
  switch (key) {
    case 'q':
      leftBodyThighJoint.setReferenceAngle(PI/3);
      rightBodyThighJoint.setReferenceAngle(-PI/3);
    break;
    case 'w':
    break;
    case 'o':
    break;
    case 'p':
    break;
  }
}

//x, y: 地上に接する点 足と足の間
//w: bodyの幅
void createPlayer(float x, float y, float w) {
  body = new FCircle(w);
  body.setPosition(x, y + 13.0/12*w);

  leftEye = new FCircle(w/4);
  leftEye.setPosition(x - w*5/16.0, y + (13.0/12+5/16.0*pow(3, 0.5))*w);
  rightEye = new FCircle(w/4);
  rightEye.setPosition(x + w*5/16.0, y + (13.0/12+5/16.0*pow(3, 0.5))*w);

  leftHand = new FCircle(w/6);
  leftHand.setPosition(x - w, y + 19.0/12*w);
  rightHand = new FCircle(w/6);
  rightHand.setPosition(x + w, y + 19.0/12*w);

  leftArm = new FBox(w/2*pow(2, 0.5), 15);
  leftArm.setPosition(x - w*3/4.0, y + 4.0/3*w);
  leftArm.setRotation(-PI/4);
  
  rightArm = new FBox(w/2*pow(2, 0.5), 15);
  rightArm.setPosition(x + w*3/4.0, y + 4.0/3*w);
  rightArm.setRotation(PI/4);

  leftThigh = new FBox(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 15);
  leftThigh.setPosition(x - (pow(2, 0.5)/4+1.0/6)*w, y + (20-3*pow(2, 0.5))/24*w);
  leftThigh.setRotation(atan((6-3*pow(2, 0.5))/4));
  rightThigh = new FBox(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 15);
  rightThigh.setPosition(x + (pow(2, 0.5)/4+1.0/6)*w, y + (20-3*pow(2, 0.5))/24*w);
  rightThigh.setRotation(-atan((6-3*pow(2, 0.5))/4));

  leftLeg = new FBox(pow(5, 0.5)/4*w, 15);
  leftLeg.setPosition(x - (11.0/24+pow(2, 0.5)/4)*w, y + w/3);
  leftLeg.setRotation(atan(2));
  rightLeg = new FBox(pow(5, 0.5)/4*w, 15);
  rightLeg.setPosition(x + (11.0/24+pow(2, 0.5)/4)*w, y + w/3);
  rightLeg.setRotation(-atan(2));

  leftFoot = new FCircle(w/6);
  leftFoot.setPosition(x - (pow(2, 0.5)/4 + 7.0/12)*w, y + w/12);
  rightFoot = new FCircle(w/6);
  rightFoot.setPosition(x + (pow(2, 0.5)/4 + 7.0/12)*w, y + w/12);

  world.add(leftEye);
  world.add(rightEye);
  world.add(leftArm);
  world.add(rightArm);
  world.add(leftHand);
  world.add(rightHand);
  world.add(leftThigh);
  world.add(rightThigh);
  world.add(leftLeg);
  world.add(rightLeg);
  world.add(leftFoot);
  world.add(rightFoot);
  world.add(body);

  leftBodyEyeJoint = new FRevoluteJoint(body, leftEye, x-w/4, y+(13.0/12+pow(3, 0.5)/4)*w);
  leftBodyEyeJoint.setDrawable(false);
  leftBodyEyeJoint.setEnableLimit(true);
  leftBodyEyeJoint.setLowerAngle(0);
  leftBodyEyeJoint.setUpperAngle(0);
  rightBodyEyeJoint = new FRevoluteJoint(body, rightEye, x+w/4, y+(13.0/12+pow(3, 0.5)/4)*w);
  rightBodyEyeJoint.setDrawable(false);
  rightBodyEyeJoint.setEnableLimit(true);
  rightBodyEyeJoint.setLowerAngle(0);
  rightBodyEyeJoint.setUpperAngle(0);

  leftBodyArmJoint = new FRevoluteJoint(body, leftArm, x-w/2, y+13.0/12*w);
  leftBodyArmJoint.setDrawable(false);
  leftBodyArmJoint.setEnableLimit(true);
  leftBodyArmJoint.setLowerAngle(-PI/6);
  leftBodyArmJoint.setUpperAngle(PI/6);
  rightBodyArmJoint = new FRevoluteJoint(body, rightArm, x+w/2, y+13.0/12*w);
  rightBodyArmJoint.setDrawable(false);
  rightBodyArmJoint.setEnableLimit(true);
  rightBodyArmJoint.setLowerAngle(-PI/6);
  rightBodyArmJoint.setUpperAngle(PI/6);

  leftBodyThighJoint = new FRevoluteJoint(body, leftThigh, x-pow(2, 0.5)/4*w, y+(13.0/12-pow(2, 0.5)/4)*w);
  leftBodyThighJoint.setDrawable(false);
  leftBodyThighJoint.setEnableLimit(true);
  leftBodyThighJoint.setLowerAngle(-PI/16);
  leftBodyThighJoint.setUpperAngle(PI/8);
  rightBodyThighJoint = new FRevoluteJoint(body, rightThigh, x+pow(2, 0.5)/4*w, y+(13.0/12-pow(2, 0.5)/4)*w);
  rightBodyThighJoint.setDrawable(false);
  rightBodyThighJoint.setEnableLimit(true);
  rightBodyThighJoint.setLowerAngle(-PI/8);
  rightBodyThighJoint.setUpperAngle(PI/16);

  leftHandArmJoint = new FRevoluteJoint(leftHand, leftArm, x-w, y+19.0/12*w);
  leftHandArmJoint.setDrawable(false);
  leftHandArmJoint.setEnableLimit(true);
  leftHandArmJoint.setLowerAngle(0);
  leftHandArmJoint.setUpperAngle(0);
  rightHandArmJoint = new FRevoluteJoint(rightHand, rightArm, x+w, y+19.0/12*w);
  rightHandArmJoint.setDrawable(false);
  rightHandArmJoint.setEnableLimit(true);
  rightHandArmJoint.setLowerAngle(0);
  rightHandArmJoint.setUpperAngle(0);

  leftThighLegJoint = new FRevoluteJoint(leftThigh, leftLeg, x-(pow(2, 0.5)/4+1.0/3)*w, y+7.0/12*w);
  leftThighLegJoint.setDrawable(false);
  leftThighLegJoint.setEnableLimit(true);
  leftThighLegJoint.setLowerAngle(-PI/16);
  leftThighLegJoint.setUpperAngle(PI/4);
  rightThighLegJoint = new FRevoluteJoint(rightThigh, rightLeg, x+(pow(2, 0.5)/4+1.0/3)*w, y+7.0/12*w);
  rightThighLegJoint.setDrawable(false);
  rightThighLegJoint.setEnableLimit(true);
  rightThighLegJoint.setLowerAngle(-PI/4);
  rightThighLegJoint.setUpperAngle(PI/16);

  leftLegFootJoint = new FRevoluteJoint(leftLeg, leftFoot, x-(pow(2, 0.5)/4+7.0/12)*w, y+w/12);
  leftLegFootJoint.setDrawable(false);
  leftLegFootJoint.setEnableLimit(true);
  leftLegFootJoint.setLowerAngle(0);
  leftLegFootJoint.setUpperAngle(0);
  rightLegFootJoint = new FRevoluteJoint(rightLeg, rightFoot, x+(pow(2, 0.5)/4+7.0/12)*w, y+w/12);
  rightLegFootJoint.setDrawable(false);
  rightLegFootJoint.setEnableLimit(true);
  rightLegFootJoint.setLowerAngle(0);
  rightLegFootJoint.setUpperAngle(0);

  world.add(leftBodyEyeJoint);
  world.add(rightBodyEyeJoint);
  world.add(leftHandArmJoint);
  world.add(rightHandArmJoint);
  world.add(leftBodyArmJoint);
  world.add(rightBodyArmJoint);
  world.add(leftThighLegJoint);
  world.add(rightThighLegJoint);
  world.add(leftLegFootJoint);
  world.add(rightLegFootJoint);
  world.add(leftBodyThighJoint);
  world.add(rightBodyThighJoint);
}

/*

  FDistanceJoint leftBodyEyeJoint = new FDistanceJoint(body, leftEye);
  leftBodyEyeJoint.setCollideConnected(false);
  FDistanceJoint rightBodyEyeJoint = new FDistanceJoint(body, rightEye);
  rightBodyEyeJoint.setCollideConnected(false);

  FDistanceJoint leftHandArmJoint = new FDistanceJoint(leftHand, leftArm);
  leftHandArmJoint.setAnchor2(-pow(2, 0.5)/4*w, 0);
  leftHandArmJoint.setLength(0);
  leftHandArmJoint.setFrequency(0);
  leftHandArmJoint.setCollideConnected(false);
  FDistanceJoint rightHandArmJoint = new FDistanceJoint(rightHand, rightArm);
  rightHandArmJoint.setAnchor2(pow(2, 0.5)/4*w, 0);
  rightHandArmJoint.setLength(0);
  rightHandArmJoint.setFrequency(0);
  rightHandArmJoint.setCollideConnected(false);

  FDistanceJoint leftBodyArmJoint = new FDistanceJoint(body, leftArm);
  leftBodyArmJoint.setAnchor1(-w/2, 0);
  leftBodyArmJoint.setAnchor2(pow(2, 0.5)/4*w, 0);
  leftBodyArmJoint.setLength(0);
  leftBodyArmJoint.setFrequency(0);
  leftBodyArmJoint.setCollideConnected(false);
  FDistanceJoint rightBodyArmJoint = new FDistanceJoint(body, rightArm);
  rightBodyArmJoint.setAnchor1(w/2, 0);
  rightBodyArmJoint.setAnchor2(-pow(2, 0.5)/4*w, 0);
  rightBodyArmJoint.setLength(0);
  rightBodyArmJoint.setFrequency(0);
  rightBodyArmJoint.setCollideConnected(false);

  FDistanceJoint leftBodyThighJoint = new FDistanceJoint(body, leftThigh);
  leftBodyThighJoint.setAnchor1(-pow(2, 0.5)/4*w, -pow(2, 0.5)/4*w);
  leftBodyThighJoint.setAnchor2(0.5*pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 0);
  leftBodyThighJoint.setLength(0);
  leftBodyThighJoint.setFrequency(0);
  leftBodyThighJoint.setCollideConnected(false);
  FDistanceJoint rightBodyThighJoint = new FDistanceJoint(body, rightThigh);
  rightBodyThighJoint.setAnchor1(pow(2, 0.5)/4*w, -pow(2, 0.5)/4*w);
  rightBodyThighJoint.setAnchor2(-0.5*pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 0);
  rightBodyThighJoint.setLength(0);
  rightBodyThighJoint.setFrequency(0);
  rightBodyThighJoint.setCollideConnected(false);

  FDistanceJoint leftThighLegJoint = new FDistanceJoint(leftThigh, leftLeg);
  leftThighLegJoint.setAnchor1(-0.5*pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 0);
  leftThighLegJoint.setAnchor2(pow(5, 0.5)/8*w, 0);
  leftThighLegJoint.setLength(0);
  leftThighLegJoint.setFrequency(0);
  leftThighLegJoint.setCollideConnected(false);
  FDistanceJoint rightThighLegJoint = new FDistanceJoint(rightThigh, rightLeg);
  rightThighLegJoint.setAnchor1(0.5*pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, 0);
  rightThighLegJoint.setAnchor2(-pow(5, 0.5)/8*w, 0);
  rightThighLegJoint.setLength(0);
  rightThighLegJoint.setFrequency(0);
  rightThighLegJoint.setCollideConnected(false);

  FDistanceJoint leftLegFootJoint = new FDistanceJoint(leftLeg, leftFoot);
  leftLegFootJoint.setAnchor1(-pow(5, 0.5)/8*w, 0);
  leftLegFootJoint.setLength(0);
  leftLegFootJoint.setFrequency(0);
  leftLegFootJoint.setCollideConnected(false);
  FDistanceJoint rightLegFootJoint = new FDistanceJoint(rightLeg, rightFoot);
  rightLegFootJoint.setAnchor1(pow(5, 0.5)/8*w, 0);
  rightLegFootJoint.setLength(0);
  rightLegFootJoint.setFrequency(0);
  rightLegFootJoint.setCollideConnected(false);
*/