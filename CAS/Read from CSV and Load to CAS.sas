 /* Reading Straight from a CSV file and making available to CAS 
    Note: PROMOTE=YES                                               
    Will work 1st time then will fail if you try and re-run as a GLOBAl table exists which is why you need the replace */

proc import file='/var/www/html/venn/ALCOHOL_DEMAND_2017.csv' out=public.alcohol_demand_Csv(promote=yes) replace;
run;
