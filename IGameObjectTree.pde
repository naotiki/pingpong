interface IGameObjectTree {
  void addChild(GameObject gameObject);
  //void removeChild(GameObject gameObject);
  List<GameObject> getChildren();
}
