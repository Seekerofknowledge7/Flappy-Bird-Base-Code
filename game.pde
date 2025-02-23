class Game {
  // The Main Bird In Game
  Bird bird;


  // An Array List That COntains All The Active Pipes
  ArrayList<Pipe> pipes;

  // Variables Useful For A Delay Between Adding Pipes
  int addPipeCooldown = 1500;
  int lastAddPipe = 0;

  // Variables Useful For The trail
  float addTrailCoolDown = 0.1;
  int lastAddTrail = 0;

  int score; // Game Score
  float time = 0;
  GameState gameState; // Track Game State

  // Font
  PFont titleFont = createFont("font/Minecraft.ttf", 40);

  Game() {
    gameState = GameState.MENU;
  }

  void createNewGame() {
    bird = new Bird();
    pipes = new ArrayList<Pipe>();
    score = 0;
  }

  void drawMenu() {
    textAlign(CENTER);

    pushMatrix();
    translate(width / 2 - 110, height / 3 - 30); // Move it higher
    rotate(radians(-20)); // More rotation
    imageMode(CENTER);
    image(birdFrame1Img, 0, 0, 30, 30);
    popMatrix();

    // Game Title
    fill(255, 215, 0); // Orange
    textFont(titleFont);
    text("Flappy Bird", width / 2, height / 3);

    // Press Space to Start Title
    float alpha = map(sin(time), -1, 1, 40, 255); // Smooth fade in and out Using a Sin wave
    fill(255, 255, 255, alpha); // white
    textSize(25);
    text("Press SPACE to Start", width / 2, (10 * height) / 14);
    time += 0.05;  // Adjust speed of fading
  }


  void drawPlaying() {


    // Draw Pipes
    for (int i = 0; i < pipes.size(); i++) {
      pipes.get(i).drawIt();
    }
    // Draw Bird
    bird.drawIt();


    // Display The Score
    fill(255);
    textSize(20);
    text("Score: " + score, 50, 30);
  }

  void drawGameOver() {
    // Slight blur
    fill(0, 100);
    rect(0, 0, width, height);

    // Game Over Title
    fill(255, 0, 0); // Red
    textFont(titleFont);
    textSize(40);
    text("GAME OVER!", width / 2, height / 5);
    text("----------------", width / 2, height / 5 + 20);

    // Final score Display
    fill(255, 215, 0); // Orange - Yellow
    textSize(25);
    text("YOUR SCORE: " + score, width / 2, height / 3);
    
    
    float alpha = map(sin(time), -1, 1, 40, 255); // Smooth fade in and out Using a Sin wave
    fill(255, 255, 255, alpha); // white
    textSize(25);
    text("Press SPACE to go back", width / 2, (10 * height) / 14);
    text(" To The Main Menu", width / 2, (10 * height) / 14 + 30);
    time += 0.05;  // Adjust speed of fading
  }
  void update() {
    // Update Bird
    bird.update();

    // Adding Pipes
    if (millis() - lastAddPipe > addPipeCooldown) {
      placePipes();
      lastAddPipe = millis();
    }


    // Detect Collisions & Update Score & Remove Unactive Pipes
    for (int i = pipes.size() - 1; i >= 0; i--) {
      pipes.get(i).move();
      if (collision(bird, pipes.get(i)) || bird.y >= height) {
        gameState = GameState.GAME_OVER;
      }
      if (!pipes.get(i).passed && bird.x > pipes.get(i).x + pipes.get(i).pipeWidth) {
        pipes.get(i).passed = true;
        score += 5;
      }
      if (pipes.get(i).x + pipes.get(i).pipeWidth < 0) {
        pipes.remove(i);
        println("Removed pipe, remaining: " + pipes.size());
      }
    }
  }


  void placePipes() {
    int pipeGap = height/4;
    // Top Pipe
    int randomPipeY = (int)(0 - 512/4 - random(0, 1) * (512/2));
    Pipe topPipe = new Pipe(width, randomPipeY, topPipeImg);
    pipes.add(topPipe);

    // Bottom Pipe
    int bottomPipeY = topPipe.y + topPipe.pipeHeight + pipeGap ;
    Pipe bottomPipe = new Pipe(width, bottomPipeY, bottomPipeImg);
    println(bottomPipe.y, topPipe.y + topPipe.pipeHeight, pipeGap);
    pipes.add(bottomPipe);
  }

  boolean collision(Bird a, Pipe b) {
    int padding = 5;
    return
      a.x + padding < b.x + b.pipeWidth - padding && // a's left side is before b's right side
      a.x + a.birdWidth - padding > b.x + padding &&  // a's right side is past b's left side
      a.y + padding < b.y + b.pipeHeight - padding && // a's top side is before b's bottom side
      a.y + a.birdHeight - padding > b.y + padding;  // a's bottom side is past b's top side
  }


  void disposeGame() {
    bird = null; // Remove the bird
    pipes.clear(); // Clear all pipes
    score = 0; // Reset score
    println("Game disposed!");
  }

  void handleKey(int k) {
    if (k == 32  && canJump && gameState == GameState.PLAYING) {  // Space key
      bird.flap();
      canJump = false;
    } else if (k == 32 && gameState == GameState.MENU) {
      createNewGame();
      gameState = GameState.PLAYING;
    } else if (k == 32 && gameState == GameState.GAME_OVER) {
      disposeGame();
      gameState = GameState.MENU;
    }
  }
}
