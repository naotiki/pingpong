private final boolean isDebug = true;
void debugSetup() {
  DebugApplet debugApplet = new DebugApplet();
  PApplet.runSketch(new String[]{"Debug"}, debugApplet);
  keyEventManager.addKeyEventListener((type, keyCode, key)-> {
    if (key!='p') return;
    switch (type) {
    case Pressed:
      isStopDraw=!isStopDraw;
      break;
    case Released:
      //isStopDraw=false;
      break;
    }
  }
  );
}
void debugDraw() {
  textAlign(LEFT, CENTER);
  fill(#ee00cc00);
  textSize(32);
  text(sceneManager.getActiveSceneId(), 40, 40);
  Runtime runtime = Runtime.getRuntime();
  long max = runtime.totalMemory();
  long free = runtime.freeMemory();
  long used = max - free;
  text(str(used/1024)+" KB", 40, 80);
  markPoint(new PVector(mouseX, mouseY), #ee00cccc);
}

void markPoint(PVector point, color crossColor) {
  markPoint(point, crossColor, true);
}

void markPoint(PVector point, color crossColor, boolean withText) {
  stroke(crossColor);
  line(point.x-10, point.y, point.x+10, point.y);
  line(point.x, point.y-10, point.x, point.y+10);
  if (withText) {
    textAlign(CENTER, CENTER);
    text("("+point.x+","+point.y+")", point.x, point.y-20);
  }
}


// For Debug
//指定キーが押されるまでブロック
void waitToKeyPress(char key) {
  while (!keyEventManager.isPressKey(key)) {
  }
}
