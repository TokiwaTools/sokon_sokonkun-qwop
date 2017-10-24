//挙動･判定･モード


//ゴミ箱の傾きの挙動
void boxAngle() {
	if (boxMoveLeft == true) {	//左に傾ける
		boxA += -(boxAngleMax+boxA)*boxAngleAdd;
		if (boxC[0]-boxMoveAmnt >= 130) {	//左端で止まる
			boxC[0] += -boxMoveAmnt;
		}
	}
	if (boxMoveRight == true) {	//右に傾ける
		boxA += (boxAngleMax-boxA)*boxAngleAdd;
		if ( boxC[0]+boxMoveAmnt <= width-130 ) {	//右端で止まる
			boxC[0] += boxMoveAmnt;
		}
	}
	if (boxMoveLeft == false && boxMoveRight == false) {	//静止で徐々に傾きを戻す
		boxA += -boxA*1.0/36.0*PI;
	}
}

//ゴミ袋の斜方投射 (座標､回転､倍率･当たり判定)
void launch(int i) {
	garbageR[i] = (float)garbage.width*garbageD[i]/2.0;	//ゴミ袋の半径を倍率に同期
	//発射後の回転･拡大縮小
	if (launchT[i] <= 1.0) {					 	//発射後すぐ
		garbageA[i] += radians(2);				//	回転
		garbageD[i] = launchT[i]*0.7;			//	拡大
	} else if (launchVo[i] > 0) {				//その後
		garbageA[i] += radians(6);				//	回転
		garbageD[i] *= 0.994;							//	縮小
	}
	//ゴミ箱の座標計算
	garbageX[i] = launchVo[i]*launchT[i]*cos(launchA[i])+cannonC[0]+1305*cannonD*cos(launchA[i]);
	garbageY[i] = -launchVo[i]*launchT[i]*sin(launchA[i])+0.5*9.8*launchT[i]*launchT[i]+cannonC[1]-1305*cannonD*sin(launchA[i]);
	launchVY[i] = -launchVo[i]+9.8*launchT[i];
	//画面下に行ったらゴミ袋を元に戻す
	if (garbageY[i]-garbageR[i]/2.0 >= height) {
		garbageFlag[i] = 0;
		launchT[i] = 0;
	}
	//ゴミ箱との当たり判定
	if (boxDecision(i) == true) {	//ゴミ袋がゴミ箱に入った場合
		cleanupNum ++;
		garbageFlag[i] = 0;
		launchT[i] = 0;
		garbageIntoBox[i] = 0;
		cleanup = 1;
	}
	launchT[i] += 0.1;
}

//ゴミ箱とゴミ袋の当たり判定
boolean boxDecision(int i) {
	boolean dcsn = false;
	pushMatrix();

	translate(boxC[0], boxC[1]);
	rotate(-boxA);
	scale(1.0, 4.5);

	if (launchVY[i] > 0) {	//ゴミ袋が奥にあるときに判定をつける
		//ゴミ袋がゴミ箱に入ったかどうか
		if (boxC[0]-270*boxS <= garbageX[i]-garbageR[i]/2.0 && boxC[0]+270*boxS >= garbageX[i]+garbageR[i]/2.0) {
			if (dist(boxC[0], boxC[1]-384*boxS, garbageX[i], garbageY[i]) <= garbageR[i]*garbageD[i]+270*boxS) {
				if (garbageIntoBox[i] == 0) {
					//println("Into a box! ("+i+")");
				}
				garbageIntoBox[i] = 1;
			}
		}
		//ゴミ袋がゴミ箱に入りきったら
		if (garbageIntoBox[i] == 1) {
			garbageD[i] *= 0.85;	//縮小
			if (garbageD[i] <= 0.1) {
				dcsn = true;
				//println("Clean Up! ("+i+")");
			}
		}
	}

	scale(1.0, 1.0/4.5);
	rotate(boxA);

	popMatrix();
	return dcsn;
}

//自動発射モード
void autoLaunch() {
	float diffCannonA = nextCannonA-crntCannonA;	//現在と次の大砲の角度の差分
	if (garbageFlag[launchS%garbageN] == 0) {
		if ( diffCannonA > 0 && (nextCannonA-cannonA) >= 0 ) {	//角度が緩→急になる場合
			cannonA += cannonV;
		} else if ( diffCannonA < 0 && (nextCannonA-cannonA) <= 0 ) {	//角度が急→緩になる場合
			cannonA += -cannonV;
		}	else {		//大砲が移動しきったら発射
			garbageFlag[launchS%garbageN] ++;
		}
	}
	if (launchT[launchS%garbageN] >= launchInt) {
		launchS ++;
		crntCannonA = cannonA;	//現在の大砲の角度を保存
		nextCannonA = random(1.0/3.0*PI, 1.0/2.0*PI);	//次の大砲の角度を決定
	}
}
