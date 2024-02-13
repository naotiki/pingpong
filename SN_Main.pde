final class MainScene extends Scene {

    color playerColor = #ff1111;
    color player2Color = #1111ff;

    Paddle player = new Paddle(this, screen.posByAnchor(new Rect(50,0),Anchor.MiddleLeft),playerColor);
    Paddle player2 = new Paddle(this, screen.posByAnchor(new Rect(-50,0),Anchor.MiddleRight),player2Color);
    Ball ball = new Ball(this, new Rect(screen.centerX(), screen.centerY()));



    Button button = new Button(this, screen.posByAnchor(new Rect(0,0,100,50),Anchor.MiddleCenter),"Start");
    
    Text score1 = new Text(this, screen.posByAnchor(new Rect(-150,50),Anchor.TopCenter),"0",40,playerColor);
    Text score2 = new Text(this, screen.posByAnchor(new Rect(150,50),Anchor.TopCenter),"0",40,player2Color);



    public MainScene() {
    }
    void setup(){
        super.setup();
        button.setOnClickListener(()->{
            sceneManager.transitionOneshot(new MainScene());
        });
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
            player.up();
        } 
        if (playerRect.y + playerRect.h < screen.height && keyEventManager.isPressKey('s')) {
            player.down();
        }
        if (keyEventManager.isPressKeyCode(UP)) {
            player2.up();
        } 
        if (keyEventManager.isPressKeyCode(DOWN)) {
            player2.down();
        }
        
        autoMan(player2,ball);
        
        super.draw();
        text("px:" + player.rect.x + " py:" + player.rect.y,40,450);
    }
    
    void keyPressed() {
    }
}
