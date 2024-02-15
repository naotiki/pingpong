final class MainScene extends Scene {

    final color playerColor = #ff5555;
    final color player2Color = #5555ff;

    
    final Area gameArea = new Area(this, new Rect(0,100,screen.getWidth(),screen.getHeight()-100),#000000);
    final Paddle player = new Paddle(gameArea, gameArea.posByAnchor(PaddleSize.pos(50,0),Anchor.MiddleLeft),playerColor);
    final Paddle player2 = new Paddle(gameArea, gameArea.posByAnchor(PaddleSize.pos(-50,0),Anchor.MiddleRight),player2Color);
    final Ball ball = new Ball(gameArea, BallSize.pos(gameArea.centerX(), gameArea.centerY()),gameArea);


    final Area uiArea = new Area(this, new Rect(0,0,screen.getWidth(),100),#dddddd);
    final Button menuButton = new Button(uiArea, uiArea.posByAnchor(new Rect(0,25,100,50),Anchor.TopCenter),this,"Menu");
    private int score1=0;
    private int score2=0;
    final Text score1Text = new Text(uiArea, uiArea.posByAnchor(new Rect(-150,50),Anchor.TopCenter),"0",40,playerColor);
    final Text score2Text = new Text(uiArea, uiArea.posByAnchor(new Rect(150,50),Anchor.TopCenter),"0",40,player2Color);

    final Area overRayArea = new Area(this, new Rect(0,0,screen.getWidth(),screen.getHeight()),#dd000000);
    final Text menuText = new Text(overRayArea, overRayArea.posByAnchor(new Rect(0,50),Anchor.TopCenter),"メニュー",50,#ffffff);
    final Button restartButton = new Button(overRayArea, overRayArea.posByAnchor(new Rect(0,-80,300,50),Anchor.MiddleCenter),this,"やり直す");
    final Button titleButton = new Button(overRayArea, overRayArea.posByAnchor(new Rect(0,0,300,50),Anchor.MiddleCenter),this,"タイトルに戻る");
    final Button menuCancelButton = new Button(overRayArea, overRayArea.posByAnchor(new Rect(0,80,300,50),Anchor.MiddleCenter),this,"閉じる");

    public MainScene() {
    }
    void sceneSetup(){
        overRayArea.enabled=false;
        menuButton.setOnClickListener(()->{
            overRayArea.enabled=true;
            gameArea.enabled=false;
        });
        menuCancelButton.setOnClickListener(()->{
            overRayArea.enabled=false;
            gameArea.enabled=true;
        });
        restartButton.setOnClickListener(()->{
            sceneManager.changeOneshot(new MainScene());
        });
        titleButton.setOnClickListener(()->{
            sceneManager.change("title");
        });
    }
    void sceneUpdate() {
        //プレイヤーの反射処理
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
        
        if(ballRect.right() > gameArea.rect.right()){
            score1++;
            score1Text.text=str(score1);
            ball.reset();
        }
        
        if(ballRect.left() < gameArea.rect.left()){
            score2++;
            score2Text.text=str(score2);
            ball.reset();
        }
        
        // 移動処理
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
        
        //autoMan(gameArea,player,ball);
        autoMan(gameArea,player2,ball);
    }
    
    void keyPressed() {
    }
}
