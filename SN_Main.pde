final class MainScene extends Scene {

    color playerColor = #ff1111;
    color player2Color = #1111ff;

    Area uiArea = new Area(this, new Rect(0,0,screen.getWidth(),100),#ffffff);
    Area gameArea = new Area(this, new Rect(0,100,screen.getWidth(),screen.getHeight()-100),#000000);

    Paddle player = new Paddle(this, gameArea.posByAnchor(PaddleSize.pos(50,0),Anchor.MiddleLeft),playerColor);
    Paddle player2 = new Paddle(this, gameArea.posByAnchor(PaddleSize.pos(-50,0),Anchor.MiddleRight),player2Color);
    Ball ball = new Ball(this, BallSize.pos(gameArea.centerX(), gameArea.centerY()));



    Button button = new Button(this, uiArea.posByAnchor(new Rect(0,50,100,50),Anchor.TopCenter),"Start");
    int score1=0;
    int score2=0;
    Text score1Text = new Text(this, uiArea.posByAnchor(new Rect(-150,50),Anchor.TopCenter),"0",40,playerColor);
    Text score2Text = new Text(this, uiArea.posByAnchor(new Rect(150,50),Anchor.TopCenter),"0",40,player2Color);



    public MainScene() {
    }
    void setup(){
        super.setup();
        button.setOnClickListener(()->{
            sceneManager.changeOneshot(new MainScene());
        });
    }
    void update() {
        Rect ballRect= ball.rect;
        Rect playerRect = player.rect;
        Rect player2Rect = player2.rect;
        if(
            ballRect.left() < playerRect.right() && ball.velocityVec.x < 0  
            && ballRect.right() > playerRect.right()
            && ballRect.bottom() > playerRect.top() && ballRect.top() < playerRect.bottom()
        ){
            ball.setParticleColor(playerColor);
            ball.velocityVec.x *=-1;
        }
        if(
            ballRect.right() > player2Rect.left() && ball.velocityVec.x > 0 
            && ballRect.left() < player2Rect.left()
            && ballRect.bottom() > player2Rect.top() && ballRect.top() < player2Rect.bottom() 
        ){
            ball.setParticleColor(player2Color);
            ball.velocityVec.x *=-1;
        }
        
        if (keyEventManager.isPressKey('w')) {
            player.up(gameArea);
        } 
        if (keyEventManager.isPressKey('s')) {
            player.down(gameArea);
        }
        if (keyEventManager.isPressKeyCode(UP)) {
            player2.up(gameArea);
        } 
        if (keyEventManager.isPressKeyCode(DOWN)) {
            player2.down(gameArea);
        }
        
        //autoMan(gameArea,player2,ball);
        
        super.update();
        text("px:" + player.rect.x + " py:" + player.rect.y,40,450);
    }
    
    void keyPressed() {
    }
}
