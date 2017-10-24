/*
Q: 左上に移動 放すと左手を固定
O: 右上に移動 放すと右手を固定
Z: 左下に移動 放すと左足を固定 
M: 右下に移動 放すと右足を固定
*/

import fisica.*;
import gifAnimation.*;

FWorld world;
FCircle body, leftEye, rightEye, leftHand, rightHand, leftKnee, rightKnee, leftFoot, rightFoot;
FDistanceJoint leftArm, rightArm, leftThigh, rightThigh, leftLeg, rightLeg;
FRevoluteJoint leftBodyEyeJoint, rightBodyEyeJoint, leftBodyArmJoint, rightBodyArmJoint, leftBodyThighJoint, rightBodyThighJoint, leftHandArmJoint, rightHandArmJoint, leftThighLegJoint, rightThighLegJoint, leftLegFootJoint, rightLegFootJoint;
GifMaker gifMaker;
float characterWidth = 50;
float moveDistance = characterWidth*50;

void setup() {
  fullScreen();
  smooth();

  Fisica.init(this);

  world = new FWorld();
  world.setEdges(-width/2, height, width/2, 80);
  world.setGravity(0, 0);

  createPlayer(0, height/2, characterWidth);
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

 // world.setGravity(300*cos(PI*frameCount/60), 300*sin(PI*frameCount/60));
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
  float w = characterWidth;
  float d = moveDistance;

//      leftThigh.setForce(leftThigh.getX()+d/pow(2, 0.5), leftThigh.getY()-d/pow(2, 0.5));
//      rightThigh.setForce(rightThigh.getX()-d/pow(2, 0.5), rightThigh.getY()-d/pow(2, 0.5));
//      leftThigh.setForce(leftThigh.getX()-d/pow(2, 0.5), leftThigh.getY()+d/pow(2, 0.5));
//      rightThigh.setForce(rightThigh.getX()+d/pow(2, 0.5), rightThigh.getY()+d/pow(2, 0.5));

  if (!(key == 'q' || key == 'z' || key == 'o' || key == 'm')) return;
  
  leftHand.setStatic(false);
  leftFoot.setStatic(false);
  rightHand.setStatic(false);
  rightFoot.setStatic(false);

  float theta;
  switch (key) {
    case 'q':
      body.setForce(-w*d, w*d);
    break;
    case 'z':
      body.setForce(-w*d, -w*d);
    break;
    case 'o':
      body.setForce(w*d, w*d);
    break;
    case 'm':
      body.setForce(w*d, -w*d);
    break;
  }
}

