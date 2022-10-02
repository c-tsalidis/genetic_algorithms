class DNA {
  char [] genes;
  float fitness;
  
  DNA(int num) {
     genes = new char[num];
    for(int i = 0; i < genes.length; i++) {
      genes[i] = (char) random(32, 128);
    }
  }
  
  void fitness() {
    int score = 0;
    for(int i = 0; i < genes.length; i++) {
      if (genes[i] == target.charAt(i)) {
        score++;
      }
    }
    
    // fitness = float(score) / target.length();
    fitness = score * score;
    // fitness = pow(2, score);
    // fitness = norm(score * score, 0, target.length() * target.length());
    // fitness = map(pow(2, score), 0, target.length(), 0, 1);
    // fitness = norm(pow(2, score), 0, pow(2, target.length()));
  }
  
  DNA crossover(DNA partner) {
    DNA child = new DNA(genes.length);
    
    int midpoint = int(random(genes.length));
    
    // TODO --> Use coin flipping method instead (50% chance of coming from parent A and 50% from parent B)
    for(int i = 0; i < genes.length; i++) {
      if(i > midpoint) child.genes[i] = genes[i];
      else child.genes[i] = partner.genes[i];
    }
    
    return child;
  }
  
  void mutate(float mutationRate) {
    // Looking at each gene in the array
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        // Mutation, a new random character
        genes[i] = (char) random(32,128);
      }
    }
  }
  
  String getPhrase() {
    return new String(genes);
  }
}
