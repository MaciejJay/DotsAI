Population test;
PVector goal = new PVector(400, 20);
PVector stationary = new PVector(400, 400);

void setup() {
  size(800, 800);
  test = new Population(1000);
}

void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  fill(0, 0, 255);
  rect(0, 200, 600, 40);
  
  fill(0, 0, 255);
  rect(200, 600, 600, 40);

  if (test.isAllDotsDead()) {
    test.calculateFitness();
    test.selection();
    test.mutation();
  } else {
    test.update();
    test.show();
  }
}
