import fisica.*;
import geomerative.*;

String garbagePath = "garbage.svg";
//------画像･フォント-------------------------------------------------------
PShape garbage;			//ゴミ袋	(自作･ベクター)
PShape cannon;			//大砲		(〃)
PShape battery;			//砲台		(〃)
PImage bg;			//背景 		(他作･ラスター)
PFont font;			//フォント
//-----ゴミ袋---------------------------------------------------------------
int garbageN			= 20;				//同時表示可能な個数
int [] garbageFlag 		= new int [garbageN];		//表示のOn/Off
float [] garbageX  		= new float [garbageN];  	//X座標
float [] garbageY  		= new float [garbageN];         //Y座標
float [] garbageA  		= new float [garbageN];         //回転角度 (ラジアン)
float [] garbageD		= new float [garbageN];  	//倍率
float [] garbageR		= new float [garbageN];  	//半径 (ゴミ袋は円と見なす)
//---ゴミ袋発射-------------------------------------------------------------
float [] launchA  	 	= new float [garbageN];  	//発射角度
float [] launchVo 	 	= new float [garbageN];  	//初速度
float [] launchVY		= new float [garbageN];  	//Y方向の速度
float [] launchT		= new float [garbageN];  	//時間
int launchS 			= 0;		        	//発射するゴミ袋の選択
int [] garbageIntoBox	        = new int [garbageN];	        //ゴミ袋がゴミ箱に入ったかどうか (ゴミ箱の変更に利用･入ったらすぐ0になる)
int cleanup		        = 0;	          		//ゴミ袋がゴミ箱に入ったかどうか (CLEANUPメッセージに利用･入った後数値が加算)
//---自動発射モード---------------------------------------------------------
int autoLaunchMode		= 1;	  			//自動/手動発射モード
float launchInt			= 2.0;				//大砲の傾き変化を行うまでの静止時間
float crntCannonA 		= 0;				//現在の大砲の角度
float nextCannonA 		= 0;				//次の大砲の角度
int cleanupNum			= 0;				//拾ったゴミ袋の数
//-----ゴミ箱---------------------------------------------------------------
int [] boxHSB			= {55, 100, 91};        	//色(HSB､MAX:100)
float [] boxC			= new float [2];  	        //座標
float boxS;							//倍率
int boxMoveAmnt			= 10;				//移動量
boolean boxMoveLeft		= false;			//左方向の移動フラグ
boolean boxMoveRight	        = false;			//右方向の移動フラグ
float boxA			= 0;				//傾き(ラジアン)
float boxAngleMax		= 1.0/5.0*PI;			//傾き最大値
float boxAngleAdd 		= 1.0/40.0*PI;  		//傾き加算値
//---大砲・砲台-------------------------------------------------------------
float [] batteryC 		= new float [2];        	//砲台の座標 (左下)
float [] cannonC 		= new float [2];        	//大砲の支点の座標
float cannonA 			= 5.0/12.0*PI;		        //大砲の傾き (水平=0 垂直=1.0/2.0*π)
float cannonD;							//大砲･砲台の倍率
float cannonV			= radians(0.2);		        //大砲の傾く速度
//--------------------------------------------------------------------------
FWorld world;
FCircle body, leftEye, rightEye, leftHand, rightHand, leftFoot, rightFoot;
FBox leftArm, rightArm, leftThigh, rightThigh, leftLeg, rightLeg;
FRevoluteJoint leftBodyEyeJoint, rightBodyEyeJoint, leftBodyArmJoint, rightBodyArmJoint, leftBodyThighJoint, rightBodyThighJoint, leftHandArmJoint, rightHandArmJoint, leftThighLegJoint, rightThighLegJoint, leftLegFootJoint, rightLegFootJoint;
float characterWidth = 100;
float moveDistance = characterWidth*50;

void setup() {
	loadImg();
	fullScreen();
//	size(1280, 720);
	smooth();
	initVar();
	resizeImg();
	font = createFont("メイリオ", 30, true);

	Fisica.init(this);
	RG.init(this);
	RG.setPolygonizer(RG.ADAPTATIVE);
	
	world = new FWorld();
	world.setEdges(-width/2, height, width/2, 0, 0x00FFFFFF);
	world.setGravity(0, 0);

	createPlayer(0, height/2, characterWidth);
}

