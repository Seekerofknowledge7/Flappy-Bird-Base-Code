class Pipe {
  // Pipes's Position On The Screen
  int x, y;
  // Pipe"s Dimensions
  int pipeWidth, pipeHeight;
  // Pipe's velocity to the left
  int velocityX;
  // Boolean To Keep Track If The Bird Has Passed The Pipe
  boolean passed;
  // Pipe's image
  PImage pipeImg;

  Pipe(PImage pipeImg) {
    this.x = width;
    this.y = 0;
    this.pipeWidth = 64; // Scale 1/6
    this.pipeHeight = 512;
    this.velocityX = -2;
    this.passed = false;
    this.pipeImg = pipeImg;
  }
  Pipe(int x, int y, PImage pipeImg) {
    this.x = x;
    this.y = y;
    this.pipeWidth = 64; // Scale 1/6
    this.pipeHeight = 512;
    this.velocityX = -2;
    this.passed = false;
    this.pipeImg = pipeImg;
  }
  void move() {
    this.x += velocityX;
  }
  void drawIt() {
    imageMode(CORNER);
    image(pipeImg, this.x, this.y, pipeWidth, pipeHeight);
  }
}
