filename cars temp;                                   
filename iris temp;
 
proc http                                                  
   url="http://support.sas.com/documentation/onlinedoc/viya/exampledatasets/cars.csv"
   out=cars;
run;
quit;
 
proc http
   url="http://support.sas.com/documentation/onlinedoc/viya/exampledatasets/iris.csv"
   out=iris;
run;
quit;

proc cas;                                                    
      upload path="%sysfunc(pathname(cars))" 
           importOptions={fileType="csv"} 
           casout={name="cars" replace=true};
run;
      upload path="%sysfunc(pathname(iris))" 
           importOptions={fileType="csv"} 
           casout={name="iris" replace=true};
run;
quit;

filename cars clear;                               
filename iris clear;