//オブジェクト

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

  leftArm = new FBox(w/2*pow(2, 0.5), w/12);
  leftArm.setPosition(x - w*3/4.0, y + 4.0/3*w);
  leftArm.setRotation(-PI/4);
  
  rightArm = new FBox(w/2*pow(2, 0.5), w/12);
  rightArm.setPosition(x + w*3/4.0, y + 4.0/3*w);
  rightArm.setRotation(PI/4);

  leftThigh = new FBox(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, w/12);
  leftThigh.setPosition(x - (pow(2, 0.5)/4+1.0/6)*w, y + (20-3*pow(2, 0.5))/24*w);
  leftThigh.setRotation(atan((6-3*pow(2, 0.5))/4));
  rightThigh = new FBox(pow(1.0/9+(6-4*pow(2, 0.5))/16, 0.5)*w, w/12);
  rightThigh.setPosition(x + (pow(2, 0.5)/4+1.0/6)*w, y + (20-3*pow(2, 0.5))/24*w);
  rightThigh.setRotation(-atan((6-3*pow(2, 0.5))/4));

  leftLeg = new FBox(pow(5, 0.5)/4*w, w/12);
  leftLeg.setPosition(x - (11.0/24+pow(2, 0.5)/4)*w, y + w/3);
  leftLeg.setRotation(atan(2));
  rightLeg = new FBox(pow(5, 0.5)/4*w, w/12);
  rightLeg.setPosition(x + (11.0/24+pow(2, 0.5)/4)*w, y + w/3);
  rightLeg.setRotation(-atan(2));

  leftFoot = new FCircle(w/6);
  leftFoot.setPosition(x - (pow(2, 0.5)/4 + 7.0/12)*w, y + w/12);
  leftFoot.setStatic(true);
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

//ゴミ箱(前)の描画 (x,y: 中央座標 d:倍率 r:回転角度(π) h,s,b:HSB色 dcsn:ゴミ箱2に変更のフラグ)
void drawBoxFront(float x, float y, float d, float r, int h, int s, int b) {
	pushMatrix();
	translate(x, y);
	rotate(r);
	scale(d);

	colorMode(HSB, 100, 100, 100);
	color color1 = color(h, s, b);
	color color2 = color(h, s, b-31);
	color color3 = color(h, s, b-56);

	strokeJoin(ROUND);
	strokeCap(ROUND);

	fill(color1);
	noStroke();
	quad(280, -305, -280, -305, -200, 350, 200, 350);

	fill(color2);
	ellipse(0, 350, 400, 95);

	fill(color1);
	strokeWeight(8);
	stroke(color1);
	noFill();
	for (int i = 0; i < 6; i++) {
		arc(0, -372+i*6, 620+i*2, 150, radians(3), radians(177));
	}
	for (int i = 0; i < 10; ++i) {
		arc(0, -380, 616-i*6, 154-i*5, radians(3), radians(177));
	}
	stroke(0);
	arc(0, -342, 640, 150, radians(3), radians(177));
	arc(0, -372, 625, 142, radians(3), radians(177));
	arc(0, -380, 545, 100, radians(3), radians(177));

	stroke(0);
	line(280, -305, 200, 350);
	line(-280, -305, -200, 350);

	fill(color1);
	line(-315, -370, -320, -338);
	line(315, -370, 320, -338);
	noStroke();
	ellipse(0, 330, 394, 95);
	stroke(0);
	arc(0, 330, 402, 100, radians(10), radians(170));
	noFill();
	arc(0, 346, 402, 100, radians(10), radians(170));
	fill(color1);
	strokeWeight(8);
	stroke(0);
	ellipse(0, -376, 630, 160);
	fill(color3);
	ellipse(0, -384, 540, 120);

	fill(color2);
	quad(-210, -240, -140, -230, -90, 372, -150, 362);
	quad(210, -240, 140, -230, 90, 372, 150, 362);
	rect(-35, 378, 70, -600);

	fill(#F6C06A);
	stroke(0);
	strokeWeight(5);
	quad(-200, -50, 200, -50, 190, 50, -190, 50);

	colorMode(RGB, 255, 255, 255);
	popMatrix();
}

//ゴミ袋 (x,y: 中心座標 r:回転角度(π))
void drawGarbage(float x, float y, float d, float r) {
	FSVG garbageSVG = new FSVG(garbagePath);
	garbageSVG.setPosition(x, y);
	garbageSVG.setRotation(r);
	world.add(garbageSVG);
}

//大砲･砲台 (r:大砲の回転角度(水平=0 垂直1/2*π))
void drawCannon(float r) {
	pushMatrix();
	cannon.rotate(-r);
	shape(cannon, cannonC[0], cannonC[1]);
	cannon.rotate(r);
	popMatrix();
	shape(battery, batteryC[0], batteryC[1]-battery.height*cannonD);
}

class FSVG extends FPoly {
  RShape m_shape;
  
  float w = 100;
  float h = 100;  
  
  FSVG(String filename){
    super();
    
    RShape fullSvg = RG.loadShape(filename);
    m_shape = fullSvg.getChild("object");
    RShape outline = fullSvg.getChild("outline");
    
    if (m_shape == null || outline == null) {
      println("ERROR: Couldn't find the shapes called 'object' and 'outline' in the SVG file.");
      return;
    }
    
    // Make the shapes fit in a rectangle of size (w, h)
    // that is centered in 0
    m_shape.transform(-w/2, -h/2, w/2, h/2); 
    outline.transform(-w/2, -h/2, w/2, h/2); 
    
    RPoint[] points = outline.getPoints();

    if (points==null) return;
    
    for (int i=0; i<points.length; i++) {
      this.vertex(points[i].x, points[i].y);
    }

    this.setNoFill();
    this.setNoStroke();
  }
  
  void draw(PGraphics applet) {
    preDraw(applet);
    m_shape.draw(applet);
    postDraw(applet);
  }
  
}