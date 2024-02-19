class CPUPlayerGameScene extends BaseGameScene {
    float level = 1.0f;
    CPUPlayerGameScene(float level){
        this.level = level;
    }
    final void reloadSelf(){
        sceneManager.changeOneshot(new CPUPlayerGameScene(level));
    }
    final void update(){
        super.update();
        
        // 移動処理
        if (keyEventManager.isPressKey('w')) {
            player.up(gameArea.rect);
        }
        if (keyEventManager.isPressKey('s')) {
            player.down(gameArea.rect);
        }
        autoMan(gameArea, player2, balls,level);
    }
    void autoMan(Area area, Paddle player, List<Ball> balls,float precision) {
  Rect playerRect=player.rect;
  Ball target = null;
  Float minDistance = null;
  for(Ball ball : balls){
    float distance = ball.rect.centerX() - playerRect.centerX();
    if(target==null||minDistance>distance){
      target = ball;
      minDistance = abs(distance);
    }
  }
  if(target==null)return;
  
  Rect ballRect=target.rect;
  if(random(0,minDistance) < 50*precision&&(frameCount%2==0||precision==10)){
    if (ballRect.centerY()<playerRect.centerY()) {
      player.up(area.rect);
    } else if (ballRect.centerY()>playerRect.centerY()) {
      player.down(area.rect);
    }
  }
}
}