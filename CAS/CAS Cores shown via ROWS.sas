cas;

options ls=100;
proc cas;
output log;
  /* Number of rows will be number of cores */
runcode/code='data a; x = 42; run;';
  /* Number of rows will be number of workers - SMP=1 - MPP=number of workers */ 
runcode/code='data b; x = 42; run;' nthreads=1;
  /* Number of rows will be in a single thread */
runcode/code='data c; x = 42; run;' single='yes';

tableinfo;
quit;
