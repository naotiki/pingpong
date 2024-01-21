final class MainScene extends Scene {
    Bar player = new Bar(this, 100, 400);
    Bar player2 = new Bar(this, 500, 400);
    Ball ball = new Ball(this, 50, 50);
    MainScene() {
        super("main");
    }
    
    void draw() {
        if(keyEventManager.keys.size() > 0) {
            println(keyEventManager.keys);
        }
    
        if (player.isCollision(ball)) {
            if ((ball.x <= player.x + player.width && ball.velocityVec.x < 0) || (ball.x + ball.width >= player.x && ball.velocityVec.x>0)) {
                ball.velocityVec.x *= -1;
            }
        }
        
        
        if (player.y > 0 && keyEventManager.isPressedKeyCode(UP)) {
            player.y -= 10;
        } 
        if (player.y + player.height < positionManager.height && keyEventManager.isPressedKeyCode(DOWN)) {
            player.y += 10;
        }
        
        
        
        super.draw();
        text("px:" + player.x + " py:" + player.y,40,450);
    }
    
    
    void keyPressed() {
        if (key ==  'b') {
            var o = new Ball(this, random(500f), random(500f));
            o.setup();
        }
    }
}
