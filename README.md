# genetic-algorithm-racket
in genetic_algorithm.rkt is defined a struct called genetic-env. The genetic environment is characterized by
- The size of the population.
- A function that generates an initial population.
- A mutation function, defining how a chromosome can be modified by a mutation.
- A crossover function, defining how chromosomes are combined in reproduction.
- A selection function, that picks two individuals from the population, that will survive and maybe reproduce. It should reflect the fact that a better individual is "good" the more is the probability to be picked. 
- A fitness function, the function to be optimized, from a chromosome to a real. The function reflects what means to be a "good" individual.
- A stop condition, function of previous best fitness, current best fitness, and step. It could be extended to take in input also the population, since similarity between individuals is informative for convergence.

The function genetic takes in input a genetic environment and returns a solution.
There is also an example with a very simple objective function (you'll never use a genetic algorithm for a problem like that)

TODO knapsac problem
