//プレイヤー
class SokonKun {
  float bodyWidth = 1;
  color bodyColor;

  final float LEGS_STRENGTH = sq(bodyWidth)*0.6;
  final float FOOT_STRENGTH = sq(bodyWidth)*0.3;

  FCircle 
    body, 
    leftEye, leftHand, leftKnee, leftFoot, 
    rightEye, rightHand, rightKnee, rightFoot;

  FRevoluteJoint 
    body_leftEye_revo, body_leftHand_revo, body_leftKnee_revo, 
    body_rightEye_revo, body_rightHand_revo, body_rightKnee_revo;

  FDistanceJoint
    leftKnee_leftFoot_dist, rightKnee_rightFoot_dist;

  PImage leftArmImg, rightArmImg, leftThighImg, rightThighImg, leftLegImg, rightLegImg;

  public SokonKun(float _x, float _y, color _c) {
    bodyColor = _c;
    createShape(_x, _y, bodyWidth, _c);
    // body.setRotation(PI/70);
  }

  public float getX() {
    return body.getX();
  }

  public float getY() {
    return body.getY();
  }

  public float getVelocityX() {
    return body.getVelocityX();
  }

  public float getVelocityY() {
    return body.getVelocityY();
  }

  public color getBodyColor() {
    return bodyColor;
  }

  public void closeKnees() {
    float strength = LEGS_STRENGTH;

    float leftKneeTheta = atan2(leftKnee.getY()-body_leftKnee_revo.getAnchorY(), leftKnee.getX()-body_leftKnee_revo.getAnchorX());
    leftKnee.addForce(
      strength*cos(leftKneeTheta-PI/2), 
      strength*sin(leftKneeTheta-PI/2)
      );

    float rightKneeTheta = atan2(rightKnee.getY()-body_rightKnee_revo.getAnchorY(), rightKnee.getX()-body_rightKnee_revo.getAnchorX());
    rightKnee.addForce(
      -strength*cos(rightKneeTheta-PI/2), 
      -strength*sin(rightKneeTheta-PI/2)
      );
  }

  public void openKnees() {
    float strength = LEGS_STRENGTH;

    float leftKneeTheta = atan2(leftKnee.getY()-body_leftKnee_revo.getAnchorY(), leftKnee.getX()-body_leftKnee_revo.getAnchorX());
    leftKnee.addForce(
      -strength*cos(leftKneeTheta-PI/2), 
      -strength*sin(leftKneeTheta-PI/2)
      );

    float rightKneeTheta = atan2(rightKnee.getY()-body_rightKnee_revo.getAnchorY(), rightKnee.getX()-body_rightKnee_revo.getAnchorX());
    rightKnee.addForce(
      sq(bodyWidth)*0.55*cos(rightKneeTheta-PI/2), 
      sq(bodyWidth)*0.55*sin(rightKneeTheta-PI/2)
      );
  }

  public void closeFeet() {
    float strength = FOOT_STRENGTH;

    float leftFootTheta = atan2(leftFoot.getY()-leftKnee.getY(), leftFoot.getX()-leftKnee.getX());
    leftFoot.addForce(
      strength*cos(leftFootTheta-PI/2), 
      strength*sin(leftFootTheta-PI/2)
      );

    float rightFootTheta = atan2(rightFoot.getY()-rightKnee.getY(), rightFoot.getX()-rightKnee.getX() );
    rightFoot.addForce(
      -strength*cos(rightFootTheta-PI/2), 
      -strength*sin(rightFootTheta-PI/2)
      );
  }

  public void openFeet() {
    float strength = FOOT_STRENGTH;

    float leftFootTheta = atan2(leftFoot.getY()-leftKnee.getY(), leftFoot.getX()-leftKnee.getX());
    leftFoot.addForce(
      -strength*cos(leftFootTheta-PI/2), 
      -strength*sin(leftFootTheta-PI/2)
      );

    float rightFootTheta = atan2(rightFoot.getY()-rightKnee.getY(), rightFoot.getX()-rightKnee.getX() );
    rightFoot.addForce(
      strength*cos(rightFootTheta-PI/2), 
      strength*sin(rightFootTheta-PI/2)
      );
  }

  public boolean isGameOver(FBody body) {
    return (body == leftHand || body == rightHand);
  }

