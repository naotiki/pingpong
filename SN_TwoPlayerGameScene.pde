class TwoPlayerGameScene extends BaseGameScene {
    final void reloadSelf(){
        sceneManager.changeOneshot(new TwoPlayerGameScene());
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
        if (keyEventManager.isPressKeyCode(UP)) {
            player2.up(gameArea.rect);
        }
        if (keyEventManager.isPressKeyCode(DOWN)) {
            player2.down(gameArea.rect);
        }
    }
}