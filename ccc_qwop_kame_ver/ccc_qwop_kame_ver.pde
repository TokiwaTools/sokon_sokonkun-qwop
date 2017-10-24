import fisica.*;
import java.util.List;

final float WORLD_WIDTH = 1280*10;	//ワールド横幅
final float PLAYER_SIZE = 100;		//プレイヤーのサイズ
final float WORLD_LEFT_EDGE = -PLAYER_SIZE*8;				//ワールドの左端X座標
final float WORLD_RIGHT_EDGE= WORLD_WIDTH-PLAYER_SIZE*8;	//ワールドの右端X座標
final float GROUND_HEIGHT = 100;	//地面の高さ
final float HUNDRED_METER = 1000;	//100mの幅(pixels)

FWorld world;

SokonKun sokonKun;
FBox ground;
PImage groundImage;

boolean isGameOver = false;

void setup() {
	size(1280, 720);
	frameRate(60);

	Fisica.init(this);
	world = new FWorld(WORLD_LEFT_EDGE, -height/2, WORLD_RIGHT_EDGE, height);
	world.setEdges(WORLD_LEFT_EDGE, -height/2, WORLD_RIGHT_EDGE, height, color(0, 0, 0, 0));
	
	ground = new FBox(WORLD_WIDTH, GROUND_HEIGHT);
	ground.setPosition(WORLD_LEFT_EDGE+WORLD_WIDTH/2, height-GROUND_HEIGHT/2);
	ground.setStatic(true);
	ground.setDrawable(false);
	world.add(ground);

	groundImage = loadImage("sand.jpg");
	groundImage = groundImage.get(0, (int)(groundImage.height/2-GROUND_HEIGHT/2), groundImage.width, (int)(groundImage.height/2+GROUND_HEIGHT/2));
//  world.setGravity(0, 30);

	sokonKun = new SokonKun(width/2, -13.0/12*PLAYER_SIZE, PLAYER_SIZE, #5FC3FF);
}

void draw() {
	background(255);

	pushMatrix();
		translate(width/2-sokonKun.getX(), 0);
		drawGround();
		world.step();
		world.draw();
		drawSignBoard();
	popMatrix();

	if (isGameOver) {
		drawGameOver();
	}
}

void keyPressed() {
	if (isGameOver) return;

	switch(key) {
		case 'q':
			sokonKun.openKnees();
		break;
		case 'w':
	  		sokonKun.closeKnees();
			break;
		case 'o':
	  		sokonKun.closeFeet();
		break;
		case 'p':
	  		sokonKun.openFeet();
		break;
  }
}

void contactStarted(FContact c) {
	if (isGameOver) return;

	FBody body = null;
	if (c.getBody1() == ground) {
		body = c.getBody2();
	} else if (c.getBody2() == ground) {
		body = c.getBody1();
	}
  
	if (sokonKun.isGameOver(body)) {
		body.setFill(230, 0, 0);
		isGameOver = true;
	}
}

void drawGround() {
	for (int i = -1; i <= WORLD_WIDTH/groundImage.width+1; i++) {
		image(groundImage, WORLD_LEFT_EDGE + i*groundImage.width, height-GROUND_HEIGHT);
	}
}

void drawSignBoard() {
	int meter = 100;
	for (float x = width/2+HUNDRED_METER; x <= WORLD_RIGHT_EDGE; x += HUNDRED_METER) {
		fill(255);
		textSize(26);
		textAlign(CENTER, CENTER);
		text(meter + "m", x, height-GROUND_HEIGHT*0.7);
	}
}

void drawGameOver() {
	fill(#EA8700);
	textSize(40);
	textAlign(CENTER, CENTER);
	text("GAME OVER", width/2, height*0.4);
	float meter = (sokonKun.getX()-width/2)/HUNDRED_METER*100;
	textSize(30);
	text(String.format("%.2f", meter) + "m", width/2, height*0.5);
}