  public void drawJointTextures() {
    drawJointTexture(leftArmImg, leftHand, body_leftHand_revo);
    drawJointTexture(rightArmImg, rightHand, body_rightHand_revo);
    drawJointTexture(leftThighImg, leftKnee, body_leftKnee_revo);
    drawJointTexture(rightThighImg, rightKnee, body_rightKnee_revo);
    drawJointTexture(leftLegImg, leftKnee, leftFoot);
    drawJointTexture(rightLegImg, rightKnee, rightFoot);
  }

  public void attachTextures(PImage bodyImg, PImage leftEyeImg, PImage rightEyeImg, PImage leftHandImg, PImage rightHandImg, PImage leftKneeImg, PImage rightKneeImg, PImage leftFootImg, PImage rightFootImg) {
    body.attachImage(bodyImg);
    leftEye.attachImage(leftEyeImg);
    rightEye.attachImage(rightEyeImg);
    leftHand.attachImage(leftHandImg);
    rightHand.attachImage(rightHandImg);
    leftKnee.attachImage(leftKneeImg);
    rightKnee.attachImage(rightKneeImg);
    leftFoot.attachImage(leftFootImg);
    rightFoot.attachImage(rightFootImg);
  }

  public void attachTexturesToJoints(PImage leftArmImg, PImage rightArmImg, PImage leftThighImg, PImage rightThighImg, PImage leftLegImg, PImage rightLegImg) {
    this.leftArmImg = leftArmImg;
    this.rightArmImg = rightArmImg;
    this.leftThighImg = leftThighImg;
    this.rightThighImg = rightThighImg;
    this.leftLegImg = leftLegImg;
    this.rightLegImg = rightLegImg;
  }

  /*
	public void resetForcesFromKnees() {
   		leftKnee.resetForces();
   		rightKnee.resetForces();
   	}
   
   	public void resetForcesFromFeet() {
   		leftFoot.resetForces();
   		rightFoot.resetForces();
   	}
   
   	private boolean isOverMaxForce(FBody body1, FBody body2) {
   		float theta = atan2(body1.getY()-body2.getY(), body1.getX()-body2.getX());
   		float forceX = body1.getForceX();
   		float forceY = body1.getForceY();
   		println("(" + forceX + ", " + forceY + ")");
   		return (abs(forceX) > bodyW*1000*cos(theta-PI/2) || abs(forceY) > bodyW*1000*sin(theta-PI/2));
   	}
   
   	private boolean isOverMaxForce(FBody body, FRevoluteJoint joint) {
   		float theta = atan2(body.getY()-joint.getAnchorY(), body.getX()-joint.getAnchorX());
   		float forceX = body.getForceX();
   		float forceY = body.getForceY();
   		println("(" + forceX + ", " + forceY + ")");
   		return (abs(forceX) > bodyW*1000*cos(theta-PI/2) || abs(forceY) > bodyW*1000*sin(theta-PI/2));
   	}
   */

