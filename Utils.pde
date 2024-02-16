//Demo用？
void autoMan(Area area, Paddle player, Ball ball) {
  Rect playerRect=player.rect;
  Rect ballRect=ball.rect;
  if (ballRect.centerY()<playerRect.centerY()) {
    player.up(area);
  } else if (ballRect.centerY()>playerRect.centerY()) {
    player.down(area);
  }
}

boolean isParentsEnabled(GameObject go) {
  if (go.parent!=null&&go.parent instanceof GameObject) {
    return go.enabled&&isParentsEnabled((GameObject)go.parent);
  } else {
    return go.enabled;
  }
}
