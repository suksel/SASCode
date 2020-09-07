*****************************************************************************
* Version 1 - Reading data from Bank of England Web-Site                    *
*                                               Steve Ludlow - August 2014  *
*****************************************************************************
;

 /* Temporary File used to input into URL */
filename in temp; 
 /* Output File used to create CSV - could get creative and use input values? */
filename out 'boe.csv';

 /* Sets up string to be passed to URL */
 /* Dates - seem a little strange - perhaps didnt like the Jan1 1960? */
data _null_; 
file in; 
input; 
put _infile_;
datalines4;
csv.x=yes&Datefrom=01/Jan/1980&Dateto=30/Nov/2019&SeriesCodes=XUMAGPS,XUMAUSS,XUMAERS&CSVF=TN&UsingCodes=Y&VPD=Y&VFD=N
;;;;
run;

 /* Simple HTTP call with string above passed to Proxy Server 
    Note proxy server and proxyport */
proc http url="http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?"
  in=in 
  out=out 
  method="post"
  proxyhost="inetgw.fyi.sas.com"
  proxyport=80
;
run;

/* Nine is in AUTOEXEC file */
data nine.boe;
 infile out firstobs=2 dlm=',' missover;
 input date date11. xumagps xumauss xumaers;
 label xumagps='Monthly average - Gold price against Sterling'
       xumauss='Monthly average Spot exchange rate, US$ into Sterling'
	   xumaers='Monthly average Spot exchange rate, Euro into Sterling'
       date='Date'
;
 
 format date date11.;
run; 
