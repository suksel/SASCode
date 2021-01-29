***********************************************************************************
* From Chris Hemedingers blog                                                     *
***********************************************************************************;

/* Use the IFC function as a shorthand for if-then, returning a character string */
/* Windows path first then Linux */
%let tgtpath = %sysfunc(ifc(&SYSSCP. = WIN,c:\data,/data));
 
libname tgt "&tgtpath.";