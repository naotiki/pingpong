final class MainScene extends Scene {
    Paddle player = new Paddle(this, screen.posByAnchor(new Rect(50,0),Anchor.MiddleLeft));
    Paddle player2 = new Paddle(this, screen.posByAnchor(new Rect(-50,0),Anchor.MiddleRight));
    Ball ball = new Ball(this, new Rect(screen.centerX(), screen.centerY()));



    Button button = new Button(this, screen.posByAnchor(new Rect(0,0,100,50),Anchor.MiddleCenter),"Start");





    public MainScene() {
        super("main");
    }
    void draw() {
        Rect ballRect= ball.rect;
        Rect playerRect = player.rect;
        Rect player2Rect = player2.rect;
        if(
            ballRect.left() < playerRect.right() && ball.velocityVec.x < 0  
            && ballRect.right() > playerRect.right()
            && ballRect.top() > playerRect.top() && ballRect.top() < playerRect.bottom()
        ){
            ball.velocityVec.x *=-1;
        }
        if(
            ballRect.right() > player2Rect.left() && ball.velocityVec.x > 0 
            && ballRect.left() < player2Rect.left()
            && ballRect.top() > player2Rect.top() && ballRect.top() < player2Rect.bottom() 
        ){
            ball.velocityVec.x *=-1;
        }
        
        if (playerRect.y > 0 && keyEventManager.isPressKey('w')) {
            playerRect.y -= 10;
        } 
        if (playerRect.y + playerRect.h < screen.height && keyEventManager.isPressKey('s')) {
            playerRect.y += 10;
        }
        if (player2Rect.y > 0 && keyEventManager.isPressKeyCode(UP)) {
            player2Rect.y -= 10;
        } 
        if (player2Rect.y + player2Rect.h < screen.height && keyEventManager.isPressKeyCode(DOWN)) {
            player2Rect.y += 10;
        }
        
        
        
        super.draw();
        text("px:" + player.rect.x + " py:" + player.rect.y,40,450);
    }
    
    void keyPressed() {
    }
}
