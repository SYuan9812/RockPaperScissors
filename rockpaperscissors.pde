//-------------GLOBAL STATE---------------------------------------
int gameState = 0; //0 = welcome, 1 = choosing, 2 = result
boolean space = false;
String playerChoice = "";
String computerChoice = "";
String resultMessage = "";
int playerScore = 0, computerScore = 0;
PImage bg1;
PImage bg2;
PImage bg3;

//Screen 1 Button positions
float by = 266;
float bw = 120, bh = 60;
float rockX = 100, paperX = 330, scissorX = 560;

//Screen 2 Button positions
float AgainButtonW = 120, AgainButtonH = 60;
float AgainButtonX;
float AgainButtonY = 510;
float ExitButtonW = 30, ExitButtonH = 30;
float ExitButtonX;
float ExitButtonY = 10;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  AgainButtonX = width/2 - AgainButtonW/2;
  ExitButtonX = width - 40;
  bg1 = loadImage("c:\\data\\bg1.jpg");
  bg2 = loadImage("c:\\data\\bg2.jpg");
  bg3 = loadImage("c:\\data\\bg3.jpg");
  bg1.resize(800, 600);
  bg2.resize(800, 600);
  bg3.resize(800, 600);
}

void draw() {
  background(240);//one value = gray scale
  switch (gameState){
    case 0:
      renderWelcome();
      break;
    case 1:
      renderChoiceScreen();
      break;
    case 2:
      renderResultScreen();
      break;
  }
}

//----------------SCREEN 1: WELCOME--------------------------------
void renderWelcome() {
  image(bg1, 0, 0, 800, 600);
  textSize(48);
  fill(120);
  text("Rock-Paper-Scissors", width/2, 50);
  text("Press SPACE to start", width/2, 550);
  textSize(18);
  text("Your Score: " + playerScore + "  Computer Score: " + computerScore, width - 140, height/2);
  drawButton(ExitButtonX, ExitButtonY, ExitButtonW, ExitButtonH, "X");
}

void keyPressed() {
  if (key == ' ' && gameState == 0) {
    gameState = 1;
  }
}

//----------------SCREEN 2: CHOICE---------------------------------
void renderChoiceScreen() {
  image(bg2, 0, 0, 800, 600);
  fill(0);
  textSize(48);
  text("Choose your move:", width/2, 50);
  drawButton(rockX, by, bw, bh, "Rock");
  drawButton(paperX, by, bw, bh, "Paper");
  drawButton(scissorX, by, bw, bh, "Scissors");
  textSize(18);
  fill(0);
  text("Your Score: " + playerScore + "  Computer Score: " + computerScore, width - 140, height - 50);
  drawButton(ExitButtonX, ExitButtonY, ExitButtonW, ExitButtonH, "X");
}

void drawButton(float x, float y, float w, float h, String label) {
  fill(100, 120, 255);
  rect(x, y, w, h, 10);
  fill(255);
  textSize(18);
  text(label, x + w/2, y + h/2);
}

boolean isInsideButton(float mx, float my, float x, float y, float bw, float bh) {
  return mx >= x && mx <= x + bw && my >= y && my <= y + bh;
}

//Built in Processing function that works like event listener for mouse events MOUSE PRESSED
void mousePressed() {
  if(gameState == 1){
    if(isInsideButton(mouseX, mouseY, rockX, by, bw, bh)) {
      playerChoice = "rock";
      playGame();
    } else if (isInsideButton(mouseX, mouseY, paperX, by, bw, bh)) {
      playerChoice = "paper";
      playGame();
    } else if (isInsideButton(mouseX, mouseY, scissorX, by, bw, bh)) {
      playerChoice = "scissors";
      playGame();
    }
  } else if (gameState == 2) {
      if(isInsideButton(mouseX, mouseY, AgainButtonX, AgainButtonY, AgainButtonW, AgainButtonH)) {
        newGame();
      }
  }
  
  if(isInsideButton(mouseX, mouseY, ExitButtonX, ExitButtonY, ExitButtonW, ExitButtonH)) {
    exit();
  }
}



void newGame() {
  gameState = 1;
  playerChoice = "";
  computerChoice = "";
  resultMessage = "";
}

void playGame() {
  String[] options = {"rock", "paper", "scissors"};
  computerChoice = options[(int) random(options.length)]; 
  //(int) = casting double output of random() into int type
  if (playerChoice.equals(computerChoice)) {
    resultMessage = "It's a tie";
  } else if ((playerChoice.equals("rock") && computerChoice.equals("scissors")) || 
    (playerChoice.equals("paper") && computerChoice.equals("rock")) ||
    (playerChoice.equals("scissors") && computerChoice.equals("paper"))
    ) {
      resultMessage = "You win!";
      playerScore++;
  } else {
      resultMessage = "You lose!";
      computerScore++;
    }
  
  gameState = 2;
}

//-------------------------Screen 3: Results-----------------------
void renderResultScreen() {
  image(bg3, 0, 0, 800, 600);
  textSize(48);
  fill(0);
  text("You chose: " + playerChoice, width/2, 50);
  text("Computer chose: " + computerChoice, width/2, 100);
  text(resultMessage, width/2, 450);
  textSize(18);
  text("Your Score: " + playerScore + "  Computer Score: " + computerScore, width - 140, height - 50);
  drawButton(ExitButtonX, ExitButtonY, ExitButtonW, ExitButtonH, "X");
  
  drawButton(AgainButtonX, AgainButtonY, AgainButtonW, AgainButtonH, "Play Again");
}
  
