final class TestScene extends Scene {
    final Area gameArea = new Area(this, new Rect(0,0,screen.getWidth(),screen.getHeight()),#000000);
    final Ball ball = new Ball(this, BallSize.pos(gameArea.centerX(), gameArea.centerY()),gameArea);
    
}