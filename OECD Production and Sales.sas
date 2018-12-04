/* Not sure why this was needed but was in the Original Sample
Removed the link to the Certificate as not needed in our example
Take values from here:

https://stats.oecd.org/SDMX-JSON/data/MEI/IRL+GBR.SLRTTO01+SLRTTO02+SLRTCR03+SPASTT01.ST+STSA+IXOB+IXOBSA+ML+MLSA.M
/all?startTime=2015-01&endTime=2019-04&dimensionAtObservation=allDimensions&pid=1764c024-13a1-41ad-9fb8-4114886a31f0

*/
options validvarname=any;
title 'Retrieve Main Production and Sales Data for UK and Ireland';

/* Location for final OECD table */
libname mylib "c:\data\OECD";

/* specify selection keys; key0 is the time series */
data keylist0;
	/* Note change to Length here */
	length key0 $3;
	key0='GBR';
	output;
run;

/* select SLRTTO01+SLRTTO02+SLRTCR03+SPASTT01 */
data keylist1;
	length key1 $8;
	key1='SLRTTO01';
	output;
	key1='SLRTTO02';
	output;
	key1='SLRTCR03';
	output;
	key1='SPASTT01';
	output;
run;

/* select ST+STSA+IXOB+IXOBSA+ML+MLSA */
data keylist2;
	length key2 $6;
	key2='ST';
	output;
	key2='STSA';
	output;
	key2='IXOB';
	output;
	key2='IXOBSA';
	output;
	key2='ML';
	output;
	key2='MLSA';
	output;
run;

/* select monthly data; key2 is frequency */
/* Note remember to use key3 not key2 !!!! if copying */
data keylist3;
	length key3 $2;
	key3='M';
	output;
run;

title1 "production and Sales Data from OECD";
title2 "Request Production and Sales Data for These Countries: IRL and GBR";
libname oecd saseoecd "c:\temp" setid=MEI inset0=keylist0 inset1=keylist1 
	inset2=keylist2 inset3=keylist3 out=PR_SALES start='2015-01' end='2018-10';

data mylib.PR_SALES;
	set oecd.PR_SALES;
	date_sas=input(date, anydtdte.);

	/* RENAME Section */
	gbr_retail_trade_vol='GBR.SLRTTO01.IXOBSA.M'n;
	gbr_retail_trade_val='GBR.SLRTTO02.IXOB.M'n;
	gbr_retail_trade_val_sa='GBR.SLRTTO02.IXOBSA.M'n;
	gbr_retail_trade_car_reg='GBR.SLRTCR03.ML.M'n;
	gbr_retail_trade_car_sa='GBR.SLRTCR03.MLSA.M'n;
	gbr_allshares='GBR.SPASTT01.IXOB.M'n;
	format date_sas monyy.;
	label date='Date' date_sas='SAS Date' 
		gbr_retail_trade_vol='GBR Total Retail Trade (Volume) sa (2015=100)' 
		gbr_retail_trade_val='GBR Total Retail Trade (Value) (2015=100)' 
		gbr_retail_trade_val_sa='GBR Total Retail Trade (Value) sa (2015=100)' 
		gbr_retail_trade_car_reg='GBR Car Registration (Passenger Cars)' 
		gbr_retail_trade_car_sa='GBR Car Registration (Passenger Cars) sa (000s)' 
		gbr_allshares='GBR All Shares (2015=100)';
	drop 'GBR.SLRTTO01.IXOBSA.M'n 'GBR.SLRTTO02.IXOB.M'n 'GBR.SLRTTO02.IXOBSA.M'n 
		'GBR.SLRTCR03.ML.M'n 'GBR.SLRTCR03.MLSA.M'n 'GBR.SPASTT01.IXOB.M'n;
run;

title3 "The mylib.PR_SALES Data Set";

proc print data=mylib.PR_SALES label;
run;