  private void drawJointTexture(PImage texture, FBody body, FRevoluteJoint joint) {
    pushMatrix();
    float bodyX = body.getX();
    float bodyY = body.getY();
    float jointX = joint.getAnchorX();
    float jointY = joint.getAnchorY();
    float textureX = (bodyX + jointX)/2;
    float textureY = (bodyY + jointY)/2;
    //PImage newTexture = texture.copy();

    translate(textureX, textureY);
    rotate(atan2(jointY-bodyY, jointX-bodyX));
    imageMode(CENTER);
    //image(newTexture, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }

  private void drawJointTexture(PImage texture, FBody body1, FBody body2) {
    pushMatrix();
    float body1X = body1.getX();
    float body1Y = body1.getY();
    float body2X = body2.getX();
    float body2Y = body2.getY();
    float textureX = (body1X + body2X)/2;
    float textureY = (body1Y + body2Y)/2;
    //PImage newTexture = texture.copy();

    translate(textureX, textureY);
    rotate(atan2(body2Y-body1Y, body2X-body1X));
    imageMode(CENTER);
    //image(newTexture, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }

  private void createShape(float x, float y, float w, color c) {
    body = createCircle(x, y, w, c);

    leftEye = createCircle(
      x+( (w*5/4)/2.0 )*cos(PI*4/3.0), 
      y+( (w*5/4)/2.0 )*sin(PI*4/3.0), 
      w/4.0, 
      c, 
      false
      );

    rightEye = createCircle(
      x+( (w*5/4)/2.0 )*cos(PI*5/3.0), 
      y+( (w*5/4)/2.0 )*sin(PI*5/3.0), 
      w/4.0, 
      c, 
      false
      );

    leftHand = createCircle(
      x-w/2.0 + ( w/sqrt(2)*cos(PI*5/4.0) ), 
      y + w/sqrt(2)*sin(PI*5/4.0), 
      w/6.0, 
      c, 
      true
      );

    rightHand = createCircle(
      x+w/2.0 + ( w/sqrt(2)*cos(PI*7/4.0) ), 
      y + w/sqrt(2)*sin(-PI/4.0), 
      w/6.0, 
      c, 
      true
      );

    leftKnee = createCircle(
      x + (w/2.0)*cos(PI*3/4.0) - w/3.0, 
      y + w/2.0, 
      w/7.0, 
      c
      );

    rightKnee = createCircle(
      x + (w/2.0)*cos(PI/4.0) + w/3.0, 
      y + w/2.0, 
      w/7.0, 
      c
      );

    leftFoot = createCircle(
      leftKnee.getX()-w/4.0, 
      leftKnee.getY()+w/2.0, 
      w*0.15, 
      c, 
      false
      );

    rightFoot = createCircle(
      rightKnee.getX()+w/4.0, 
      rightKnee.getY()+w/2.0, 
      w*0.15, 
      c, 
      false
      );

    body_leftEye_revo = createRevoluteJoint(
      body, 
      leftEye, 
      x + (w/2.0)*cos(PI*4/3.0), 
      y + (w/2.0)*sin(PI*4/3.0)
      );

    body_rightEye_revo = createRevoluteJoint(
      body, 
      rightEye, 
      x + (w/2.0)*cos(PI*5/3.0), 
      y + (w/2.0)*sin(PI*5/3.0)
      );

    body_leftHand_revo = createRevoluteJoint(
      body, 
      leftHand, 
      x-w*0.45, 
      y, 
      -PI/6, 
      PI/6
      );

    body_rightHand_revo = createRevoluteJoint(
      body, 
      rightHand, 
      x+w*0.4, 
      y, 
      -PI/6, 
      PI/6
      );

    body_leftKnee_revo = createRevoluteJoint(
      body, 
      leftKnee, 
      x + (w*0.5)*cos(PI*0.75), 
      y + (w*0.6)*sin(PI*0.75)
      );

    body_rightKnee_revo = createRevoluteJoint(
      body, 
      rightKnee, 
      x + (w*0.5)*cos(PI/4.0), 
      y + (w*0.6)*sin(PI/4.0)
      );

    leftKnee_leftFoot_dist = createDistanceJoint(leftKnee, leftFoot);
    rightKnee_rightFoot_dist = createDistanceJoint(rightKnee, rightFoot);
  }

  private FCircle createCircle(float x, float y, float w, color c) {
    return createCircle(x, y, w, c, true);
  }

  private FCircle createCircle(float x, float y, float w, color c, boolean rotatable) {
    FCircle circle = new FCircle(w);
    circle.setPosition(x, y);
    circle.setFillColor(c);
    circle.setNoStroke();
    circle.setRotatable(rotatable);
    world.add(circle);
    return circle;
  }

  private FRevoluteJoint createRevoluteJoint(FBody body1, FBody body2, float x, float y) {
    FRevoluteJoint joint = new FRevoluteJoint(body1, body2, x, y);
    joint.setDrawable(false);
    world.add(joint);
    return joint;
  }

  private FRevoluteJoint createRevoluteJoint(FBody body1, FBody body2, float x, float y, float lowerAngle, float upperAngle) {
    FRevoluteJoint joint = createRevoluteJoint(body1, body2, x, y);
    joint.setEnableLimit(true);
    joint.setLowerAngle(lowerAngle);
    joint.setUpperAngle(upperAngle);
    return joint;
  }

  private FDistanceJoint createDistanceJoint(FBody body1, FBody body2) {
    FDistanceJoint joint = new FDistanceJoint(body1, body2);
    joint.setDrawable(false);
    world.add(joint);
    return joint;
  }

  private void addBodiesToWorld(FBody[] _bodies) {
    for (FBody b : _bodies) {
      world.add(b);
    }
  }

  private void addJointsToWorld(FJoint[] _joints) {
    for (FJoint j : _joints) {
      world.add(j);
    }
  }
}