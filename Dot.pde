class Dot {

  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean isDead = false;
  boolean isReachedGoal = false;
  boolean isBest = false;

  float fitness = 0.0;

  Dot() {
    brain = new Brain(400);
    pos = new PVector(width/2, height - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void show() {
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void move() {

    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      isDead = true;
    }

    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  void update() {
    if (!isDead && !isReachedGoal) {
      move();
      if (pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2) {
        isDead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
        isReachedGoal = true;
      } else if (pos.x < 600 && pos.y < 240 && pos.x > 0 && pos.y > 200) {
        isDead = true;
      } else if (pos.x < 800 && pos.y < 640 && pos.x > 200 && pos.y > 600) {
        isDead = true;
      }
    }
  }

  void calculateFitness() {
    if (isReachedGoal) {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    }else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  Dot getBestDot() {
    Dot bestDot = new Dot();
    bestDot.brain = brain.clone();
    return bestDot;
  }
}
