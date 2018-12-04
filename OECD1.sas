/* Not sure why this was needed but was in the Original Sample
Removed the link to the Certificate as not needed in our example */
options validvarname=any;
title 'Retrieve MEI_CLI Data for Australia, Japan, Germany, UK';

/* Location for final OECD table */
libname mylib "c:\data\OECD";

/* specify selection keys; key0 is the time series */
data keylist0;
	/* See Step 3 */
	length key0 $8;
	key0='CSCICP03';
	output;
run;

/* select Australia, Japan, Germany and UK (GBR); key1 is country */
data keylist1;
	/* See Step 4 */
	length key1 $3;
	key1='AUS';
	output;
	key1='JPN';
	output;
	key1='DEU';
	output;

	/* Added in GBR here */
	key1='GBR';
	output;
run;

/* select monthly data; key2 is frequency */
data keylist2;
	/* See Step 5 */
	length key2 $2;
	key2='M';
	output;
run;

title1 "Main Economic Indicators Database from the OECD";
title2 "Request MEI_CLI for These Countries: AUS, JPN, DEU, GBR";
libname oecd saseoecd "c:\temp" setid=MEI_CLI inset0=keylist0 inset1=keylist1 
	inset2=keylist2 out=MEI3C start='2015-09' end='2017-08';

data mylib.MEI3c;
	set oecd.MEI3C;
	/* MEI3C is specified in the OUT= option */
	date_sas=input(date, anydtdte.);
	format date_sas monyy.;
	label date='Date' date_sas='SAS Date';
run;

title3 "The mylib.myMEI Data Set";

proc print data=mylib.MEI3c label;
run;