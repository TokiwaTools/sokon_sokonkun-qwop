//障害物
class Obstacles {
	public Obstacles(float startX, float groundY) {
//		createBar(startX, groundY, 50, 80);
//		createMountain(startX, groundY, 50, 55, 20);
		createRandomBalls(startX, groundY, 50, 100, 16, 3);
		createBar(startX, groundY, 150, 40);
		createBar(startX, groundY, 170, 40);
		createBar(startX, groundY, 195, 40);
	}

	private void createRandomBalls(float startX, float groundY, float leftEdgeXMeter, float rightEdgeXMeter, float height, float count) {
		for (float xMeter = leftEdgeXMeter; xMeter <= rightEdgeXMeter; xMeter += (rightEdgeXMeter-leftEdgeXMeter)/count) {
			createBall(startX, groundY, xMeter+random(-5, 5), height+random(-4, 2));
		}
	}

	private void createBall(float startX, float groundY, float xMeter, float height) {
		FCircle ball = new FCircle(height);
		ball.setPosition(startX + xMeter*METER, groundY-height/2);
		ball.setStatic(true);
		world.add(ball);
	}

	private void createBar(float startX, float groundY, float xMeter, float height) {
		FPoly bar = new FPoly();
		float [][] positions = {
			{0, 0},
			{0, -height/12},
			{height/12, -height/12},
			{height/12, -height*11/12},
			{height*5/24, -height*11/12},
			{height*5/24, -height/12},
			{height*11/24, -height/12},
			{height*11/24, 0},
			{0, 0}
		};
		for (float [] position : positions) {
			bar.vertex(position[0], position[1]);
		}
		bar.setPosition(startX + xMeter*METER - height/4, groundY-height/24);
		world.add(bar);
	}

	private void createMountain(float startX, float groundY, float leftEdgeMeter, float rightEdgeMeter, float maxHeight) {
		float noise = 0.0;
		float step = 0.3;

		FPoly mountain = new FPoly();
		mountain.vertex(startX+leftEdgeMeter*METER, groundY);
		for (float xMeter = leftEdgeMeter; xMeter <= rightEdgeMeter; xMeter += 2) {
			float x = startX+xMeter*METER;
			float y = groundY - noise(noise)*(maxHeight-5) - 5;
			mountain.vertex(x, y);
			noise += step;
		}
		mountain.vertex(startX+rightEdgeMeter*METER, groundY);
		mountain.vertex(startX+leftEdgeMeter*METER, groundY);

		mountain.setStatic(true);
		world.add(mountain);
	}
}