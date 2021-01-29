 /* Location of the Country Code data on github - note the RAW bit */
%let githubRoot=https://raw.githubusercontent.com/datasets/airport-codes/master/data;


 /* temp location for CSV files, works on UNIX or Windows */
%let csvOut = %sysfunc(getoption(WORK));

filename air "&csvOut./airport-codes.csv";

proc http method="get"
 url="&githubroot./airport-codes.csv"
 out=air
 ;
run;

proc import file=air out=airports dbms=csv replace;
guessingrows=max;
run;

filename air clear;

libname airports 'c:\demo data\airports';

data airports.air;
 set airports;
 label ident='Identity'
 type='Airport Type'
 name='Airport Name'
 latitude_deg='Latitude'
 longitude_deg='Longitude'
 elevation_ft='Elevation in Feet'
 continent='Continent'
 iso_country='ISO Country'
 iso_region='ISO Region'
 municipality='Municipality'
 gps_code='GPS Code'
 iata_code='IATA Code'
 local_code='Local Code'
 ;
run;

data airports.uk;
 set airports.air;
 if iso_country='GB'
 ;
run;
