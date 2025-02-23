class Bird {
  // Bird's position on the screen
  int x, y;
  // Bird size (width and height)
  int birdWidth, birdHeight;   
  // Bird vertical velocity
  float velocityY;
  // Bird image
  PImage frame1;
  PImage frame2;
  // Track which frame to display
  boolean isFrame1 = true;

  int flapDuration = 200;  // How long frame2 stays after jump
  int lastFlapTime = 0;    // Stores when the last flap happened


  // Default Constructer
  Bird() {
    this.x = width / 8; // First eighth of the screen X
    this.y = (6 * height) / 25; // Middle of the screen Y
    this.birdWidth = 30;
    this.birdHeight = 30;
    // By Default, The Bird Starts With 0 Vertical Velocity
    this.velocityY = 0;
    // Load both frames
    this.frame1 = birdFrame1Img;
    this.frame2 = birdFrame2Img;
  }

  void flap() {  // Called when user presses SPACE
    velocityY = -7;  // Jump
    isFrame1 = false;  // Switch to frame2
    lastFlapTime = millis();  // Store flap time
  }

  void move() {
    this.velocityY = min(this.velocityY + GRAVITY, MAX_FALL_SPEED);
    this.y += this.velocityY;
    this.y = max(10, this.y); // Prevent escaping through the top
  }

  void update() {
    move();
    //  If 400ms have passed since the last flap, switch back to frame1
    if (!isFrame1 && millis() - lastFlapTime >= flapDuration) {
      isFrame1 = true;
    }
  }

  void drawIt() {
    imageMode(CORNER);
    if (isFrame1) {
      image(frame1, this.x, this.y, this.birdWidth, this.birdHeight);
    } else {
      image(frame2, this.x, this.y, this.birdWidth, this.birdHeight);
    }
  }
}