//画像読み込み
void loadImg() {
	garbage = loadShape("garbage.svg");
	cannon = loadShape("cannon.svg");
	battery = loadShape("battery.svg");
	bg = loadImage("landscape.png");
}

void initVar() {
	batteryC[0] = 0;
	batteryC[1] = height;
	cannonD = height/3500.0;
	cannonC[0] = batteryC[0]+530*cannonD;
	cannonC[1] = batteryC[1]-375*cannonD;
	for (int i = 0; i < garbageN; ++i) {
		garbageFlag[i] = 0;
		garbageX[i] = cannonC[0]+1305*cannonD*cos(cannonA);
		garbageY[i] = cannonC[1]-1305*cannonD*sin(cannonA);
		garbageD[i] = 0.0;
		garbageA[i] = 1.0/4.0*PI;
		launchVY[i] = 0.0;
		launchT[i] = 0.0;
		garbageR[i] = (float)garbage.width*garbageD[i];
		launchA[i] = cannonA;
		launchVo[i] = (int)random(-20, 20)+130;
		garbageIntoBox[i] = 0;
	}
	boxS = height/3800.0;
	boxC[0] = width/2.0;
	boxC[1] = height*3.0/5.0;
}

void resizeImg() {
	bg.resize(width, height);	//ウィンドウに背景を合わせる
	cannon.scale(cannonD);
	battery.scale(cannonD);
	cannon.rotate(-1.0/2.0*PI);
}

void draw() {
	background(255);
	image(bg, 0, 0);	//背景の描画

//	boxAngle();    //ゴミ箱の傾きの挙動

	//ゴミ箱
//	drawBoxFront(boxC[0], boxC[1], boxS, boxA, boxHSB[0], boxHSB[1], boxHSB[2]);
//	drawBoxText();	//ゴミ箱の顔を描画

	pushMatrix();
	translate(width/2, height);
	scale(1, -1);
	world.step();
	world.draw();
	popMatrix();

	if (autoLaunchMode%2 == 1) {	//自動発射モード時
		autoLaunch();
	}
	drawCannon(cannonA);	//砲台･大砲の描画

	//ゴミ袋
	for (int i = 0; i < garbageN; ++i) {
		if (garbageFlag[i] == 0) {
			//初期座標の設定
			garbageX[i] = cannonC[0]+1305*cannonD*cos(cannonA);
			garbageY[i] = cannonC[1]-1305*cannonD*sin(cannonA);
			launchA[i] = cannonA;		//ゴミ箱の座標と大砲の先端の座標を同期
		} else {
			launch(i);	//発射
			drawGarbage(garbageX[i], garbageY[i], garbageD[i], garbageA[i]);	//描画
		}
	}

	drawStatus();	//ステータスを表示
}

//ゴミ箱の顔
void drawBoxText() {
	fill(#FF0000);
	textFont(font, 20);
	textAlign(CENTER, CENTER);
	pushMatrix();
	translate(boxC[0], boxC[1]-5);
	rotate(boxA);
	if (cleanup == 0) {
		text("o(´д`)o", 0, 0);
	} else {
		text("Ｏ(≧▽≦)Ｏ", 0, 0);
		cleanup ++;
	}
	if (cleanup >= 30) {
		cleanup = 0;
	}
	popMatrix();
}

//ステータス表示
void drawStatus() {
	stroke(0);
	strokeWeight(4);
	fill(#4ADDA0);
	rect(width-30, 30, -250, 60);
	fill(255);
	textAlign(CENTER, CENTER);
	textFont(font, 26);
	text("拾ったゴミ袋: " + cleanupNum + "個", width-150, 60);
}

//十字線を引く (どちらかが0の場合は単線) (デバッグ用)
void drawCross (float x, float y) {
	if (x == 0) {
		line(0, y, width, y);
	} else if (y == 0) {
		line(x, 0, x, height);
	} else {
		line(x, 0, x, height);
		line(0, y, width, y);
	}
}
