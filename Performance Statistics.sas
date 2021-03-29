/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

cas; 
caslib _all_ assign;

data public.cars(promote=yes);;
 set sashelp.cars;
run;
	

proc cas;
simple.summary /
      table={caslib="Public",name="CARS"};

  setsessopt / metrics=true; run;

print _perf;
run;