

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
