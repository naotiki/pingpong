final class MainScene extends Scene {
  final float ITEM_EXPAND_AMOUNT=50;
  final color playerColor = #ff5555;
  final color player2Color = #5555ff;


  final Area gameArea = new Area(this, new Rect(0, 100, screen.getWidth(), screen.getHeight()-100), #000000);
  final Paddle player = new Paddle(gameArea, gameArea.posByAnchor(PaddleSize.pos(50, 0), Anchor.MiddleLeft), playerColor);
  final Paddle player2 = new Paddle(gameArea, gameArea.posByAnchor(PaddleSize.pos(-50, 0), Anchor.MiddleRight), player2Color);
  final List<Ball> balls = new ArrayList<Ball>() {
    {
      add(new Ball(gameArea, BallSize.pos(gameArea.centerX(), gameArea.centerY()), gameArea));
    }
  };


  final Area uiArea = new Area(this, new Rect(0, 0, screen.getWidth(), 100), #dddddd);
  final Button menuButton = new Button(uiArea, uiArea.posByAnchor(new Rect(0, 25, 100, 50), Anchor.TopCenter), this, "Menu");
  private int score1=0;
  private int score2=0;
  final Text score1Text = new Text(uiArea, uiArea.posByAnchor(new Rect(-150, 50), Anchor.TopCenter), "0", 40, playerColor);
  final Text score2Text = new Text(uiArea, uiArea.posByAnchor(new Rect(150, 50), Anchor.TopCenter), "0", 40, player2Color);

  final Area menuOverrayArea = new Area(this, new Rect(0, 0, screen.getWidth(), screen.getHeight()), #dd000000);
  final Text menuText = new Text(menuOverrayArea, menuOverrayArea.posByAnchor(new Rect(0, 50), Anchor.TopCenter), "メニュー", 50, #ffffff);
  final Button restartButton = new Button(menuOverrayArea, menuOverrayArea.posByAnchor(new Rect(0, -80, 300, 50), Anchor.MiddleCenter), this, "やり直す");
  final Button titleButton = new Button(menuOverrayArea, menuOverrayArea.posByAnchor(new Rect(0, 0, 300, 50), Anchor.MiddleCenter), this, "タイトルに戻る");
  final Button menuCancelButton = new Button(menuOverrayArea, menuOverrayArea.posByAnchor(new Rect(0, 80, 300, 50), Anchor.MiddleCenter), this, "閉じる");

  private boolean isMainGameUpdateEnabled = true;
  private final List<Item> items = new ArrayList<Item>();
  private Map<Ball, Paddle> ballPlayerMap = new HashMap<Ball, Paddle>();
  
  private List<Wall> topWalls = new ArrayList<Wall>();
  private List<Wall> bottomWalls = new ArrayList<Wall>();
  double wallAngleBase() {
    return ((Float)random(radians(5), radians(85))).doubleValue();
  }
  // -1 or 1
  List<Wall> createWalls(Anchor anchor){
    double angleDir=(anchor.y-0.5)*2;
    List<Wall> walls = new ArrayList<Wall>();
    double angle = wallAngleBase();
    Wall w=new Wall(gameArea, gameArea.posByAnchor(new Rect(0, 10), anchor), -angle, 100);
    walls.add(w);
    for (int i = 0; w.rect.x+w.vec.x < gameArea.rect.x+gameArea.rect.w; ++i) {
      double sign=i%2==0?1:-1;
      if (sign==-1) {
        angle= wallAngleBase()*angleDir;
      }
      w = new Wall(gameArea, new Rect(w.rect.x+w.vec.toFloat().x, w.rect.y+w.vec.toFloat().y, 0, 0), sign*angle, 100);
      walls.add(w);
    }
    return walls;
  }
  void destroyWalls(List<Wall> walls){
    for (Wall w : walls) {
      w.destroy();
    }
    walls.clear();
  }

  List<Wall> getAllWalls() {
    List<Wall> allWalls = new ArrayList<Wall>();
    allWalls.addAll(topWalls);
    allWalls.addAll(bottomWalls);
    return allWalls;
  }

  void setup() {
    menuOverrayArea.enabled=false;
    menuButton.setOnClickListener(()-> {
      menuOverrayArea.enabled=true;
      gameArea.enabled=false;
      isMainGameUpdateEnabled = false;
    }
    );
    menuCancelButton.setOnClickListener(()-> {
      menuOverrayArea.enabled=false;
      gameArea.enabled=true;
      isMainGameUpdateEnabled = true;
    }
    );
    restartButton.setOnClickListener(()-> {
      sceneManager.changeOneshot(new MainScene());
    }
    );
    titleButton.setOnClickListener(()-> {
      sceneManager.change("title");
    }
    );
  }
  void update() {
    if (isMainGameUpdateEnabled) {
      mainGameUpdate();
    }
  }
  void itemSpawn() {
    Item i=new Item(gameArea, gameArea.posByAnchor(new Rect(random(-gameArea.rect.w*0.2, gameArea.rect.w*0.2), random(-gameArea.rect.h*0.2, gameArea.rect.h*0.2), 50, 50), Anchor.MiddleCenter), ItemType.randomType());
    i.setup();
    items.add(i);
  }
  void checkItem() {
    List<Item> willDestroyItems = new ArrayList<Item>();
    for (int i=0; i<items.size(); i++) {
      Item item=items.get(i);
      
      for (Ball ball : cloneList(balls)) {
        if (item.rect.intersects(ball.rect)) {
          Paddle playerHasBall=ballPlayerMap.get(ball);
          switch (item.type) {
          case AddBall:
            Ball b=new Ball(gameArea, BallSize.pos(ball.rect.x, ball.rect.y), gameArea);
            b.setup();
            b.velocity.rotate(random(-PI/4, PI/4));
            b.setParticleColor(ball.ps.tintColor);
            balls.add(b);
            ballPlayerMap.put(b, playerHasBall);
            break;
          case Expand:
            playerHasBall.rect.h+=ITEM_EXPAND_AMOUNT;
            Paddle p=playerHasBall;
            timer.setTimeout(10000, ()-> {
              p.rect.h-=ITEM_EXPAND_AMOUNT;
              p.yPosWithin(gameArea.rect);
            });
            break;
          case Wall:
            if(bottomWalls.size()==0){
              bottomWalls = createWalls(Anchor.BottomLeft);
              timer.setTimeout(30000, ()-> {
                destroyWalls(bottomWalls);
              });
            }else if(topWalls.size()==0){
              topWalls = createWalls(Anchor.TopLeft);
              timer.setTimeout(30000, ()-> {
                destroyWalls(topWalls);
              });
            } 
            
            break;
          }
          item.destroy();
          items.remove(i);
          break;
        }
      }
    }
  }

  void mainGameUpdate() {
    if (frameCount%(FRAME_RATE*round(random(5, 6)))==0 && items.size()<3) {
      itemSpawn();
    }
    checkItem();
    List<Wall> walls = getAllWalls();
    for (Ball ball : cloneList(balls)) {

      while (walls.size()>0) {
      PVectorD ballCenter=new PVectorD(ball.rect.centerX(), ball.rect.centerY());
      PVectorD newPos =  null;
      Double nearestDistanse = null;
      Wall hitWall=null;
      for (int i = 0; i < walls.size(); i++) {
        Wall w = walls.get(i);

        PVectorD pos = calcCircleCenterOnCollisionD(
          ballCenter,
          new PVectorD(ball.velocity), w.rect.getPosVecD(), w.vec, ball.rect.w/2
          );
        if (pos==null) continue;
        double distance = PVectorD.dist(ballCenter, pos);
        if (newPos==null||nearestDistanse > distance) {
          hitWall=w;
          newPos = pos;
          nearestDistanse = distance;
        }
      }
      if (newPos==null) {
        break;
      }
      //Collision
      PVectorD v=new PVectorD(ball.velocity);
      Double radian=2*hitWall.vec.heading()-2*v.heading();
      ball.velocity.rotate(radian.floatValue());
      PVector newPosF=newPos.toFloat();
      ball.rect.setPos(newPosF.x-ball.rect.w/2, newPosF.y-ball.rect.h/2);
    }
      //プレイヤーの反射処理
      Rect ballRect= ball.rect;
      Rect playerRect = player.rect;
      Rect player2Rect = player2.rect;
      if (
        ballRect.left() < playerRect.right() && ball.velocity.x < 0
        && ballRect.right() > playerRect.right()
        && ballRect.bottom() > playerRect.top() && ballRect.top() < playerRect.bottom()
        ) {
        ballPlayerMap.put(ball, player);
        ball.setParticleColor(playerColor);
        ball.velocity.x *=-1;
      }
      if (
        ballRect.right() > player2Rect.left() && ball.velocity.x > 0
        && ballRect.left() < player2Rect.left()
        && ballRect.bottom() > player2Rect.top() && ballRect.top() < player2Rect.bottom()
        ) {
        ballPlayerMap.put(ball, player2);
        ball.setParticleColor(player2Color);
        ball.velocity.x *=-1;
      }

      if (ballRect.right() > gameArea.rect.right()) {
        score1++;
        score1Text.text=str(score1);
        if (balls.size()>1) {
          ball.destroy();
          balls.remove(ball);
          ballPlayerMap.remove(ball);
        } else {
          ball.reset();
        }
      }

      if (ballRect.left() < gameArea.rect.left()) {
        score2++;
        score2Text.text=str(score2);
        if (balls.size()>1) {
          ball.destroy();
          balls.remove(ball);
          ballPlayerMap.remove(ball);
        } else {
          ball.reset();
        }
      }
    };


    // 移動処理
    if (keyEventManager.isPressKey('w')) {
      player.up(gameArea.rect);
    }
    if (keyEventManager.isPressKey('s')) {
      player.down(gameArea.rect);
    }
    if (keyEventManager.isPressKeyCode(UP)) {
      player2.up(gameArea.rect);
    }
    if (keyEventManager.isPressKeyCode(DOWN)) {
      player2.down(gameArea.rect);
    }

    //autoMan(gameArea,player,ball);
    //autoMan(gameArea, player2, ball);
  }

  void keyPressed() {
  }
}
