//Demo用？
//TODO 複数ボールに対応
void autoMan(Area area, Paddle player, Ball ball) {
  Rect playerRect=player.rect;
  Rect ballRect=ball.rect;
  if (ballRect.centerY()<playerRect.centerY()) {
    player.up(area.rect);
  } else if (ballRect.centerY()>playerRect.centerY()) {
    player.down(area.rect);
  }
}

// 最上層の親のenabledをチェックする
boolean isParentsEnabled(GameObject go) {
  if (go.parent!=null&&go.parent instanceof GameObject) {
    return go.enabled && isParentsEnabled((GameObject)go.parent);
  } else {
    return go.enabled;
  }
}

// ListをArrayListに変換してクローンを一気にやってくれる
<T> List<T> cloneList(List<T> list) {
  return ((List<T>)((ArrayList<T>)list).clone());
}
