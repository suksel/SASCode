/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

cas; 
caslib _all_ assign;

proc cas;

 /* Might need to assume SuperUser role" */
accessControl.assumeRole /
      adminRole="SuperUser";

table.tableInfo /
      caslib="Public"
      name="SEL_PRDSALE";

table.tableDetails /
      caslib="Public"
      name="SEL_PRDSALE";

table.columnInfo /
      table={caslib="Public",name="SEL_PRDSALE"};

run;