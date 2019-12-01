class Brain {
  PVector[] directions;
  int step = 0;

  Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  void randomize() {
    for (int i = 0; i < directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }

  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }
    return clone;
  }

  void mutate() {
    float mutationRate = 0.01;
    for (int i = 0; i < directions.length; i++) {
      float random = random(1);
      if (random < mutationRate) {
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