void keyReleased() {
  switch (key) {
    case 'q':
      leftHand.resetForces();
      leftHand.setStatic(true);
    break;
    case 'z':
      leftFoot.resetForces();
      leftFoot.setStatic(true);
    break;
    case 'o':
      rightHand.resetForces();
      rightHand.setStatic(true);
    break;
    case 'm':
      rightFoot.resetForces();
      rightFoot.setStatic(true);
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
  leftEye.setRotatable(false);
  rightEye = new FCircle(w/4);
  rightEye.setPosition(x + w*5/16.0, y + (13.0/12+5/16.0*pow(3, 0.5))*w);
  rightEye.setRotatable(false);

  leftHand = new FCircle(w/6);
  leftHand.setPosition(x - w, y + 19.0/12*w);
  rightHand = new FCircle(w/6);
  rightHand.setPosition(x + w, y + 19.0/12*w);

  leftArm = new FDistanceJoint(leftHand, body);
  leftArm.setAnchor2(-w/2, 0);
  leftArm.setLength(sqrt(2)/2*w);
  rightArm = new FDistanceJoint(rightHand, body);
  rightArm.setAnchor2(w/2, 0);
  rightArm.setLength(sqrt(2)/2*w);

  leftKnee = new FCircle(w/6);
  leftKnee.setPosition(x - (0.5/sqrt(2)+1.0/3)*w, y + 7.0/12*w);
  rightKnee = new FCircle(w/6);
  rightKnee.setPosition(x + (0.5/sqrt(2)+1.0/3)*w, y + 7.0/12*w);

  leftThigh = new FDistanceJoint(leftKnee, body);
  leftThigh.setAnchor2(-0.5/sqrt(2)*w, -0.5/sqrt(2)*w);
  leftThigh.setLength(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w);
  rightThigh = new FDistanceJoint(rightKnee, body);
  rightThigh.setAnchor2(0.5/sqrt(2)*w, -0.5/sqrt(2)*w);
  rightThigh.setLength(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w);

  leftFoot = new FCircle(w/6);
  leftFoot.setPosition(x - (pow(2, 0.5)/4 + 7.0/12)*w, y + w/12);
  leftFoot.setStatic(true);
  rightFoot = new FCircle(w/6);
  rightFoot.setPosition(x + (pow(2, 0.5)/4 + 7.0/12)*w, y + w/12);

  leftLeg = new FDistanceJoint(leftFoot, leftKnee);
  leftLeg.setLength(pow(5, 0.5)/4*w);
  rightLeg = new FDistanceJoint(rightFoot, rightKnee);
  rightLeg.setLength(pow(5, 0.5)/4*w);

  world.add(leftEye);
  world.add(rightEye);
  world.add(leftArm);
  world.add(rightArm);
  world.add(leftHand);
  world.add(rightHand);
  world.add(leftKnee);
  world.add(rightKnee);
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
/*
  leftBodyArmJoint = new FRevoluteJoint(body, leftArm, x-w/2, y+13.0/12*w);
  leftBodyArmJoint.setDrawable(false);
  leftBodyArmJoint.setEnableLimit(true);
  leftBodyArmJoint.setLowerAngle(0);
  leftBodyArmJoint.setUpperAngle(0);
  rightBodyArmJoint = new FRevoluteJoint(body, rightArm, x+w/2, y+13.0/12*w);
  rightBodyArmJoint.setDrawable(false);
  rightBodyArmJoint.setEnableLimit(true);
  rightBodyArmJoint.setLowerAngle(0);
  rightBodyArmJoint.setUpperAngle(0);

  leftBodyThighJoint = new FRevoluteJoint(body, leftThigh, x-pow(2, 0.5)/4*w, y+(13.0/12-pow(2, 0.5)/4)*w);
  leftBodyThighJoint.setDrawable(false);
  leftBodyThighJoint.setEnableLimit(true);
  leftBodyThighJoint.setLowerAngle(0);
  leftBodyThighJoint.setUpperAngle(0);
  rightBodyThighJoint = new FRevoluteJoint(body, rightThigh, x+pow(2, 0.5)/4*w, y+(13.0/12-pow(2, 0.5)/4)*w);
  rightBodyThighJoint.setDrawable(false);
  rightBodyThighJoint.setEnableLimit(true);
  rightBodyThighJoint.setLowerAngle(0);
  rightBodyThighJoint.setUpperAngle(0);

  leftHandArmJoint = new FRevoluteJoint(leftHand, leftArm, x-w, y+19.0/12*w);
  leftHandArmJoint.setDrawable(false);
  leftHandArmJoint.setEnableLimit(true);
  leftHandArmJoint.setLowerAngle(-PI/3);
  leftHandArmJoint.setUpperAngle(PI/3);
  rightHandArmJoint = new FRevoluteJoint(rightHand, rightArm, x+w, y+19.0/12*w);
  rightHandArmJoint.setDrawable(false);
  rightHandArmJoint.setEnableLimit(true);
  rightHandArmJoint.setLowerAngle(-PI/3);
  rightHandArmJoint.setUpperAngle(PI/3);

  leftThighLegJoint = new FRevoluteJoint(leftThigh, leftLeg, x-(pow(2, 0.5)/4+1.0/3)*w, y+7.0/12*w);
  leftThighLegJoint.setDrawable(false);
  leftThighLegJoint.setEnableLimit(true);
  leftThighLegJoint.setLowerAngle(-PI/3);
  leftThighLegJoint.setUpperAngle(PI/3);

  rightThighLegJoint = new FRevoluteJoint(rightThigh, rightLeg, x+(pow(2, 0.5)/4+1.0/3)*w, y+7.0/12*w);
  rightThighLegJoint.setDrawable(false);
  rightThighLegJoint.setEnableLimit(true);
  rightThighLegJoint.setLowerAngle(-PI/3);
  rightThighLegJoint.setUpperAngle(PI/3);

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
*/
  world.add(leftBodyEyeJoint);
  world.add(rightBodyEyeJoint);
/*  world.add(leftHandArmJoint);
  world.add(rightHandArmJoint);
  world.add(leftBodyArmJoint);
  world.add(rightBodyArmJoint);
  world.add(leftThighLegJoint);
  world.add(rightThighLegJoint);
  world.add(leftLegFootJoint);
  world.add(rightLegFootJoint);
  world.add(leftBodyThighJoint);
  world.add(rightBodyThighJoint);
*/
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