data regdata;
    /* Random number seed */
    call streaminit(112358);
     /* Keep only variables that are needed */
    keep x1-x4 y;
     /* Set the values for the intercep and slope parameters */
    b0=4;
    b1=0.8;
    b2=1.2;
    b3=2.4;
    b4=-1.2;
      /* Do Loop tells SAS to perform 100 iterations */
    do i=1 to 100;
        /*Explanatory variables - sampled from a Univariate Normal Distribution 
          Rand function - generates the data, NORMAL - implies Normal Distribution
          Mean and Standard Deviation are the 2 parameters 
          Epsilon is a random error term
          
        */
        x1=rand('NORMAL', 5, 0.5);
        x2=rand('NORMAL', 8, 0.3);
        x3=rand('NORMAL', 6, 0.1);
        x4=rand('NORMAL', 2, 0.3);
        epsilon=rand('NORMAL', 6, 0.1);
        y=b0 + b1*x1 + b2*x2 + b3*x3 + b4*x4 + epsilon;
        output;
    end;
run;

proc print ;
run;