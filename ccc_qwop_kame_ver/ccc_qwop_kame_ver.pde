/*
操作方法
Q: 股を閉じる (膝を閉じる)
W: 股を開く   (膝を開く)
O: 脚を閉じる (足を閉じる)
P: 脚を開く   (足を開く)
*/

import fisica.*;
import java.util.List;

final float WORLD_WIDTH = 1280*10;	//ワールド横幅
final float PLAYER_SIZE = 100;		//プレイヤーのサイズ
final float WORLD_LEFT_EDGE = -PLAYER_SIZE*8;				//ワールドの左端X座標
final float WORLD_RIGHT_EDGE= WORLD_WIDTH-PLAYER_SIZE*8;	//ワールドの右端X座標
final float GROUND_HEIGHT = 100;	//地面の高さ

FWorld world;

SokonKun sokonKun;
FBox ground;
PImage groundImage;

void setup() {
	size(1280, 720);
	frameRate(60);

	Fisica.init(this);
	world = new FWorld(WORLD_LEFT_EDGE, 0, WORLD_RIGHT_EDGE, height);
	world.setEdges(WORLD_LEFT_EDGE, 0, WORLD_RIGHT_EDGE, height, color(0, 0, 0, 0));
	ground = new FBox(WORLD_WIDTH, GROUND_HEIGHT);
	ground.setPosition(WORLD_LEFT_EDGE+WORLD_WIDTH/2, height-GROUND_HEIGHT/2);
	ground.setStatic(true);
	ground.setDrawable(false);
	world.add(ground);
	groundImage = loadImage("sand.jpg");
	groundImage = groundImage.get(0, (int)(groundImage.height/2-GROUND_HEIGHT/2), groundImage.width, (int)(groundImage.height/2+GROUND_HEIGHT/2));
//  world.setGravity(0, 30);

	sokonKun = new SokonKun(width/2, height/2, PLAYER_SIZE, #5FC3FF);
}

void draw() {
	background(255);

	translate(width/2-sokonKun.getX(), 0);
	drawGround();

	world.step();
	world.draw();
}

void keyPressed() {
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
	FBody body = null;
	if (c.getBody1() == world.bottom) {
		body = c.getBody2();
	} else if (c.getBody2() == world.bottom) {
		body = c.getBody1();
	}
  
	if (sokonKun.isGameOver(body)) {
		body.setFill(230, 0, 0);
		println("GAME OVER");
	}
}

void drawGround() {
	for (int i = 0; i <= WORLD_WIDTH/groundImage.width; i++) {
		image(groundImage, WORLD_LEFT_EDGE + i*groundImage.width, height-GROUND_HEIGHT);
	}
}