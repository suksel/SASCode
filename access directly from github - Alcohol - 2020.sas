filename _inbox "%sysfunc(getoption(work))/alcohol_demand_2020.sas7bdat";
 
proc http method="get" 
 url="https://github.com/suksel/SASData/raw/master/Alcohol%20Demand/alcohol_demand_2020.sas7bdat" 
 out=_inbox
 /* proxyhost="http://yourproxy.company.com" */
;
run;
 
filename _inbox clear;
 
proc contents data=work.alcohol_demand_2020;
run;
