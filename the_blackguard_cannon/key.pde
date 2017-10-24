//キー操作
void keyPressed() {
  float w = characterWidth;
  float d = moveDistance;

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