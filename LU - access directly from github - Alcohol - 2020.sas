filename _inbox "%sysfunc(getoption(work))/alcohol_demand_2020.sas7bdat";
 
proc http method="get" 
 url="https://github.com/suksel/SASData/raw/master/Alcohol%20Demand/alcohol_demand_2020.sas7bdat" 
 out=_inbox
 /* proxyhost="http://yourproxy.company.com" */
;
run;
 
filename _inbox clear;
 
cas; 
caslib _all_ assign;

proc casutil;
   droptable casdata="ALCOHOL_DEMAND_2020" incaslib="public" quiet;
   load data=work.alcohol_demand_2020 outcaslib="public" casout="ALCOHOL_DEMAND_2020" promote;
   save casdata="ALCOHOL_DEMAND_2020" incaslib="public" outcaslib="public"	casout="ALCOHOL_DEMAND_2020.sashdat" replace;
quit;