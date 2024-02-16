import processing.net.*;


class GameServer {
  int port;
  private Server server;
  GameServer(PApplet app, int port) {
    this.port=port;
    server=new Server(app, port);
  }
}

class GameClient {
  String ip;
  int port;
  private Client client;
  GameClient(PApplet app, String ip, int port) {
    this.ip=ip;
    this.port=port;
    client=new Client(app, ip, port);
  }
}
