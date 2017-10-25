//プレイヤー
class SokonKun {
	float bodyWidth = PLAYER_SIZE;
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
	
	public SokonKun(float _x, float _y, color _c) {
		bodyColor = _c;
		createShape(_x, _y, bodyWidth, _c);
		body.setRotation(PI/70);
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

	boolean isGameOver(FBody body) {
		return (body == leftHand || body == rightHand);
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
	private void createShape(float x, float y, float w, color c) {
		//胴体
		body = new FCircle(w);
		body.setPosition(x, y);
		body.setFillColor(c);
		body.setNoStroke();

		//目
		float eyeW = w/4.0;

		float leftEyeX = x+( (w+eyeW)/2.0 )*cos(PI*4/3.0);
		float leftEyeY = y+( (w+eyeW)/2.0 )*sin(PI*4/3.0);
		leftEye = new FCircle(eyeW);
		leftEye.setPosition(leftEyeX, leftEyeY);
		leftEye.setNoStroke();
		leftEye.setFillColor(c);

		float rightEyeX = x+( (w+eyeW)/2.0 )*cos(PI*5/3.0);
		float rightEyeY = y+( (w+eyeW)/2.0 )*sin(PI*5/3.0);
		rightEye = new FCircle(eyeW);
		rightEye.setPosition(rightEyeX, rightEyeY);
		rightEye.setNoStroke();
		rightEye.setFillColor(c);

		//手
		float handW = w/6.0;
		float armW = w/sqrt(2);

		float leftHandX = x-w/2.0 + ( armW*cos(PI*5/4.0) );
		float leftHandY = y + armW*sin(PI*5/4.0);
		leftHand = new FCircle(handW);
		leftHand.setPosition(leftHandX, leftHandY);
		leftHand.setFillColor(c);
		leftHand.setNoStroke();

		float rightHandX = x+w/2.0 + ( armW*cos(PI*(7/4.0)) );
		float rightHandY = y + armW*sin(PI*(-1/4.0));
		rightHand = new FCircle(handW);
		rightHand.setPosition(rightHandX, rightHandY);
		rightHand.setFillColor(c);
		rightHand.setNoStroke();

		//膝
		float kneeW = w/6.0;

		float leftKneeX = x + (w/2.0)*cos(PI*3/4.0) - w/3.0;
		float leftKneeY = y + w/2.0;
		leftKnee = new FCircle(kneeW);
		leftKnee.setPosition( leftKneeX, leftKneeY );
		leftKnee.setFillColor(c);
		leftKnee.setNoStroke();

		float rightKneeX = x + (w/2.0)*cos(PI/4.0) + w/3.0;
		float rightKneeY = y + w/2.0;
		rightKnee = new FCircle(kneeW);
		rightKnee.setPosition( rightKneeX, rightKneeY );
		rightKnee.setFillColor(c);
		rightKnee.setNoStroke();

		//足
		float footW = w/6.0;

		float leftFootX = leftKneeX-w/4.0;
		float leftFootY = leftKneeY+w/2.0;
		leftFoot = new FCircle(footW);
		leftFoot.setPosition(leftFootX, leftFootY);
		leftFoot.setFillColor(c);
		leftFoot.setNoStroke();

		float rightFootX = rightKneeX+w/4.0;
		float rightFootY = rightKneeY+w/2.0;
		rightFoot = new FCircle(footW);
		rightFoot.setPosition(rightFootX, rightFootY);
		rightFoot.setFillColor(c);
		rightFoot.setNoStroke();

		FBody[] bodies = {body, leftEye, rightEye, leftHand, rightHand, leftKnee, rightKnee, leftFoot, rightFoot};
		addBodiesToWorld(bodies);
		

		float leftEyeRootX = x + (w/2.0)*cos(PI*4/3.0);
		float leftEyeRootY = y + (w/2.0)*sin(PI*4/3.0);
		body_leftEye_revo = new FRevoluteJoint(body, leftEye, leftEyeRootX, leftEyeRootY);
		body_leftEye_revo.setEnableLimit(true);
		body_leftEye_revo.setDrawable(false);

		float rightEyeRootX = x + (w/2.0)*cos(PI*5/3.0);
		float rightEyeRootY = y + (w/2.0)*sin(PI*5/3.0);
		body_rightEye_revo = new FRevoluteJoint(body, rightEye, rightEyeRootX, rightEyeRootY);
		body_rightEye_revo.setEnableLimit(true);
		body_rightEye_revo.setDrawable(false);

		body_leftHand_revo = new FRevoluteJoint(body, leftHand, x-w/2.0, y);
		body_leftHand_revo.setEnableLimit(true);
		body_leftHand_revo.setLowerAngle(-PI/12);
		body_leftHand_revo.setUpperAngle(PI/12);
		body_leftHand_revo.setFillColor(c);
		body_leftHand_revo.setStrokeWeight(w/32);
		body_leftHand_revo.setStrokeColor(c);

		body_rightHand_revo = new FRevoluteJoint(body, rightHand, x+w/2.0, y);
		body_rightHand_revo.setEnableLimit(true);
		body_rightHand_revo.setLowerAngle(-PI/12);
		body_rightHand_revo.setUpperAngle(PI/12);
		body_rightHand_revo.setFillColor(c);
		body_rightHand_revo.setStrokeWeight(w/32);
		body_rightHand_revo.setStrokeColor(c);
		
		float leftLegRootX = x + (w/2.0)*cos(PI*3/4.0);
		float leftLegRootY = y + (w/2.0)*sin(PI*3/4.0);
		body_leftKnee_revo = new FRevoluteJoint(body, leftKnee, leftLegRootX, leftLegRootY);
		body_leftKnee_revo.setFillColor(c);
		body_leftKnee_revo.setStrokeWeight(w/32);
		body_leftKnee_revo.setStrokeColor(c);
		
		float rightLegRootX = x + (w/2.0)*cos(PI/4.0);
		float rightLegRootY = y + (w/2.0)*sin(PI/4.0);
		body_rightKnee_revo = new FRevoluteJoint(body, rightKnee, rightLegRootX, rightLegRootY);
		body_rightKnee_revo.setFillColor(c);
		body_rightKnee_revo.setStrokeWeight(w/32);
		body_rightKnee_revo.setStrokeColor(c);
		
		leftKnee_leftFoot_dist = new FDistanceJoint(leftKnee, leftFoot);
		leftKnee_leftFoot_dist.setFillColor(c);
		leftKnee_leftFoot_dist.setStrokeWeight(w/32);
		leftKnee_leftFoot_dist.setStrokeColor(c);
		
		rightKnee_rightFoot_dist = new FDistanceJoint(rightKnee, rightFoot);
		rightKnee_rightFoot_dist.setFillColor(c);
		rightKnee_rightFoot_dist.setStrokeWeight(w/32);
		rightKnee_rightFoot_dist.setStrokeColor(c);
	 
		FJoint[] joints = {
			body_leftEye_revo, body_rightEye_revo, 
			body_leftHand_revo, body_rightHand_revo, 
			body_leftKnee_revo, body_rightKnee_revo, 
			leftKnee_leftFoot_dist, rightKnee_rightFoot_dist
		};
		addJointsToWorld(joints);
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