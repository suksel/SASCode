cas; 
caslib _all_ assign;


/* Not sure why this was needed but was in the Original Sample
Removed the link to the Certificate as not needed in our example 
 Take values from here:
https://stats.oecd.org/SDMX-JSON/data/CSPCUBE/EVOPOP_T1.FRA+DEU+IRL+GBR/all?startTime=2013&endTime=2017&dimensionAtObservation=allDimensions&pid=1764c024-13a1-41ad-9fb8-4114886a31f0
*/
options validvarname=any;
title 'Retrieve Population Data for Australia, Japan, Germany, UK';

/* Location for final OECD table */
*libname mylib "c:\data\OECD";

/* specify selection keys; key0 is the time series */
data keylist0;
	/* Note change to Length here */
	length key0 $9;
	key0='EVOPOP_T1';
	output;
run;

/* select France, Germany, Ireland and UK (GBR); key1 is country */
data keylist1;
	/* See Step 4 */
	length key1 $3;
	key1='FRA';
	output;
	key1='DEU';
	output;
	key1='IRL';
	output;
	/* Added in GBR here */
	key1='GBR';
	output;
run;

title1 "Population Data from OECD";
title2 "Request Population Data for These Countries: FRA, DEU, IRL, GBR";
libname oecd saseoecd "." setid=CSPCUBE inset0=keylist0 inset1=keylist1 
	 out=POP start='2013' end='2017';

data public.POP;
	set oecd.POP;
	/* POP is specified in the OUT= option */
	date_sas=mdy(1,1,date);
	format date_sas year.;
	label date='Date' date_sas='SAS Date';
run;

title3 "The public.POP Data Set";

proc print data=public.POP label;
run;