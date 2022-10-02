// Genetic algorithm -->  Based and inspired from Daniel Shiffman's The Nature of code book
// https://natureofcode.com/book/chapter-9-the-evolution-of-code/


// setup
// 1 - initialize --> Create a population of N elements, each with randomly generated DNA
// 2 --> Selection. Evaluate the fitness of each element of the population and build a mating pool.
// 3 --> Reproduction:
//   a --> Pick two parents with probability according to relative fitness
//   b --> Crossover - create a child by combining the DNA of these two parents
//   c --> Mutation - mutate the child's DNA based on a given probability
//   d --> add the new child to a new population
// 4 --> Replace the old population with the new population and return to step 2


DNA [] population;
String target = "to be or not to be";
String closest = "";

float mutationRate = 0.01;
int totalPopulation = 200;

float highscore = 0;
float averageFitness = 0;
int generations;
String bestPhrase = "";

void setup() {
  size(1200, 800);
  background(0);
  population = new DNA[totalPopulation];
  for(int i = 0; i < population.length; i++) {
    population[i] = new DNA(target.length()); // specify the length of each gene all the genes of each DNA
  }
}

void draw() {
  background(0);
  generations++;
  
  // println("Generations: " + generations);
  for(int i = 0; i < population.length; i++) {
    population[i].fitness();
    
    averageFitness += population[i].fitness;
    
    if(population[i].fitness > highscore) { 
      highscore = population[i].fitness;
      bestPhrase = population[i].getPhrase();
      // println(population[i].getPhrase());
    } 
  }
  averageFitness = averageFitness / population.length;
  
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  // TODO --> Use Monte Carlo method for the mating pool
  for(int i = 0; i < population.length; i++) {
    int n = int(population[i].fitness * 100);
    for(int j = 0; j < n; j++) {
      matingPool.add(population[i]);
    }
  }
  
  for(int i = 0; i < population.length; i++) {
    // TODO --> fix so a and b can't be the same parent (is it worth it?)
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    
    DNA parentA = matingPool.get(a);
    DNA parentB = matingPool.get(b);
    
    DNA child = parentA.crossover(parentB);
    child.mutate(mutationRate);
    
    population[i] = child;
  }
  
  // println(highscore);
  fill(0, 255, 255);
  textSize(10);
  text("Generations: " + generations  + "  -  Average fitness: " + averageFitness, width / 2, 10);
  textSize(20); 
  textAlign(CENTER);
  text("I coded a Genetic Algorithm \n to send you a message:", width / 2, 50);
  
  
  textSize(50);
  stroke(180);
  line(0,height/ 2 - 100, width, height / 2 - 100);

  line(0,height/ 2 + 100, width, height / 2 + 100);
  
  text(bestPhrase, width / 2, height / 2);
  
  fill(255);
  // fill(noise(0.1), noise(0.1), noise(0.1));
  ellipse(mouseX, mouseY, 10, 10);
  
}
