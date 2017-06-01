abstract class Enemy extends Placable {
  ArrayList<Float[]> path;
  int ALpos;
  float speed = 1;
  int health = 1;

  final long delay;
  long blockUntil;


  Enemy(long delay, PImage img, ArrayList<Float[]> path) {
    this.img = img;
    this.delay = delay;
    this.path = path;
    update();
  }

  void startDelay() {
    if ( blockUntil == 0 ) {
      blockUntil = System.currentTimeMillis() + delay;
    }
  }

  long timeLeft() {
    return blockUntil - System.currentTimeMillis();
  }

  int getHealth() {
    return health;
  }

  void decrementHealth() {
    health--;
  }

  float getSpeed() {
    return speed;
  }
  
    
  void setCoords(float x, float y) {
    X = x;
    Y = y;
  }

  void update() {
    X = path.get(ALpos)[0];
    Y = path.get(ALpos++)[1];
  }
}