class Population {
  Dot[] dots;
  float fitnessSum;
  int generation = 1;
  int bestParentDot = 0;
  int minSteps = 400;

  Population(int size) {
    dots = new Dot[size];
    for ( int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }

  void show() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[bestParentDot].brain.step > minSteps) {
        dots[i].isDead = true;
      } else {
        dots[i].update();
      }
    }
  }

  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  boolean isAllDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].isDead && !dots[i].isReachedGoal) {
        return false;
      }
    }
    return true;
  }


  void selection() {
    Dot[] newDots = new Dot[dots.length];
    setBestParentDot();
    calculateFitnessSum();

    newDots[0] = dots[bestParentDot].getBestDot();
    newDots[0].isBest = true;

    for (int i = 1; i < newDots.length; i++) {
      Dot parent = selectParent();

      newDots[i] = parent.getBestDot();
    }

    dots = newDots.clone();
    generation++;
  }

  void calculateFitnessSum() {
    fitnessSum = 0;

    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }

  Dot selectParent() {
    float random = random(fitnessSum);
    float runningSum = 0.0;

    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > random) {
        return dots[i];
      }
    }
    //shouldn't get to this point
    return null;
  }


  void mutation() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  void setBestParentDot() {
    float max = 0.0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }

    bestParentDot = maxIndex;

    if (dots[bestParentDot].isReachedGoal) {
      minSteps = dots[bestParentDot].brain.step;
      println("Number of steps: ", minSteps);
    }
  }
}
