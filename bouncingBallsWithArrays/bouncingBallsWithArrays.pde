// State Variables Demo
// Sept 28, 2017

//globals
float buttonX, buttonY, buttonWidth, buttonHeight;
float buttonTop, buttonBottom, buttonLeftSide, buttonRightSide;
float[] ballX, ballY, ballSize, dxBall, dyBall;
color[] ballColor;
int numberOfBalls;
int state;
int bounceCounter;

void setup() {
  //size(800, 800);
  fullScreen();

  state = 0;
  bounceCounter = 0;
  numberOfBalls = 50;

  //declare where the button should be
  buttonX = 100;
  buttonY = 300;
  buttonWidth = 600;
  buttonHeight = 200;

  //calculate sides of button
  buttonTop = buttonY;
  buttonBottom = buttonY + buttonHeight;
  buttonLeftSide = buttonX;
  buttonRightSide = buttonX + buttonWidth;

  //make space in ram for the arrays
  ballX = new float[numberOfBalls];
  ballY = new float[numberOfBalls];
  ballSize = new float[numberOfBalls];
  dxBall = new float[numberOfBalls];
  dyBall = new float[numberOfBalls];
  ballColor = new color[numberOfBalls];

  //set values for ball
  for (int counter=0; counter<numberOfBalls; counter++) {
    ballX[counter] = width/2;
    ballY[counter] = height/2;
    ballSize[counter] = random(10, 100);
    dxBall[counter] = random(-10, 10);
    dyBall[counter] = random(-10, 10);
    ballColor[counter] = color(random(255), random(255), random(255), random(255));
  }
}

void draw() {
  background(255);
  if (state == 0) {  //start screen
    displayButton();
  } else if (state == 1) {  //bouncing ball part
    bounceBall();
    //checkIfGameDone();
  } else if (state == 2) {  //ending screen
    endingScreen();
  }
}

void endingScreen() {
  background(0);
  fill(255);
  textSize(72);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2);

  textSize(30);
  text("Press any key to reset the game", width/2, height/2 + 75);
}

void checkIfGameDone() {
  if (bounceCounter >= 10) {
    state = 2;
  }
}

void bounceBall() {
  for (int i=0; i<numberOfBalls; i++) {
    //move ball
    ballX[i] += dxBall[i];
    ballY[i] += dyBall[i];

    bounceIfRequired(i);
    displayBounces();

    //display ball
    noStroke();
    fill(ballColor[i]);
    ellipse(ballX[i], ballY[i], ballSize[i], ballSize[i]);
  }
}

void displayBounces() {
  textAlign(LEFT);
  textSize(32);
  text(bounceCounter, 25, 50);
}

void bounceIfRequired(int ballNumber) {
  //is it hitting the right or left side?
  if ( (ballX[ballNumber] > width - ballSize[ballNumber]/2) || (ballX[ballNumber] < 0 + ballSize[ballNumber]/2) ) {
    dxBall[ballNumber] *= -1;
    bounceCounter++;
  }

  //is it hitting the top or bottom?
  if ( (ballY[ballNumber] > height - ballSize[ballNumber]/2) || (ballY[ballNumber] < 0 + ballSize[ballNumber]/2) ) {
    dyBall[ballNumber] *= -1;
    bounceCounter++;
  }
}

boolean mouseIsOnButton() {
  return ((mouseX > buttonLeftSide) &&
    (mouseX < buttonRightSide) &&
    (mouseY > buttonTop) &&
    (mouseY < buttonBottom));
}

void displayButton() {
  if (mouseIsOnButton() ) {
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
}

void mousePressed() {
  if (mouseIsOnButton()) {
    background(255);
    state = 1;
  }
}

void keyPressed() {
  if (state == 2) { //if on ending screen
    state = 0;
    bounceCounter = 0;
  }
}