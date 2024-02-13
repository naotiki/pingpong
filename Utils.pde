//Demo用？
void autoMan(Paddle player,Ball ball){
    Rect playerRect=player.rect;
    Rect ballRect=ball.rect;
    if(ballRect.centerY()<playerRect.centerY()){
        player.up();
    }else if(ballRect.centerY()>playerRect.centerY()){
        player.down();
    }
}