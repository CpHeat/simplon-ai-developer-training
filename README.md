Tracking my progress throughout the Simplon AI Developer training week by week  
  
  
WEEK 1:  
Teacher: [Sengsathit](https://github.com/Sengsathit)  
  
Training program presentation, Python refresher course, UML concept introduction  
  
Miniprojects:  
library (with command line controls)  
hangman game  
  
Bonus:  
Unified Modeling Language presentation (with [CSAADZIDI](https://github.com/CSAADZIDI) & [aruide](https://github.com/aruide))  
  
  
WEEK 2:  
Teacher: Salsabil  
  
Linux/VM command line, Pandas & PostgreSQL introduction/exercises  
  
Miniproject:  
Chose and play with a dataset from kaggle  
  
Personal sidework: setting up an Ubuntu/Windows 11 dual boot, dockerizing PostgreSQL to carry databases between the two, PowerBI introductory course  
  
  
WEEK 3-4:  
Teacher: [Sengsathit](https://github.com/Sengsathit)  
  
Git introduction, group project for the next 2 weeks  
  
Miniprojects:  
defi-git (learn to work on a git repo together)  
casse-tete (learn how to deal with conflicts)  
  
Group project (with [CSAADZIDI](https://github.com/CSAADZIDI) & [aruide](https://github.com/aruide)):

Wa-Tor

The goal is to emulate an ecosystem of sharks and fishes, where sharks eat the fishes if they are next to them, and fishes avoid them if they can. Each species will reproduce if they live long enough. Everything will be output in a Python interface

GOALS:
- Create the algorithms that dictates the fishes/sharks nbehavior
- Create an interface for the user to interact with
- Manage persistence (simulations history)
- Work together through Git

What we ended up with:
- Fully functional simulation
- Interface with simulation output, simulation parameters inputs, resizable grid, real-time counters, history, pause/resume/cycle through previous turns..
- Fully operational persistence through PostgreSQL in 3 tables: one for the simulation parameters and output, one for the state of each turn of the simulation, one for every entities that existed inside that simulation
- A PowerBI desktop model using that databse to show multiple metrics, globally and/or related to one simulation/parameter