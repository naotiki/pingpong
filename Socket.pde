import processing.net.*;


class GameServer{
  int port;
  private Server server; 
  GameServer(PApplet app,int port){
    this.port=port;
    server=new Server(app, port); 
  }
}
