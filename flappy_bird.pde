// New Game
Game game;
PFont zigBlack;

// Images
// Bird
PImage birdFrame1Img;
PImage birdFrame2Img;

// Pipes
PImage topPipeImg;
PImage bottomPipeImg;

// Background
PImage bgDay;
PImage bgNight;

// Flag to prevent bird jump spams while holding space
boolean canJump = true;
void setup() {
  // Screen Size
  size(360, 640);
  
  
  
  

  // Loading Images
  // Loading Chicken Images
  birdFrame1Img = loadImage("images/bird/frame-1.png");
  birdFrame2Img = loadImage("images/bird/frame-2.png");

  // Loading Pipe Images
  topPipeImg = loadImage("images/pipes/toppipe.png");
  bottomPipeImg = loadImage("images/pipes/bottompipe.png");

  // Loading Background Images
  bgDay = loadImage("images/background/bg.png");
  bgNight = loadImage("images/background/bg_night.png");

  // Loading Game
  game = new Game();
}

void draw() {
  // Drawing Background
  imageMode(CORNER);
  image(bgDay, 0, 0, width, height);
  // Update The Game Only When Playing
  if (game.gameState == GameState.PLAYING) {
    game.update();
    game.drawPlaying();
  }
  else if (game.gameState == GameState.MENU) {
    game.drawMenu();
  }
  else if (game.gameState == GameState.GAME_OVER) {
    game.drawPlaying();
    game.drawGameOver();
  }
  println(frameRate);
}

void keyPressed() {
  game.handleKey(key);
}
void keyReleased() {
  canJump = true;
}
