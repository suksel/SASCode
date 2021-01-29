************************************************************************
* After assigning the LIBNAME ONS_SAS                                  *
*                                                                      *
* This takes the JSON Table LINKS_LATEST_VERSION and makes a permanent *
*  copy in the ONS_SAS folder pointed to by the LIBNAME statement      *
***********************************************************************;

 /* Get a list of available datasets */

proc http url="https://api.beta.ons.gov.uk/v1/datasets" out=resp;
run;

 /* RESP is in json format */

libname dataset JSON fileref=resp;

 /* Copy all of them to permanent datasets */
proc datasets lib=dataset nolist; 
 copy out=ons_sas;
run;


 /* As we create the SAS permanent table then add some useful values which we can call in the UI 
    WE NEED to check here 45 records from each table - we should rename and MERGE properly */
data ons_sas.TASK_FINAL;
 merge ons_sas.LINKS_LATEST_VERSION ons_sas.ITEMS ; 
 /* Just for CPI and Population figures */
 if id in('cp','mi');
run;

/* For the Consumer Price Index */
/* So lets see whats in the aggregate dimension - by putting a * should break down by these */
 /* Currently there are 141 of these at JUL-20 */
proc http url="https://api.beta.ons.gov.uk/v1/datasets/cpih01/editions/time-series/versions/36/observations?time=Jul-20&geography=K02000001&aggregate=*" 
		out=resp2;
	debug level=1;
run;

/* Copying Tables to Permanent SAS DataSets so we can use them */
libname aggR JSON fileref=resp2;

proc datasets lib=aggR nolist;
	copy out=aggr_out;
run;

/* and in the ONS_SAS library we need 2 variables from the AGG_OUT.DIMENSIONS_AGGREGATE */

data ons_sas.dimensions_aggregate;
 set aggr_out.dimensions_aggregate;
run;
