******************************************************************************************
* Time-Series generation program                                                         *
* Specify:                                                                               *
*            sales = Name - Variable and Data Set                                        *
*            Start Date = something like 01Jan14                                         *
*            End Date = end date like 01Jan17                                            *
*            Interval = day, weekday, week, month, month2. etc.                          *
*            Starting Value = Starting value                                             *
*            Percent rise or decline over whole period                                   *
*            Quarter on Promo                                                            *
*            Percent Rise when on Promo                                                  *
*                                                                                        *
*  Specify 0 Percent for a slightly fluctuating series around your starting point        *
*  Specify 0 for Percent Rise on Promo for it not to be on Promo                         *
*                                                                                        *
*  Creates a WORK. SAS Table with the name you choose                                    *
*                                                                                        *
*                                                                                        *
*                                             Version 0.1 Steve Ludlow SAS UK 07Apr2017  *
******************************************************************************************
;

%macro time_genr(var,start,end,interval,value,perc,qtr,qtrperc);
data &var;
 /* Start Value */
 start_value=input("&value",8.);
 /* End Value - based on Start Value and Percentage Change */
 /* Converting &PERC to suitable multiplier */
 ev=start_value*(&perc/100); 
 /* Jend holds number of periods between start and end - Use intck to work out how many intervals */
 jend=intck("&interval","&start"d,"&end"d);
 do j=0 to jend;
    do date="&start"d to "&end"d by intnx("&interval","&start"d,j);
    date=intnx("&interval","&start"d,j);
    /* Calculate some date variables */
    week=week(date); qtr=qtr(date); year=year(date); month=month(date); day=day(date);
    /* &var = Start_value = 100
            rannor(2) = Value from @ -2.2 to + 2.2
            Start_value/10 = 10% per year
            i+1 is a great counter from the start of the loop to the end
            y/jend * ev = (counter / number of intervals) * end_value 
            + sign gives growth - while - sign gives decline

          A normal variate X with mean MU and variance S2 can be generated with this code: 
          x =MU+sqrt(S2)*rannor(seed);      
    MAY want to multiply the rannor(2) by a value that is suitable to size of initial starting point - some form of sqrt
	*/
    i+1;
    y=i;
	std=std(start_value,ev);
    &var=start_value+(sqrt(std)*rannor(2)) + ((y/jend)*ev);
     /* Modifications based on Quarter or Month or Week  */
    if qtr=&qtr then do;
       &var=&var+ (&var*(&qtrperc/100));
    end;
 *if month in (4,5,6) then &var=&var*1.2;
    output;
    end;
 end;

 drop i y start_value ev jend j ;
 format date weekdate23. &var 8.1;
 label qtr='Quarter'
      date='Date'
	  jend='Number of Intervals'
	  month='Month'
	  &var="&var"
	  start_value='Starting Value'
	  week='Week'
	  year='Year'
	  day='Day'
	  ;
 run;

proc timeseries plot=series;
  var &var;
  id date interval=&interval;
run;
%mend time_genr;

 /* Specify 
            Name - Variable and Data Set less than 8 characters!
            Start Date = something like 01Jan14
            End Date = end date like 01Jan17
            Interval = day, weekday, week, month, month2. etc.
            Starting Value = Starting value
            Percent rise or decline per year 
            Quarter on Promo
            Percent Rise when on Promo

Specify 0 Percent for a slightly fluctuating series around your starting point 
Specify 0 for Percent Rise on Promo for it not to be on Promo

TO DO:
   Could obviously do the promo rise by month 
   Check the series fluctuation with the square root of the std of the start and end value
   Works for single series- change name and can then merge to get more series for same period and periodicity
*/

%time_genr(Pop,01Jan15,01Jan19,week,100,20,2,20);




