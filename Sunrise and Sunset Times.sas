/******************************************************************************/
/* program to calculate sunrise and sunset times                              */
/*  Colin Gray                                                                */
/* ****************************************************************************/
;

data;
input location $ latitude longitude timezone dst;
array sun{0:1} sunset sunrise;
pi = arcos(-1);
radian = pi/180;
phi = latitude*radian;
lambda = longitude/15;
date = "11AUG2017"d;
n = date-intnx('year',date,0) +1;
do s=0 to 1;
t = n + (18 -12*s-lambda)/24;
m = (0.9856*t-3.289)*radian;
l=m+(1.916*sin(m)+.02*sin(2*m)+282.634)*radian;
delta = 0.39782*sin(l);
sun{s} = 3600*(mod(24*((1-2*s)*arcos((-.01454-sin(delta)*sin(phi))/(cos(delta)*cos(phi)))/(2*pi)+s)+12*(atan(0.91746*tan(l))/pi+(mod(floor(l*2/pi)+4,4) in (1,2)))-.06571*t-6.622-lambda+timezone+dst+48,24));
end;
format sunrise sunset timeampm8. date date9.;
keep location date sunrise sunset;
cards;
Kinston 35.363 -77.582 -5 1
London  51.507 0.128 0 1
NewYork 40.713 -74.006 -5 1
Paris   48.857 2.3522  +1 1
;
run;

proc print;run;
