/* The pid is basically the pid of the process you want trace of. Here it assumes that 147 is Safari's pid */
pid147::malloc:entry { 
  @total = sum(arg0) 
}