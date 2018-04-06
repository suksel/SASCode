*********************************************
* Are formats Global or Local               *
*********************************************
;

cas casauto;
proc cas;
   session casauto;
   sessionProp.listFmtSearch;
run;
quit;
